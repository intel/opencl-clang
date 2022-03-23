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

  \file options_compile.cpp

\*****************************************************************************/

#include "common_clang.h"
#include "options.h"

#include "clang/Driver/Options.h"
#include "llvm/Option/Arg.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/Mutex.h"

#include <sstream>

#define PREFIX(NAME, VALUE) const char *const NAME[] = VALUE;
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS, PARAM,  \
               HELPTEXT, METAVAR, VALUES)
#include "opencl_clang_options.inc"
#undef OPTION
#undef PREFIX

using namespace llvm::opt;

static llvm::ManagedStatic<llvm::sys::SmartMutex<true> > compileOptionsMutex;

static const OptTable::Info ClangOptionsInfoTable[] = {
#define PREFIX(NAME, VALUE)
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS, PARAM,  \
               HELPTEXT, METAVAR, VALUES)                                      \
  {                                                                            \
    PREFIX, NAME, HELPTEXT, METAVAR, OPT_COMPILE_##ID,                         \
        llvm::opt::Option::KIND##Class, PARAM, FLAGS, OPT_COMPILE_##GROUP,     \
        OPT_COMPILE_##ALIAS, ALIASARGS                                         \
  }                                                                            \
  ,
#include "opencl_clang_options.inc"
};

OpenCLCompileOptTable::OpenCLCompileOptTable()
    : OpenCLOptTable(ClangOptionsInfoTable) {}

int EffectiveOptionsFilter::s_progID = 1;

///
// Options filter that validates the opencl used options
//
std::string EffectiveOptionsFilter::processOptions(const OpenCLArgList &args,
                                                   const char *pszOptionsEx,
                                                   ArgsVector &effectiveArgs) {
  // Reset args
  int iCLStdSet = 0;
  std::string szTriple;
  std::string sourceName(llvm::Twine(s_progID++).str());

  for (OpenCLArgList::const_iterator it = args.begin(), ie = args.end();
       it != ie; ++it) {
    switch ((*it)->getOption().getID()) {
    case OPT_COMPILE_w:
    case OPT_COMPILE_D:
    case OPT_COMPILE_I:
    case OPT_COMPILE_Werror:
    case OPT_COMPILE_cl_single_precision_constant:
    case OPT_COMPILE_cl_fp32_correctly_rounded_divide_sqrt:
    case OPT_COMPILE_cl_opt_disable:
    case OPT_COMPILE_cl_mad_enable:
    case OPT_COMPILE_cl_no_signed_zeros:
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
      effectiveArgs.push_back("-D");
      effectiveArgs.push_back("__FINITE_MATH_ONLY__=1");
      break;
    case OPT_COMPILE_cl_fast_relaxed_math:
      effectiveArgs.push_back((*it)->getAsString(args));
      effectiveArgs.push_back("-D");
      effectiveArgs.push_back("__FAST_RELAXED_MATH__=1");
      break;
    case OPT_COMPILE_cl_std_CL1_1:
      iCLStdSet = 110;
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_cl_std_CL1_2:
      iCLStdSet = 120;
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_cl_std_CL2_0:
      iCLStdSet = 200;
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_cl_std_CL3_0:
      iCLStdSet = 300;
      effectiveArgs.push_back((*it)->getAsString(args));
      break;
    case OPT_COMPILE_triple:
      szTriple = (*it)->getValue();
      break;
    case OPT_COMPILE_cl_uniform_work_group_size:
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
    case OPT_COMPILE_profiling:
    case OPT_COMPILE_g_Flag:
      effectiveArgs.push_back("-debug-info-kind=limited");
      effectiveArgs.push_back("-dwarf-version=4");
      break;
    case OPT_COMPILE_gline_tables_only_Flag:
      effectiveArgs.push_back("-debug-info-kind=line-tables-only");
      effectiveArgs.push_back("-dwarf-version=4");
      break;
    }
  }

  if (!iCLStdSet) {
    effectiveArgs.push_back("-cl-std=CL1.2");
    iCLStdSet = 120;
  }

  effectiveArgs.push_back("-D");
  effectiveArgs.push_back("__OPENCL_VERSION__=" + m_opencl_ver);
  effectiveArgs.push_back("-x");
  effectiveArgs.push_back("cl");

  effectiveArgs.push_back("-cl-kernel-arg-info");
  effectiveArgs.push_back("-fno-validate-pch");
  effectiveArgs.push_back("-fno-caret-diagnostics");

  if (std::find_if(effectiveArgs.begin(), effectiveArgs.end(),
                   [](const ArgsVector::value_type& a) {
                     return a == "-S" || a.find("-emit") == 0;
                   }) == effectiveArgs.end()) {
    effectiveArgs.push_back("-emit-llvm-bc");
  }

  effectiveArgs.push_back("-triple");
  if (szTriple.empty()) {
#if defined(_M_X64) || defined(__LP64__)
    szTriple = "spir64-unknown-unknown";
#else
    szTriple = "spir-unknown-unknown";
#endif
  }

  effectiveArgs.push_back(szTriple);

  effectiveArgs.push_back("-include");
  effectiveArgs.push_back("opencl-c.h");

  // Don't optimize in the frontend
  // clang defaults to -O0, and in that mode, does not produce IR that is
  // intended to be optimized (e.g. produces 'optnone' attribute), so we are
  // using '-disable-llvm-passes' to get out the unoptimized IR.
  effectiveArgs.push_back("-disable-llvm-passes");

  // Specifying the option makes clang emit function body for functions
  // marked with inline keyword.
  effectiveArgs.push_back("-fgnu89-inline");

  // Do not support all extensions by default. Support for a particular
  // extension should be enabled by passing a '-cl-ext' option in pszOptionsEx.
  effectiveArgs.push_back("-cl-ext=-all");

  // OpenCL v2.0 s6.9.u - Implicit function declaration is not supported.
  // Behavior of clang is changed and now there is only warning about
  // implicit function declarations. To be more user friendly and avoid
  // unexpected indirect function calls in IR, let's force this warning to
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

void CompileOptionsParser::processOptions(const char *pszOptions,
                                          const char *pszOptionsEx) {
  // parse options
  unsigned missingArgIndex, missingArgCount;
  std::unique_ptr<OpenCLArgList> pArgs(
      m_optTbl.ParseArgs(pszOptions, missingArgIndex, missingArgCount));

  // post process logic
  m_sourceName =
      m_commonFilter.processOptions(*pArgs, pszOptionsEx, m_effectiveArgs);

  // build the raw options array
  for (ArgsVector::iterator it = m_effectiveArgs.begin(),
                            end = m_effectiveArgs.end();
       it != end; ++it) {
    if (it->compare("-cl-opt-disable") == 0) {
      m_optDisable = true;
    }
    else if (it->compare("-emit-spirv") == 0) {
      m_effectiveArgsRaw.push_back("-emit-llvm-bc");
      m_emitSPIRV = true;
      continue;
    }
    m_effectiveArgsRaw.push_back(it->c_str());
  }
}

bool CompileOptionsParser::checkOptions(const char *pszOptions,
                                        char *pszUnknownOptions,
                                        size_t uiUnknownOptionsSize) {
  // Parse the arguments.
  unsigned missingArgIndex, missingArgCount;
  std::unique_ptr<OpenCLArgList> pArgs(
      m_optTbl.ParseArgs(pszOptions, missingArgIndex, missingArgCount));

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
  // LLVM doesn't guarantee thread safety,
  // therefore we serialize execution of LLVM code.
  llvm::sys::SmartScopedLock<true> compileOptionsGuard {*compileOptionsMutex};

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
