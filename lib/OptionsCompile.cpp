//===--- OptionsCompile.cpp - Compile option processing ---------*- C++ -*-===//
//
// Copyright (c) Intel Corporation (2009-2017).
//
// INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE. THIS CODE IS
// LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
// ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES. INTEL DOES NOT
// PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS. INTEL SPECIFICALLY
// DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
// PARTICULAR PURPOSE, OR ANY OTHER WARRANTY. Intel disclaims all liability,
// including liability for infringement of any proprietary rights, relating to
// use of the code. No license, express or implied, by estoppel or otherwise,
// to any intellectual property rights is granted herein.
//
//===----------------------------------------------------------------------===//

#include "BuiltInHeaders.h"
#include "Options.h"

#include "opencl-clang/OpenCLClang.h"

#include "llvm/ADT/StringExtras.h"

#include <algorithm>
#include <map>
#include <sstream>

using namespace llvm::opt;

#define OPTTABLE_CODE
#include "OpenCLClangOptions.inc"
#undef OPTTABLE_CODE

#ifndef OPENCL_CLANG_NATIVE_TRIPLE
#error "OPENCL_CLANG_NATIVE_TRIPLE must be defined by the build system"
#endif // OPENCL_CLANG_NATIVE_TRIPLE
static const char DefaultTargetTriple[] = OPENCL_CLANG_NATIVE_TRIPLE;

OpenCLCompileOptTable::OpenCLCompileOptTable()
    : OpenCLOptTable(optionTables()) {}

std::atomic<int> EffectiveOptionsFilter::ProgID{1};

// This code was adopted from the SPIRV-LLVM-Translator repository.
static int parseSPVExtOption(
    llvm::StringRef SPVExt,
    SPIRV::TranslatorOpts::ExtensionsStatusMap &ExtensionsStatus) {
  // Map name -> id for known extensions
  std::map<llvm::StringRef, SPIRV::ExtensionID> ExtensionNamesMap;
#define _STRINGIFY(X) #X
#define STRINGIFY(X) _STRINGIFY(X)
#define EXT(X) ExtensionNamesMap[STRINGIFY(X)] = SPIRV::ExtensionID::X;
#ifdef USE_PREBUILT_LLVM
#include "LLVMSPIRVLib/LLVMSPIRVExtensions.inc"
#else // USE_PREBUILT_LLVM
#include "LLVMSPIRVExtensions.inc"
#endif // USE_PREBUILT_LLVM
#undef EXT
#undef STRINGIFY
#undef _STRINGIFY

  // Set the initial state: assume that any known extension is disallowed.
  std::optional<bool> DefaultVal;
  for (const auto &It : ExtensionNamesMap)
    ExtensionsStatus[It.second] = DefaultVal;

  llvm::SmallVector<llvm::StringRef, 32> SPVExtList;
  llvm::SplitString(SPVExt, SPVExtList, ",");

  if (SPVExtList.empty()) {
    llvm::errs() << "Invalid value of --spirv-ext, expected format is:\n"
                 << "\t--spirv-ext=+EXT_NAME,-EXT_NAME\n";
    return -1;
  }

  for (unsigned i = 0; i < SPVExtList.size(); ++i) {
    llvm::StringRef ExtString = SPVExtList[i];
    if (ExtString.empty() ||
        ('+' != ExtString.front() && '-' != ExtString.front())) {
      llvm::errs() << "Invalid value of --spirv-ext, expected format is:\n"
                   << "\t--spirv-ext=+EXT_NAME,-EXT_NAME\n";
      return -1;
    }

    auto ExtName = ExtString.substr(1);

    if (ExtName.empty()) {
      llvm::errs() << "Invalid value of --spirv-ext, expected format is:\n"
                   << "\t--spirv-ext=+EXT_NAME,-EXT_NAME\n";
      return -1;
    }

    bool ExtStatus = ('+' == ExtString.front());
    if ("all" == ExtName) {
      // Update status for all known extensions
      for (const auto &It : ExtensionNamesMap)
        ExtensionsStatus[It.second] = ExtStatus;
    } else {
      // Ignore unknown extensions, as targets may support non-standard SPIR-V
      // extensions. Do not reject them; this approach is more tolerant.
      const auto &It = ExtensionNamesMap.find(ExtName);
      if (ExtensionNamesMap.end() == It)
        continue;

      ExtensionsStatus[It->second] = ExtStatus;
    }
  }

  return 0;
}

///
// Options filter that validates the opencl used options
//
std::string EffectiveOptionsFilter::processOptions(const OpenCLArgList &args,
                                                   const char *pszOptionsEx,
                                                   ArgsVector &effectiveArgs) {
  // Reset args
  bool isCpp = false;
  std::string szTriple = DefaultTargetTriple;
  std::string sourceName(llvm::Twine(ProgID++).str());

  for (OpenCLArgList::const_iterator it = args.begin(), ie = args.end();
       it != ie; ++it) {
    switch ((*it)->getOption().getID()) {
    case OPT_COMPILE_w:
    case OPT_COMPILE_D:
    case OPT_COMPILE_I:
    case OPT_COMPILE_Werror:
    case OPT_COMPILE_W_Joined:
    case OPT_COMPILE_W_Separate:
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_Xclang:
      effectiveArgs.push_back("-Xclang");
      effectiveArgs.push_back((*it)->getValue());
      break;
    case OPT_COMPILE_cl_single_precision_constant:
    case OPT_COMPILE_cl_fp32_correctly_rounded_divide_sqrt:
    case OPT_COMPILE_cl_opt_disable:
    case OPT_COMPILE_cl_mad_enable:
    case OPT_COMPILE_cl_no_signed_zeros:
    case OPT_COMPILE_cl_uniform_work_group_size:
    case OPT_COMPILE_cl_unsafe_math_optimizations:
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_cl_denorms_are_zero:
      effectiveArgs.push_back("-fdenormal-fp-math=preserve-sign");
      break;
    case OPT_COMPILE_s: {
      std::string newSourceName = (*it)->getValue();
      if (!newSourceName.empty()) {
        sourceName = newSourceName;
        // Normalize path to contain forward slashes
        replace(sourceName.begin(), sourceName.end(), '\\', '/');

#ifdef _WIN32
        // On Windows only, normalize the file name to lower case, since
        // LLVM saves buffer names in a case-sensitive manner, while
        // other Windows tools don't.
        //
        std::transform(sourceName.begin(), sourceName.end(), sourceName.begin(),
                       ::tolower);
#endif
      }
      effectiveArgs.push_back("-main-file-name");
      effectiveArgs.push_back(sourceName.substr(sourceName.rfind('/') + 1));
      break;
    }
    case OPT_COMPILE_cl_finite_math_only:
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_cl_fast_relaxed_math:
      effectiveArgs.push_back((*it)->getAsString(args));
      effectiveArgs.push_back("-D");
      effectiveArgs.push_back("__FAST_RELAXED_MATH__=1");
      break;
    case OPT_COMPILE_cl_std_CL1_0:
    case OPT_COMPILE_cl_std_CL1_1:
    case OPT_COMPILE_cl_std_CL1_2:
    case OPT_COMPILE_cl_std_CL2_0:
    case OPT_COMPILE_cl_std_CL3_0:
    case OPT_COMPILE_cl_std_CL3_1:
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_cl_std_CLCxx:
    case OPT_COMPILE_cl_std_CLCxx1_0:
    case OPT_COMPILE_cl_std_CLCxx2021:
      isCpp = true;
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_triple:
      szTriple = (*it)->getValue();
      break;
    case OPT_COMPILE_cl_no_subgroup_ifp:
    case OPT_COMPILE_target_triple:
    case OPT_COMPILE_spir_std_1_0:
    case OPT_COMPILE_spir_std_1_2:       // ignore for now
    case OPT_COMPILE_cl_kernel_arg_info: // For SPIR, we always create kernel
                                         // arg info, so ignoring it here
      break;
    case OPT_COMPILE_x:
      // ensure that the value is spir
      assert((*it)->getValue() == std::string("spir"));
      // TODO: move the validation of the value to the check section of the
      // option processing to be reported as an unknown option
      break;
      // Just ignore the unknown options ( they will be listed in the unknown
      // list inside the ArgsList anyway)
      // The below assert is usable for manual debugging only
      // default:
      // assert(false && "some unknown argument");
    case OPT_COMPILE_coverage:
    case OPT_COMPILE_profiling:
    case OPT_COMPILE_gline_tables_only_Flag:
      effectiveArgs.push_back("-debug-info-kind=line-tables-only");
      effectiveArgs.push_back("-dwarf-version=4");
      break;
    case OPT_COMPILE_g_Flag:
      effectiveArgs.push_back("-debug-info-kind=limited");
      effectiveArgs.push_back("-dwarf-version=4");
#ifdef _WIN32
      // Do not use column information on Windows.
      effectiveArgs.push_back("-gno-column-info");
#endif
      break;
    }
  }

  effectiveArgs.push_back("-D");
  effectiveArgs.push_back("__OPENCL_VERSION__=" + OpenCLVer);
  effectiveArgs.push_back("-x");
  effectiveArgs.push_back("cl");

  effectiveArgs.push_back("-cl-kernel-arg-info");
  effectiveArgs.push_back("-fno-caret-diagnostics");

  if (std::find_if(effectiveArgs.begin(), effectiveArgs.end(),
                   [](const ArgsVector::value_type& a) {
                     return a == "-S" || a.find("-emit") == 0;
                   }) == effectiveArgs.end()) {
    effectiveArgs.push_back("-emit-llvm-bc");
  }

  effectiveArgs.push_back("-triple");
  effectiveArgs.push_back(szTriple);

  const auto &Headers = BuiltInHeaders::get();
  effectiveArgs.push_back("-isystem");
  effectiveArgs.push_back(Headers.getIncludePath());

  effectiveArgs.push_back("-include");
  effectiveArgs.push_back("opencl-c.h");

  // Don't optimize in the frontend
  // clang defaults to -O0, and in that mode, does not produce IR that is
  // intended to be optimized (e.g. produces 'optnone' attribute), so we are
  // using '-disable-llvm-passes' to get out the unoptimized IR.
  effectiveArgs.push_back("-disable-llvm-passes");

  // Specifying the option makes clang emit function body for functions
  // marked with inline keyword.
  if (!isCpp) {
    effectiveArgs.push_back("-fgnu89-inline");
  }

  // OpenCL v2.0 s6.9.u - Implicit function declaration is not supported.
  // Behavior of clang is changed and now there is only warning about
  // implicit function declarations. To be more user friendly and avoid
  // unexpected indirect function calls in BE, let's force this warning to
  // error.
  effectiveArgs.push_back("-Werror=implicit-function-declaration");

  // add the extended options verbatim
  std::back_insert_iterator<ArgsVector> it(std::back_inserter(effectiveArgs));
  quoted_tokenize(it, pszOptionsEx, " \t", '"', '\x00');

  // add source name to options as an input file
  assert(!sourceName.empty() && "Empty source name.");
  effectiveArgs.push_back(sourceName);

  return sourceName;
}

int CompileOptionsParser::processOptions(const char *pszOptions,
                                         const char *pszOptionsEx) {
  // parse options
  unsigned missingArgIndex, missingArgCount;
  std::unique_ptr<OpenCLArgList> pArgs(
      OptTbl.parseArgs(pszOptions, missingArgIndex, missingArgCount));

  // -cl-std= only accepts the fixed set of values defined in
  // OpenCLClangOptions.td to avoid masking a user error.
  std::string unknownArgs = pArgs->getFilteredArgs(OPT_COMPILE_UNKNOWN);
  if (unknownArgs.find("-cl-std=") != std::string::npos)
    return -1;

  // post process logic
  SourceName =
      CommonFilter.processOptions(*pArgs, pszOptionsEx, EffectiveArgs);

  // build the raw options array
  for (ArgsVector::iterator it = EffectiveArgs.begin(),
                            end = EffectiveArgs.end();
       it != end; ++it) {
    llvm::StringRef arg(*it);
    (void)arg.consume_front("-");
    // support -- prefix as well.
    (void)arg.consume_front("-");
    if (arg == "cl-opt-disable") {
      OptDisable = true;
    } else if (arg == "emit-spirv") {
      EmitSPIRV = true;
      continue;
    } else if (arg.consume_front("spirv-ext=")) {
      HasSPIRVExt = true;
      // SPIRVExtStatusMap will be initialized and updated according to `arg`.
      int ret = parseSPVExtOption(arg, SPIRVExtStatusMap);
      if (0 != ret)
        return ret;
      continue;
    }
    EffectiveArgsRaw.push_back(it->c_str());
  }
  return 0;
}

bool CompileOptionsParser::checkOptions(const char *pszOptions,
                                        char *pszUnknownOptions,
                                        size_t uiUnknownOptionsSize) {
  // Parse the arguments.
  unsigned missingArgIndex, missingArgCount;
  std::unique_ptr<OpenCLArgList> pArgs(
      OptTbl.parseArgs(pszOptions, missingArgIndex, missingArgCount));

  // Check for missing argument error.
  if (missingArgCount) {
    std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
    std::string missingArg(pArgs->getArgString(missingArgIndex));
    missingArg.copy(pszUnknownOptions, uiUnknownOptionsSize - 1);
    return false;
  }

  std::string unknownOptions = pArgs->getFilteredArgs(OPT_COMPILE_UNKNOWN);
  if (!unknownOptions.empty()) {
    std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
    unknownOptions.copy(pszUnknownOptions, uiUnknownOptionsSize - 1);
    return false;
  }

  // we do not support input options
  std::string inputOptions = pArgs->getFilteredArgs(OPT_COMPILE_INPUT);
  if (!inputOptions.empty()) {
    std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
    inputOptions.copy(pszUnknownOptions, uiUnknownOptionsSize - 1);
    return false;
  }

  return true;
}

std::string CompileOptionsParser::getEffectiveOptionsAsString() const {
  std::stringstream ss;

  const char *const *it = beginArgs();
  const char *const *ie = endArgs();

  for (; it != ie; ++it) {
    ss << *it << " ";
  }
  return ss.str();
}

extern "C" CC_DLL_EXPORT bool CheckCompileOptions(const char *pszOptions,
                                                  char *pszUnknownOptions,
                                                  size_t uiUnknownOptionsSize) {
  try {
    CompileOptionsParser optionsParser("200");
    return optionsParser.checkOptions(pszOptions, pszUnknownOptions,
                                      uiUnknownOptionsSize);
  } catch (std::bad_alloc &) {
    if (pszUnknownOptions && uiUnknownOptionsSize > 0) {
      std::fill_n(pszUnknownOptions, uiUnknownOptionsSize, '\0');
    }
    return false;
  }
}
