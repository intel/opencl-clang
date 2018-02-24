/*****************************************************************************\

Copyright (c) Intel Corporation (2009-2017).

    INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE.  THIS CODE IS
    LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
    ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL DOES NOT
    PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY
    DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
    PARTICULAR PURPOSE, OR ANY OTHER WARRANTY.  Intel disclaims all liability,
    including liability for infringement of any proprietary rights, relating to
    use of the code. No license, express or implied, by estoppel or otherwise,
    to any intellectual property rights is granted herein.

  \file link.cpp

\*****************************************************************************/

#include "common_clang.h"
#include "binary_result.h"
#include "options.h"

#include "llvm/IR/LLVMContext.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/Linker/Linker.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/Mutex.h"
#include "llvm/Support/raw_ostream.h"

using namespace Intel::OpenCL::ClangFE;
using namespace llvm;

static llvm::ManagedStatic<llvm::sys::SmartMutex<true> > linkMutex;
static llvm::ManagedStatic<llvm::sys::SmartMutex<true> > linkOptionsMutex;

void CommonClangInitialize();

///
// Options parser for the Link function
//
class ClangLinkOptions {
public:
  //
  // Parses the link options, ignoring the missing args
  //
  void processOptions(const char *pszOptions) {
    unsigned missingArgIndex, missingArgCount;
    m_pArgs.reset(
        m_optTbl.ParseArgs(pszOptions, missingArgIndex, missingArgCount));
  }

  //
  // Validates the user supplied OpenCL link options
  //
  bool checkOptions(const char *pszOptions, char *pszUnknownOptions,
                    size_t uiUnknownOptionsSize) {
    // Parse the arguments.
    unsigned missingArgIndex, missingArgCount;
    m_pArgs.reset(
        m_optTbl.ParseArgs(pszOptions, missingArgIndex, missingArgCount));

    // check for options with missing argument error.
    if (missingArgCount) {
      std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
      std::string missingArg(m_pArgs->getArgString(missingArgIndex));
      missingArg.copy(pszUnknownOptions, uiUnknownOptionsSize - 1);
      return false;
    }

    // check for unknown options
    std::string unknownOptions = m_pArgs->getFilteredArgs(OPT_LINK_UNKNOWN);
    if (!unknownOptions.empty()) {
      std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
      unknownOptions.copy(pszUnknownOptions, uiUnknownOptionsSize - 1);
      return false;
    }

    // we do not support input options
    std::string inputOptions = m_pArgs->getFilteredArgs(OPT_LINK_INPUT);
    if (!inputOptions.empty()) {
      std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
      inputOptions.copy(pszUnknownOptions, uiUnknownOptionsSize - 1);
      return false;
    }

    return true;
  }

  bool hasArg(int id) const { return m_pArgs->hasArg(id); }

private:
  OpenCLLinkOptTable m_optTbl;
  std::unique_ptr<OpenCLArgList> m_pArgs;
};

//
// Wrapper around the 'opencl.compiler.options' metadata
//
class SpirOptions {
public:
  SpirOptions(llvm::Module *pModule)
      : m_bDebugInfo(false), m_bProfiling(false), m_bDisableOpt(false),
        m_bFastRelaxedMath(false), m_bDenormsAreZero(false) {
    llvm::NamedMDNode *metadata =
        pModule->getNamedMetadata("opencl.compiler.options");

    if (!metadata || metadata->getNumOperands() == 0)
      return;

    llvm::MDNode *flag = metadata->getOperand(0);
    if (!flag)
      return;

    for (uint32_t i = 0; i < flag->getNumOperands(); ++i) {
      llvm::MDString *flagName =
          llvm::dyn_cast<llvm::MDString>(flag->getOperand(i));
      assert(flagName && "Invalid opencl.compiler.options metadata");

      if (flagName->getString() == "-g")
        setDebugInfoFlag(true);
      else if (flagName->getString() == "-profiling")
        setProfiling(true);
      else if (flagName->getString() == "-cl-opt-disable")
        setDisableOpt(true);
      else if (flagName->getString() == "-cl-fast-relaxed-math")
        setFastRelaxedMath(true);
      else if (flagName->getString() == "-cl-denorms-are-zero")
        setDenormsAreZero(true);
      else
        addOption(flagName->getString());
    }
  }

  bool getDebugInfoFlag() const { return m_bDebugInfo; }
  bool getProfiling() const { return m_bProfiling; }
  bool getDisableOpt() const { return m_bDisableOpt; }
  bool getFastRelaxedMath() const { return m_bFastRelaxedMath; }
  bool getDenormsAreZero() const { return m_bDenormsAreZero; }

  void setDebugInfoFlag(bool value) { setBoolFlag(value, "-g", m_bDebugInfo); }

  void setProfiling(bool value) {
    setBoolFlag(value, "-profiling", m_bProfiling);
  }

  void setDisableOpt(bool value) {
    setBoolFlag(value, "-cl-opt-disable", m_bDisableOpt);
  }

  void setFastRelaxedMath(bool value) {
    setBoolFlag(value, "-cl-fast-relaxed-math", m_bFastRelaxedMath);
  }

  void setDenormsAreZero(bool value) {
    setBoolFlag(value, "-cl-denorms-are-zero", m_bDenormsAreZero);
  }

  void addOption(const std::string &option) {
    if (std::find(m_options.begin(), m_options.end(), option) ==
        m_options.end()) {
      m_options.push_back(option);
    }
  }

  std::list<std::string>::const_iterator beginOptions() const {
    return m_options.begin();
  }

  std::list<std::string>::const_iterator endOptions() const {
    return m_options.end();
  }

  void save(llvm::Module *pModule) {
    // Add build options
    llvm::NamedMDNode *pRoot =
        pModule->getOrInsertNamedMetadata("opencl.compiler.options");
    pRoot->dropAllReferences();

    llvm::SmallVector<llvm::Metadata *, 5> values;
    for (std::list<std::string>::const_iterator it = m_options.begin(),
                                                e = m_options.end();
         it != e; ++it) {
      values.push_back(llvm::MDString::get(pModule->getContext(), *it));
    }
    pRoot->addOperand(llvm::MDNode::get(pModule->getContext(), values));
  }

private:
  void setBoolFlag(bool value, const char *flag, bool &dest) {
    if (value == dest)
      return;

    dest = value;

    if (!value)
      m_options.remove(std::string(flag));
    else
      m_options.push_back(std::string(flag));
  }

private:
  bool m_bDebugInfo;
  bool m_bProfiling;
  bool m_bDisableOpt;
  bool m_bFastRelaxedMath;
  bool m_bDenormsAreZero;
  std::list<std::string> m_options;
};

//
// Helper class for 'opencl.compiler.options' metadata conflict resolution
// during link
//
class MetadataLinker {
public:
  MetadataLinker(const ClangLinkOptions &linkOptions, llvm::Module *pModule)
      : m_effectiveOptions(pModule), m_bDenormsAreZeroLinkOpt(false),
        m_bNoSignedZerosLinkOpt(false), m_bUnsafeMathLinkOpt(false),
        m_bFiniteMathOnlyLinkOpt(false), m_bFastRelaxedMathLinkOpt(false) {
    // get the options specified during link
    m_bEnableLinkOptions = linkOptions.hasArg(OPT_LINK_enable_link_options);
    m_bCreateLibrary = linkOptions.hasArg(OPT_LINK_create_library);
    m_bDenormsAreZeroLinkOpt = linkOptions.hasArg(OPT_LINK_cl_denorms_are_zero);
    m_bNoSignedZerosLinkOpt = linkOptions.hasArg(OPT_LINK_cl_no_signed_zeroes);
    m_bUnsafeMathLinkOpt =
        linkOptions.hasArg(OPT_LINK_cl_unsafe_math_optimizations);
    m_bFiniteMathOnlyLinkOpt = linkOptions.hasArg(OPT_LINK_cl_finite_math_only);
    m_bFastRelaxedMathLinkOpt =
        linkOptions.hasArg(OPT_LINK_cl_fast_relaxed_math);
  }

  void Link(llvm::Module *pModule) {
    // do NOT take the link options overrides into account yet
    SpirOptions options(pModule);

    m_effectiveOptions.setDebugInfoFlag(m_effectiveOptions.getDebugInfoFlag() &
                                        options.getDebugInfoFlag());
    m_effectiveOptions.setProfiling(m_effectiveOptions.getProfiling() &
                                    options.getProfiling());
    m_effectiveOptions.setDisableOpt(m_effectiveOptions.getDisableOpt() |
                                     options.getDisableOpt());
    m_effectiveOptions.setFastRelaxedMath(
        m_effectiveOptions.getFastRelaxedMath() & options.getFastRelaxedMath());
    m_effectiveOptions.setDenormsAreZero(
        m_effectiveOptions.getDenormsAreZero() & options.getDenormsAreZero());

    for (std::list<std::string>::const_iterator it = options.beginOptions(),
                                                ie = options.endOptions();
         it != ie; ++it) {
      m_effectiveOptions.addOption(*it);
    }
  }

  void Save(llvm::Module *pModule) {
    // overwrite the known options if such were specified during link
    if (m_bEnableLinkOptions && m_bCreateLibrary) {
      if (m_bDenormsAreZeroLinkOpt)
        m_effectiveOptions.setDenormsAreZero(true);
      if (m_bFastRelaxedMathLinkOpt)
        m_effectiveOptions.setFastRelaxedMath(true);
    }
    m_effectiveOptions.save(pModule);
  }

private:
  // effective flags stored in the module
  SpirOptions m_effectiveOptions;
  // flags supplied by link options
  bool m_bEnableLinkOptions;
  bool m_bCreateLibrary;
  // flags supplied by link options
  bool m_bDenormsAreZeroLinkOpt;
  bool m_bNoSignedZerosLinkOpt;
  bool m_bUnsafeMathLinkOpt;
  bool m_bFiniteMathOnlyLinkOpt;
  bool m_bFastRelaxedMathLinkOpt;
};

OCLFEBinaryResult *LinkInternal(const void **pInputBinaries,
                                unsigned int uiNumBinaries,
                                const size_t *puiBinariesSizes,
                                const char *pszOptions) {
  // Lazy initialization
  CommonClangInitialize();

  std::unique_ptr<OCLFEBinaryResult> pResult;

  try {
    pResult.reset(new OCLFEBinaryResult());

    if (0 == uiNumBinaries) {
      return pResult.release();
    }

    // LLVM doesn't guarantee thread safety,
    // therefore we serialize execution of LLVM code.
    llvm::sys::SmartScopedLock<true> linkGuard {*linkMutex};

    // Parse options
    ClangLinkOptions optionsParser;
    optionsParser.processOptions(pszOptions);
    IR_TYPE binaryType = optionsParser.hasArg(OPT_LINK_create_library)
                             ? IR_TYPE_LIBRARY
                             : IR_TYPE_EXECUTABLE;

    // Prepare the LLVM Context
    std::unique_ptr<llvm::LLVMContext> context(new llvm::LLVMContext());

    // Initialize the module with the first binary
    llvm::StringRef strInputBuff((const char *)pInputBinaries[0],
                                 puiBinariesSizes[0]);
    std::unique_ptr<llvm::MemoryBuffer> pBinBuff(
        llvm::MemoryBuffer::getMemBuffer(strInputBuff, "", false));
    auto ModuleOr =
        parseBitcodeFile(pBinBuff.get()->getMemBufferRef(), *context);
    if (!ModuleOr) {
      throw ModuleOr.takeError();
    }
    std::unique_ptr<llvm::Module> composite = std::move(ModuleOr.get());

    // Now go over the rest of the binaries and link them.
    MetadataLinker mdlinker(optionsParser, composite.get());
    for (unsigned int i = 1; i < uiNumBinaries; ++i) {
      std::unique_ptr<llvm::MemoryBuffer> pBinBuff(
          llvm::MemoryBuffer::getMemBuffer(
              llvm::StringRef((const char *)pInputBinaries[i],
                              puiBinariesSizes[i]),
              "", false));
      auto ModuleOr =
          parseBitcodeFile(pBinBuff.get()->getMemBufferRef(), *context);
      if (!ModuleOr) {
        throw ModuleOr.takeError();
      }
      std::unique_ptr<llvm::Module> module = std::move(ModuleOr.get());
      mdlinker.Link(module.get());

      if (llvm::Linker::linkModules(*composite, std::move(module))) {
        throw std::string("Linking has failed");
      }
    }
    mdlinker.Save(composite.get());
    pResult->setIRType(binaryType);

    llvm::raw_svector_ostream ir_ostream(pResult->getIRBufferRef());
    llvm::WriteBitcodeToFile(composite.get(), ir_ostream);

    return pResult.release();
  } catch (std::bad_alloc &e) {
    if (pResult) {
      pResult->getLogRef() = "Internal error";
      pResult->setResult(CL_OUT_OF_HOST_MEMORY);
      return pResult.release();
    }
    throw e;
  } catch (std::string &err) {
    pResult->setLog(err);
    pResult->setResult(CL_LINK_PROGRAM_FAILURE);
    return pResult.release();
  } catch (llvm::Error &err) {
    std::string Message;
    handleAllErrors(std::move(err), [&](llvm::ErrorInfoBase &EIB) {
      Message = EIB.message();
    });

    pResult->setLog(Message);
    pResult->setResult(CL_LINK_PROGRAM_FAILURE);
    return pResult.release();
  }
}

extern "C" CC_DLL_EXPORT int Link(const void **pInputBinaries,
                                  unsigned int uiNumBinaries,
                                  const size_t *puiBinariesSizes,
                                  const char *pszOptions,
                                  IOCLFEBinaryResult **pBinaryResult) {
  std::unique_ptr<OCLFEBinaryResult> pResult;
  int resultCode = CL_SUCCESS;
  try {
    pResult.reset(LinkInternal(pInputBinaries, uiNumBinaries, puiBinariesSizes,
                               pszOptions));
    resultCode = pResult->getResult();
  } catch (std::bad_alloc &) {
    resultCode = CL_OUT_OF_HOST_MEMORY;
  }

  if (pBinaryResult) {
    *pBinaryResult = pResult.release();
  }
  return resultCode;
}

extern "C" CC_DLL_EXPORT bool CheckLinkOptions(const char *pszOptions,
                                               char *pszUnknownOptions,
                                               size_t uiUnknownOptionsSize) {
  // LLVM doesn't guarantee thread safety,
  // therefore we serialize execution of LLVM code.
  llvm::sys::SmartScopedLock<true> linkOptionsGuard {*linkOptionsMutex};

  try {
    ClangLinkOptions optionsParser;
    return optionsParser.checkOptions(pszOptions, pszUnknownOptions,
                                      uiUnknownOptionsSize);
  } catch (std::bad_alloc &) {
    if (pszUnknownOptions && uiUnknownOptionsSize > 0) {
      std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
    }
    return false;
  }
}
