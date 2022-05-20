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

  \file common_clang.cpp

\*****************************************************************************/

#include "common_clang.h"
#include "pch_mgr.h"
#include "cl_headers/resource.h"
#include "binary_result.h"
#include "options.h"

#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/Twine.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Linker/Linker.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/Threading.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/Mutex.h"
#include "llvm/Support/VirtualFileSystem.h"
#include "clang/Basic/LangOptions.h"
#include "clang/Basic/Diagnostic.h"
#include "clang/Basic/DiagnosticIDs.h"
#include "clang/Basic/DiagnosticOptions.h"
#include "clang/Frontend/TextDiagnosticPrinter.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/FrontendTool/Utils.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Serialization/ModuleManager.h"
#ifdef USE_PREBUILT_LLVM
#include "LLVMSPIRVLib/LLVMSPIRVLib.h"
#else // USE_PREBUILT_LLVM
#include "LLVMSPIRVLib.h"
#endif // USE_PREBUILT_LLVM

// The following #defines are used as return value of Compile() API and defined
// in https://github.com/KhronosGroup/OpenCL-Headers/blob/master/CL/cl.h
#define CL_SUCCESS 0
#define CL_COMPILE_PROGRAM_FAILURE -15
#define CL_OUT_OF_HOST_MEMORY -6

#include "assert.h"
#include <algorithm>
#include <iosfwd>
#include <iterator>
#include <list>
#include <streambuf>
#ifdef _WIN32
#include <ctype.h>
#endif

#if defined _DEBUG
#include <cstdlib>
#include <sstream>
#include <fstream>
#include <thread>
#endif

using namespace Intel::OpenCL::ClangFE;

static volatile bool lazyCCInit =
    true; // the flag must be 'volatile' to prevent caching in a CPU register
static llvm::sys::Mutex lazyCCInitMutex;

static llvm::ManagedStatic<llvm::sys::SmartMutex<true> > compileMutex;

void CommonClangTerminate() { llvm::llvm_shutdown(); }

// This function mustn't be invoked from a static object constructor,
// from a DllMain function (Windows specific), or from a function
// w\ __attribute__ ((constructor)) (Linux specific).
void CommonClangInitialize() {
  if (lazyCCInit) {
    llvm::sys::ScopedLock lock(lazyCCInitMutex);

    if (lazyCCInit) {
      // CommonClangTerminate calls llvm_shutdown to deallocate resources used
      // by LLVM libraries. llvm_shutdown uses static mutex to make it safe for
      // multi-threaded envirounment and LLVM libraries user is expected call
      // llvm_shutdown before static object are destroyed, so we use atexit to
      // satisfy this requirement.
      atexit(CommonClangTerminate);
      llvm::InitializeAllTargets();
      llvm::InitializeAllAsmPrinters();
      llvm::InitializeAllAsmParsers();
      llvm::InitializeAllTargetMCs();
      lazyCCInit = false;
    }
  }
}

static bool GetHeaders(std::vector<Resource> &Result) {
  struct {const char *ID; const char *Name;} Headers[] = {
    {OPENCL_C_H,             "opencl-c.h"},
    {OPENCL_C_BASE_H,        "opencl-c-base.h"},
  };

  Result.clear();
  Result.reserve(sizeof(Headers) / sizeof(*Headers));

  ResourceManager &RM = ResourceManager::instance();

  for (auto Header:Headers) {
    Resource R = RM.get_resource(Header.Name, Header.ID, "PCM", true);
    if (!R) {
      assert(0 && "Resource not found");
      return false;
    }

    Result.push_back(R);
  }

  return true;
}

static void PrintCompileOptions(const char *pszOptions, const char *pszOptionsEx,
                                const char *pszOpenCLVer, const char * pszSource) {
#ifdef _DEBUG
  static int ID = 0;

  if (!getenv("CCLANG_OPTIONS_DIR")) return;

  std::string OptionsDir = getenv("CCLANG_OPTIONS_DIR");

  std::stringstream logPath;
  logPath << OptionsDir << "/log_" << std::this_thread::get_id() << "_" << ID << ".txt";
  std::cout << logPath.str() << std::endl;

  // Creating log file
  std::ofstream logFile(logPath.str(), std::ios::out);

  if (!logFile.is_open()) {
    std::cout << "[ERROR] Can't create log file" << std::endl;
    return;
  }

  logFile << "pszOptions=" << pszOptions << std::endl;
  logFile << "pszOptionsEx=" << pszOptionsEx << std::endl;
  logFile << "pszOpenCLVer=" << pszOpenCLVer << std::endl;
  logFile << pszSource;
  ++ID;
  logFile.close();
#endif
}

class SmallVectorBuffer : public std::streambuf
{
  // All memory management is delegated to llvm::SmallVectorImpl
  llvm::SmallVectorImpl<char> &OS;

  // Since we don't touch any pointer in streambuf(pbase, pptr, epptr) this is
  // the only method we need to override.
  virtual std::streamsize xsputn(const char *s, std::streamsize  n) override {
    OS.append(s, s + n);
    return n;
  }

public:
  SmallVectorBuffer() = delete;
  SmallVectorBuffer(const SmallVectorBuffer&) = delete;
  SmallVectorBuffer &operator=(const SmallVectorBuffer&) = delete;
  SmallVectorBuffer(llvm::SmallVectorImpl<char> &O) : OS(O) {}
};

extern "C" CC_DLL_EXPORT int
Compile(const char *pszProgramSource, const char **pInputHeaders,
        unsigned int uiNumInputHeaders, const char **pInputHeadersNames,
        const char *pPCHBuffer, size_t uiPCHBufferSize, const char *pszOptions,
        const char *pszOptionsEx, const char *pszOpenCLVer,
        IOCLFEBinaryResult **pBinaryResult) {

  // Capturing cclang compile options
  PrintCompileOptions(pszOptions, pszOptionsEx, pszOpenCLVer, pszProgramSource);

  // Lazy initialization
  CommonClangInitialize();

  try {
    std::unique_ptr<OCLFEBinaryResult> pResult(new OCLFEBinaryResult());

    // Create the clang compiler
    std::unique_ptr<clang::CompilerInstance> compiler(
        new clang::CompilerInstance());

    CompileOptionsParser optionsParser(pszOpenCLVer);

    // Prepare error log
    llvm::raw_string_ostream err_ostream(pResult->getLogRef());
    {
      llvm::sys::SmartScopedLock<true> compileGuard {*compileMutex};

      // Parse options
      optionsParser.processOptions(pszOptions, pszOptionsEx);

      // Prepare our diagnostic client.
      llvm::IntrusiveRefCntPtr<clang::DiagnosticIDs> DiagID(
          new clang::DiagnosticIDs());
      llvm::IntrusiveRefCntPtr<clang::DiagnosticOptions> DiagOpts(
          new clang::DiagnosticOptions());
      DiagOpts->ShowPresumedLoc = true;
      clang::TextDiagnosticPrinter *DiagsPrinter =
        new clang::TextDiagnosticPrinter(err_ostream, &*DiagOpts);
      llvm::IntrusiveRefCntPtr<clang::DiagnosticsEngine> Diags(
          new clang::DiagnosticsEngine(DiagID, &*DiagOpts, DiagsPrinter));

      // Prepare output buffer
      std::unique_ptr<llvm::raw_pwrite_stream>
        ir_ostream(new llvm::raw_svector_ostream(pResult->getIRBufferRef()));
      // Set buffers
      // CompilerInstance takes ownership over output stream
      compiler->setOutputStream(std::move(ir_ostream));

      compiler->setDiagnostics(&*Diags);

      llvm::IntrusiveRefCntPtr<llvm::vfs::OverlayFileSystem> OverlayFS(
          new llvm::vfs::OverlayFileSystem(llvm::vfs::getRealFileSystem()));
      llvm::IntrusiveRefCntPtr<llvm::vfs::InMemoryFileSystem> MemFS(
          new llvm::vfs::InMemoryFileSystem);
      OverlayFS->pushOverlay(MemFS);

      compiler->createFileManager(OverlayFS);
      compiler->createSourceManager(compiler->getFileManager());

      // Create compiler invocation from user args before trickering with it
      clang::CompilerInvocation::CreateFromArgs(compiler->getInvocation(),
          optionsParser.args(), *Diags);

      // Configure our handling of diagnostics.
      ProcessWarningOptions(*Diags, compiler->getDiagnosticOpts());

      // Map memory buffers to a virtual file system

      // Source file
      MemFS->addFile(
          optionsParser.getSourceName(), (time_t)0,
          llvm::MemoryBuffer::getMemBuffer(
            llvm::StringRef(pszProgramSource), optionsParser.getSourceName()));

      // Input header with OpenCL defines.
      std::vector<Resource> vHeaderWithDefs;
      if (!GetHeaders(vHeaderWithDefs)) {
        return CL_COMPILE_PROGRAM_FAILURE;
      }

      for (const auto &Header:vHeaderWithDefs) {
        auto Buf = llvm::MemoryBuffer::getMemBuffer(
            llvm::StringRef(Header.m_data, Header.m_size),
            Header.m_name);

        MemFS->addFile(Header.m_name,(time_t)0, std::move(Buf));
      }

      // Input Headers
      for (unsigned int i = 0; i < uiNumInputHeaders; ++i) {
        auto Header = llvm::MemoryBuffer::getMemBuffer(
            pInputHeaders[i], pInputHeadersNames[i]);
        MemFS->addFile(pInputHeadersNames[i], (time_t)0, std::move(Header));
      }
    }
    // Execute the frontend actions.
    bool success = false;
    try {
      success = clang::ExecuteCompilerInvocation(compiler.get());
    } catch (const std::exception &) {
    }
    pResult->setIRType(IR_TYPE_COMPILED_OBJECT);
    pResult->setIRName(optionsParser.getSourceName());

    // Our error handler depends on the Diagnostics object, which we're
    // potentially about to delete. Uninstall the handler now so that any
    // later errors use the default handling behavior instead.
    // (currently commented out since setting the llvm error handling in
    // multi-threaded environment is unsupported)
    // llvm::remove_fatal_error_handler();
    err_ostream.flush();

    if (success && optionsParser.hasEmitSPIRV()) {
      // Translate LLVM IR to SPIR-V.
      llvm::StringRef LLVM_IR(static_cast<const char*>(pResult->GetIR()),
          pResult->GetIRSize());
      std::unique_ptr<llvm::MemoryBuffer> MB = llvm::MemoryBuffer::getMemBuffer(LLVM_IR, pResult->GetIRName(), false);
      llvm::LLVMContext Context;
      auto E = llvm::getOwningLazyBitcodeModule(std::move(MB), Context,
          /*ShouldLazyLoadMetadata=*/true);
      llvm::logAllUnhandledErrors(E.takeError(), err_ostream, "error: ");
      std::unique_ptr<llvm::Module> M = std::move(*E);

      if (M->materializeAll()) {
        if (pBinaryResult) {
          *pBinaryResult = nullptr;
        }
        assert(!"Failed to read just compiled LLVM IR!");
        return CL_COMPILE_PROGRAM_FAILURE;
      }
      pResult->getIRBufferRef().clear();
      SmallVectorBuffer StreamBuf(pResult->getIRBufferRef());
      std::ostream OS(&StreamBuf);
      std::string Err;
      SPIRV::TranslatorOpts SPIRVOpts;
      SPIRVOpts.enableAllExtensions();
      if (!optionsParser.hasOptDisable()) {
        SPIRVOpts.setMemToRegEnabled(true);
      }
      SPIRVOpts.setPreserveOCLKernelArgTypeMetadataThroughString(true);
      success = llvm::writeSpirv(M.get(), SPIRVOpts, OS, Err);
      err_ostream << Err.c_str();
      err_ostream.flush();
    }
    {
      llvm::sys::SmartScopedLock<true> compileGuard {*compileMutex};
      if (pBinaryResult) {
        *pBinaryResult = pResult.release();
      }
    }
    return success ? CL_SUCCESS : CL_COMPILE_PROGRAM_FAILURE;
  } catch (std::bad_alloc &) {
    if (pBinaryResult) {
      *pBinaryResult = NULL;
    }
    return CL_OUT_OF_HOST_MEMORY;
  }
}
