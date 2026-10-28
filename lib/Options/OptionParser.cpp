//===--- OptionParser.cpp - Option parsing implementation -------*- C++ -*-===//
//
// Copyright (c) Intel Corporation (2026).
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

#include "OptionParser.h"
#include "BuiltInHeaders.h"
#include "CommandLine.h"
#include "Options.h"

#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/Twine.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Support/Allocator.h"
#include "llvm/Support/StringSaver.h"
#include "llvm/Support/raw_ostream.h"

#include <algorithm>
#include <atomic>

using namespace llvm;

namespace {
#ifndef OPENCL_CLANG_NATIVE_TRIPLE
#error "OPENCL_CLANG_NATIVE_TRIPLE must be defined by the build system"
#endif // OPENCL_CLANG_NATIVE_TRIPLE
const char DefaultTargetTriple[] = OPENCL_CLANG_NATIVE_TRIPLE;

// Counter used to generate unique source names.
std::atomic<int> ProgID{1};

class ParserHelper {
public:
  ParserHelper() : Saver(Alloc) {}

  opt::InputArgList parse(const char *Options) {
    SmallVector<const char *> Args;
    tokenizeCommandLine(Options, Saver, Args);
    return getOptTable().ParseArgs(Args, MissingArgIndex, MissingArgCount);
  }

  StringSaver &getSaver() { return Saver; }

  unsigned MissingArgIndex = 0;
  unsigned MissingArgCount = 0;

private:
  BumpPtrAllocator Alloc;
  StringSaver Saver;
};

// Validates a value against the accepted values declared for the option in
// Options.td (via the Values<> field). An option that declares no values
// accepts anything.
bool isSupportedValue(const opt::Arg *A) {
  auto Supported =
      getOptionValuesSplit(static_cast<OptionID>(A->getOption().getID()));
  return Supported.empty() || is_contained(Supported, A->getValue());
}

// Parses the value of the --spirv-ext= option. The expected format is a comma
// separated list of the extension names, each one prefixed by '+' or '-'.
bool parseSPIRVExtOption(StringRef Value,
                         SmallVectorImpl<SmallString<64>> &Exts) {
  SmallVector<StringRef, 32> ExtList;
  SplitString(Value, ExtList, ",");

  bool Valid = !ExtList.empty();
  for (StringRef Ext : ExtList) {
    if (Ext.size() < 2 || (Ext.front() != '+' && Ext.front() != '-')) {
      Valid = false;
      break;
    }
    Exts.emplace_back(Ext);
  }

  if (!Valid)
    errs() << "Invalid value of --spirv-ext, expected format is:\n"
           << "\t--spirv-ext=+EXT_NAME,-EXT_NAME\n";
  return Valid;
}
} // namespace

bool OptionParser::process(const char *Options, const char *OptionsEx) {
  ParserHelper Helper;
  opt::InputArgList ParsedArgs = Helper.parse(Options);

  // -cl-std= only accepts the fixed set of values defined in Options.td to
  // avoid masking a user error.
  for (const opt::Arg *A : ParsedArgs.filtered(OPT_cl_std))
    if (!isSupportedValue(A))
      return false;

  SourceName = Twine(ProgID++).str();
  Triple = DefaultTargetTriple;

  for (const opt::Arg *A : ParsedArgs)
    handleOption(A, ParsedArgs);

  initDefaultOCLArgs();

  // Add the extended options verbatim.
  SmallVector<const char *> ArgsEx;
  tokenizeCommandLine(OptionsEx, Helper.getSaver(), ArgsEx, " \t", '"',
                      /*Escape=*/'\0');
  for (StringRef Arg : ArgsEx)
    if (!handleOptionEx(Arg))
      return false;

  // Add the source name to the options as an input file.
  assert(!SourceName.empty() && "Empty source name.");
  CCArgs.push_back(SourceName);

  return true;
}

bool OptionParser::check(const char *Options, char *UnknownOptions,
                         size_t UnknownOptionsSize) const {
  ParserHelper Helper;
  opt::InputArgList ParsedArgs = Helper.parse(Options);

  auto Report = [&](StringRef Str) {
    std::fill_n(UnknownOptions, UnknownOptionsSize, '\0');
    std::copy_n(Str.data(), std::min(Str.size(), UnknownOptionsSize - 1),
                UnknownOptions);
    return false;
  };

  if (Helper.MissingArgCount > 0)
    return Report(ParsedArgs.getArgString(Helper.MissingArgIndex));

  // The options with an unsupported value are reported as unknown ones.
  std::string Unknown;
  for (const opt::Arg *A : ParsedArgs)
    if (A->getOption().getID() == OPT_UNKNOWN || !isSupportedValue(A))
      Unknown += A->getAsString(ParsedArgs) + ' ';
  if (!Unknown.empty())
    return Report(Unknown);

  // Input options are not supported.
  std::string Inputs;
  for (const opt::Arg *A : ParsedArgs.filtered(OPT_INPUT))
    Inputs += A->getAsString(ParsedArgs) + ' ';
  if (!Inputs.empty())
    return Report(Inputs);

  return true;
}

void OptionParser::handleOption(const opt::Arg *A,
                                const opt::InputArgList &ParsedArgs) {
  switch (A->getOption().getID()) {
  default:
    // Ignore the unknown options and unexpected inputs. They must not break
    // the compilation, as they may be consumed by other components. They are
    // reported separately by CheckCompileOptions.
    break;
  case OPT_w:
  case OPT_D:
  case OPT_I:
  case OPT_Werror:
  case OPT_W_Joined:
  case OPT_W_Separate:
  case OPT_cl_single_precision_constant:
  case OPT_cl_fp32_correctly_rounded_divide_sqrt:
  case OPT_cl_mad_enable:
  case OPT_cl_no_signed_zeros:
  case OPT_cl_uniform_work_group_size:
  case OPT_cl_unsafe_math_optimizations:
  case OPT_cl_finite_math_only:
    CCArgs.emplace_back(A->getAsString(ParsedArgs));
    break;
  case OPT_Xclang:
    CCArgs.emplace_back("-Xclang");
    CCArgs.emplace_back(A->getValue());
    break;
  case OPT_cl_opt_disable:
    CCArgs.emplace_back(A->getAsString(ParsedArgs));
    OptDisable = true;
    break;
  case OPT_cl_denorms_are_zero:
    CCArgs.emplace_back("-fdenormal-fp-math=preserve-sign");
    break;
  case OPT_cl_fast_relaxed_math:
    CCArgs.emplace_back(A->getAsString(ParsedArgs));
    CCArgs.emplace_back("-D");
    CCArgs.emplace_back("__FAST_RELAXED_MATH__=1");
    break;
  case OPT_cl_std:
    // Specifying -fgnu89-inline is not allowed for C++ for OpenCL.
    if (StringRef(A->getValue()).find("CLC++") == 0)
      CppStdUsed = true;
    CCArgs.emplace_back(A->getAsString(ParsedArgs));
    break;
  case OPT_s: {
    StringRef NewSourceName = A->getValue();
    if (!NewSourceName.empty()) {
      SourceName = NewSourceName;
      // Normalize path to contain forward slashes
      std::replace(SourceName.begin(), SourceName.end(), '\\', '/');
#ifdef _WIN32
      // On Windows only, normalize the file name to lower case, since LLVM
      // saves buffer names in a case-sensitive manner, while other Windows
      // tools don't.
      SourceName = SourceName.str().lower();
#endif // _WIN32
    }
    StringRef Name = SourceName;
    CCArgs.emplace_back("-main-file-name");
    CCArgs.emplace_back(Name.substr(Name.rfind('/') + 1));
    break;
  }
  case OPT_triple:
    Triple = A->getValue();
    break;
  case OPT_x:
  case OPT_target_triple:
  case OPT_spir_std:
  case OPT_cl_no_subgroup_ifp:
  case OPT_cl_kernel_arg_info:
    // For SPIR, the kernel argument info is always created. The other options
    // are ignored.
    break;
  case OPT_coverage:
  case OPT_profiling:
  case OPT_gline_tables_only:
    CCArgs.emplace_back("-debug-info-kind=line-tables-only");
    CCArgs.emplace_back("-dwarf-version=4");
    break;
  case OPT_g:
    CCArgs.emplace_back("-debug-info-kind=limited");
    CCArgs.emplace_back("-dwarf-version=4");
#ifdef _WIN32
    // Do not use column information on Windows.
    CCArgs.emplace_back("-gno-column-info");
#endif // _WIN32
    break;
  }
}

void OptionParser::initDefaultOCLArgs() {
  CCArgs.emplace_back("-D");
  CCArgs.push_back(SmallString<32>({"__OPENCL_VERSION__=", OCLVersion}));
  CCArgs.emplace_back("-x");
  CCArgs.emplace_back("cl");

  CCArgs.emplace_back("-cl-kernel-arg-info");
  CCArgs.emplace_back("-fno-caret-diagnostics");
  CCArgs.emplace_back("-emit-llvm-bc");

  CCArgs.emplace_back("-triple");
  CCArgs.push_back(Triple);

  const auto &Headers = BuiltInHeaders::get();
  CCArgs.emplace_back("-isystem");
  CCArgs.emplace_back(Headers.getIncludePath());

  CCArgs.emplace_back("-include");
  CCArgs.emplace_back("opencl-c.h");

  // Don't optimize in the frontend
  // clang defaults to -O0, and in that mode, does not produce IR that is
  // intended to be optimized (e.g. produces 'optnone' attribute), so we are
  // using '-disable-llvm-passes' to get out the unoptimized IR.
  CCArgs.emplace_back("-disable-llvm-passes");

  // Specifying the option makes clang emit function body for functions
  // marked with inline keyword.
  if (!CppStdUsed)
    CCArgs.emplace_back("-fgnu89-inline");

  // OpenCL v2.0 s6.9.u - Implicit function declaration is not supported.
  // Behavior of clang is changed and now there is only warning about
  // implicit function declarations. To be more user friendly and avoid
  // unexpected indirect function calls in BE, let's force this warning to
  // error.
  CCArgs.emplace_back("-Werror=implicit-function-declaration");
}

bool OptionParser::handleOptionEx(StringRef Arg) {
  StringRef Opt = Arg;
  Opt.consume_front("-");
  // Support -- prefix as well.
  Opt.consume_front("-");

  if (Opt == "emit-spirv") {
    EmitSPIRV = true;
    return true;
  }

  if (Opt.consume_front("spirv-ext=")) {
    // The last --spirv-ext= option overrides the previous ones.
    HasSPIRVExt = true;
    SPIRVExts.clear();
    return parseSPIRVExtOption(Opt, SPIRVExts);
  }

  if (Opt == "cl-opt-disable")
    OptDisable = true;

  CCArgs.emplace_back(Arg);
  return true;
}
