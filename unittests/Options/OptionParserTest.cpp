//===--- OptionParserTest.cpp - Option parser tests -------------*- C++ -*-===//
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

// Unit tests for OptionParser (opencl-clang/Options/OptionParser.h): the
// translation of the OpenCL build options into the Clang frontend arguments,
// and the validation of the application supplied options.

#include "opencl-clang/Options/OptionParser.h"

#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "gtest/gtest.h"

using namespace llvm;

namespace {

using ArgsT = SmallVectorImpl<SmallString<32>>;

bool contains(const ArgsT &Args, StringRef Arg) {
  return is_contained(Args, Arg);
}

// Returns true if the argument \p Arg is directly followed by \p Value.
bool containsPair(const ArgsT &Args, StringRef Arg, StringRef Value) {
  for (size_t I = 0; I + 1 < Args.size(); ++I)
    if (Args[I] == Arg && Args[I + 1] == Value)
      return true;
  return false;
}

// ---------------------------------------------------------------------------
// Default arguments
// ---------------------------------------------------------------------------

TEST(OptionParser, DefaultArgs) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("", ""));
  auto &Args = Parser.getCCArgs();

  EXPECT_TRUE(containsPair(Args, "-D", "__OPENCL_VERSION__=120"));
  EXPECT_TRUE(containsPair(Args, "-x", "cl"));
  EXPECT_TRUE(containsPair(Args, "-triple", OPENCL_CLANG_NATIVE_TRIPLE));
  EXPECT_TRUE(containsPair(Args, "-isystem", "/mock-include/opencl-clang/"));
  EXPECT_TRUE(containsPair(Args, "-include", "opencl-c.h"));
  EXPECT_TRUE(contains(Args, "-cl-kernel-arg-info"));
  EXPECT_TRUE(contains(Args, "-fno-caret-diagnostics"));
  EXPECT_TRUE(contains(Args, "-disable-llvm-passes"));
  EXPECT_TRUE(contains(Args, "-fgnu89-inline"));
  EXPECT_TRUE(contains(Args, "-Werror=implicit-function-declaration"));

  // Neither the OpenCL C version nor the set of the extensions is forced.
  for (StringRef Arg : Args) {
    EXPECT_NE(Arg.find("-cl-std="), 0u) << Arg.str();
    EXPECT_NE(Arg.find("-cl-ext="), 0u) << Arg.str();
  }

  EXPECT_FALSE(Parser.hasEmitSPIRV());
  EXPECT_FALSE(Parser.hasOptDisable());
  EXPECT_FALSE(Parser.hasSPIRVExt());
}

TEST(OptionParser, SourceNameIsTheLastArgument) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("", "-DFOO"));
  ASSERT_FALSE(Parser.getCCArgs().empty());
  EXPECT_EQ(Parser.getCCArgs().back(), Parser.getSourceName());
}

TEST(OptionParser, SourceNamesAreUnique) {
  OptionParser Parser1("120");
  OptionParser Parser2("120");
  ASSERT_TRUE(Parser1.process("", ""));
  ASSERT_TRUE(Parser2.process("", ""));
  EXPECT_FALSE(Parser1.getSourceName().empty());
  EXPECT_NE(Parser1.getSourceName(), Parser2.getSourceName());
}

// ---------------------------------------------------------------------------
// OpenCL C version
// ---------------------------------------------------------------------------

TEST(OptionParser, SupportedClStdIsForwarded) {
  for (StringRef Std : {"CL1.0", "CL1.1", "CL1.2", "CL2.0", "CL3.0", "CL3.1",
                        "CLC++", "CLC++1.0", "CLC++2021"}) {
    OptionParser Parser("300");
    std::string Opt = ("-cl-std=" + Std).str();
    ASSERT_TRUE(Parser.process(Opt.c_str(), "")) << Opt;
    EXPECT_EQ(llvm::count(Parser.getCCArgs(), Opt), 1u) << Opt;
  }
}

TEST(OptionParser, UnsupportedClStdIsRejected) {
  OptionParser Parser("120");
  EXPECT_FALSE(Parser.process("-cl-std=CL1.3", ""));
}

TEST(OptionParser, CppForOpenCLDisablesGNU89Inline) {
  OptionParser Parser("300");
  ASSERT_TRUE(Parser.process("-cl-std=CLC++2021", ""));
  EXPECT_FALSE(contains(Parser.getCCArgs(), "-fgnu89-inline"));
}

// ---------------------------------------------------------------------------
// Application supplied options
// ---------------------------------------------------------------------------

TEST(OptionParser, UnknownOptionsAreIgnored) {
  // Unknown / target-specific backend options must not fail process(): they
  // are silently ignored so they can be consumed elsewhere.
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process(
      "-cl-intel-256-GRF-per-thread -pch-cpu -cl-ext=+cl_khr_fp64 input.cl",
      ""));
  auto &Args = Parser.getCCArgs();
  EXPECT_FALSE(contains(Args, "-cl-intel-256-GRF-per-thread"));
  EXPECT_FALSE(contains(Args, "-pch-cpu"));
  EXPECT_FALSE(contains(Args, "-cl-ext=+cl_khr_fp64"));
  EXPECT_FALSE(contains(Args, "input.cl"));
}

TEST(OptionParser, PreprocessorOptionsAreForwarded) {
  OptionParser Parser("120");
  ASSERT_TRUE(
      Parser.process(R"(-D FOO=1 -DBAR -D"BAZ=a b" -I /inc -I/inc2)", ""));
  auto &Args = Parser.getCCArgs();
  EXPECT_TRUE(contains(Args, "-DFOO=1"));
  EXPECT_TRUE(contains(Args, "-DBAR"));
  EXPECT_TRUE(contains(Args, "-DBAZ=a b"));
  EXPECT_TRUE(contains(Args, "-I/inc"));
  EXPECT_TRUE(contains(Args, "-I/inc2"));
}

TEST(OptionParser, WarningOptionsAreForwarded) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-w -Werror -Wno-error=foo", ""));
  auto &Args = Parser.getCCArgs();
  EXPECT_TRUE(contains(Args, "-w"));
  EXPECT_TRUE(contains(Args, "-Werror"));
  EXPECT_TRUE(contains(Args, "-Wno-error=foo"));
}

TEST(OptionParser, MathOptionsAreForwarded) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process(
      "-cl-single-precision-constant -cl-fp32-correctly-rounded-divide-sqrt "
      "-cl-mad-enable -cl-no-signed-zeros -cl-unsafe-math-optimizations "
      "-cl-finite-math-only -cl-uniform-work-group-size",
      ""));
  auto &Args = Parser.getCCArgs();
  for (StringRef Opt :
       {"-cl-single-precision-constant",
        "-cl-fp32-correctly-rounded-divide-sqrt", "-cl-mad-enable",
        "-cl-no-signed-zeros", "-cl-unsafe-math-optimizations",
        "-cl-finite-math-only", "-cl-uniform-work-group-size"})
    EXPECT_TRUE(contains(Args, Opt)) << Opt.str();
}

TEST(OptionParser, DenormsAreZero) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-cl-denorms-are-zero", ""));
  EXPECT_TRUE(contains(Parser.getCCArgs(), "-fdenormal-fp-math=preserve-sign"));
  EXPECT_FALSE(contains(Parser.getCCArgs(), "-cl-denorms-are-zero"));
}

TEST(OptionParser, FastRelaxedMathDefinesMacro) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-cl-fast-relaxed-math", ""));
  auto &Args = Parser.getCCArgs();
  EXPECT_TRUE(contains(Args, "-cl-fast-relaxed-math"));
  EXPECT_TRUE(containsPair(Args, "-D", "__FAST_RELAXED_MATH__=1"));
}

TEST(OptionParser, OptDisable) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-cl-opt-disable", ""));
  EXPECT_TRUE(Parser.hasOptDisable());
  EXPECT_TRUE(contains(Parser.getCCArgs(), "-cl-opt-disable"));
}

TEST(OptionParser, DebugInfo) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-g", ""));
  EXPECT_TRUE(contains(Parser.getCCArgs(), "-debug-info-kind=limited"));
  EXPECT_TRUE(contains(Parser.getCCArgs(), "-dwarf-version=4"));
}

TEST(OptionParser, LineTablesOnly) {
  for (const char *Opt : {"-gline-tables-only", "-profiling", "-coverage"}) {
    OptionParser Parser("120");
    ASSERT_TRUE(Parser.process(Opt, "")) << Opt;
    EXPECT_TRUE(
        contains(Parser.getCCArgs(), "-debug-info-kind=line-tables-only"))
        << Opt;
    EXPECT_TRUE(contains(Parser.getCCArgs(), "-dwarf-version=4")) << Opt;
  }
}

TEST(OptionParser, TripleOverride) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-triple spir-unknown-unknown", ""));
  EXPECT_TRUE(
      containsPair(Parser.getCCArgs(), "-triple", "spir-unknown-unknown"));
  EXPECT_EQ(llvm::count(Parser.getCCArgs(), "-triple"), 1u);
}

TEST(OptionParser, SourceNameOverride) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process(R"(-s "C:\path with spaces\kernel.cl")", ""));
#ifdef _WIN32
  EXPECT_EQ(Parser.getSourceName(), "c:/path with spaces/kernel.cl");
#else
  EXPECT_EQ(Parser.getSourceName(), "C:/path with spaces/kernel.cl");
#endif
  EXPECT_TRUE(containsPair(Parser.getCCArgs(), "-main-file-name", "kernel.cl"));
  EXPECT_EQ(Parser.getCCArgs().back(), Parser.getSourceName());
}

TEST(OptionParser, IgnoredOptions) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-x spir -spir-std=1.2 -cl-no-subgroup-ifp "
                             "-cl-kernel-arg-info -target-triple spir",
                             ""));
  auto &Args = Parser.getCCArgs();
  EXPECT_FALSE(contains(Args, "spir"));
  EXPECT_FALSE(contains(Args, "-spir-std=1.2"));
  EXPECT_FALSE(contains(Args, "-cl-no-subgroup-ifp"));
  EXPECT_EQ(llvm::count(Args, "-cl-kernel-arg-info"), 1u);
  EXPECT_EQ(llvm::count(Args, "-x"), 1u);
}

TEST(OptionParser, EmitSPIRVIsIgnoredInOptions) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("-emit-spirv", ""));
  EXPECT_FALSE(Parser.hasEmitSPIRV());
}

// ---------------------------------------------------------------------------
// Extra options supplied by the runtime
// ---------------------------------------------------------------------------

TEST(OptionParser, OptionsExAreForwardedVerbatim) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process(
      "", R"(-cl-ext=-all,+cl_khr_fp64 -foo -I C:\dir\ "-DSTR=a b")"));
  auto &Args = Parser.getCCArgs();
  EXPECT_TRUE(contains(Args, "-cl-ext=-all,+cl_khr_fp64"));
  EXPECT_TRUE(contains(Args, "-foo"));
  EXPECT_TRUE(containsPair(Args, "-I", R"(C:\dir\)"));
  EXPECT_TRUE(contains(Args, "-DSTR=a b"));
}

TEST(OptionParser, EmitSPIRV) {
  for (const char *Opt : {"-emit-spirv", "--emit-spirv"}) {
    OptionParser Parser("120");
    ASSERT_TRUE(Parser.process("", Opt)) << Opt;
    EXPECT_TRUE(Parser.hasEmitSPIRV()) << Opt;
    EXPECT_FALSE(contains(Parser.getCCArgs(), Opt)) << Opt;
  }
}

TEST(OptionParser, OptDisableInOptionsEx) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("", "-cl-opt-disable"));
  EXPECT_TRUE(Parser.hasOptDisable());
  EXPECT_TRUE(contains(Parser.getCCArgs(), "-cl-opt-disable"));
}

TEST(OptionParser, SPIRVExt) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("", "--spirv-ext=+SPV_KHR_foo,-SPV_KHR_bar"));
  EXPECT_TRUE(Parser.hasSPIRVExt());
  auto Exts = Parser.getSPIRVExts();
  ASSERT_EQ(Exts.size(), 2u);
  EXPECT_EQ(Exts[0], "+SPV_KHR_foo");
  EXPECT_EQ(Exts[1], "-SPV_KHR_bar");
  for (StringRef Arg : Parser.getCCArgs())
    EXPECT_FALSE(Arg.contains("spirv-ext")) << Arg.str();
}

TEST(OptionParser, LastSPIRVExtWins) {
  OptionParser Parser("120");
  ASSERT_TRUE(Parser.process("", "--spirv-ext=+all -spirv-ext=-SPV_KHR_bar"));
  auto Exts = Parser.getSPIRVExts();
  ASSERT_EQ(Exts.size(), 1u);
  EXPECT_EQ(Exts[0], "-SPV_KHR_bar");
}

TEST(OptionParser, InvalidSPIRVExtIsRejected) {
  for (const char *Opt :
       {"--spirv-ext=", "--spirv-ext=SPV_KHR_foo", "--spirv-ext=+"}) {
    OptionParser Parser("120");
    EXPECT_FALSE(Parser.process("", Opt)) << Opt;
  }
}

// ---------------------------------------------------------------------------
// check()
// ---------------------------------------------------------------------------

TEST(OptionParser, CheckAcceptsKnownOptions) {
  OptionParser Parser("200");
  char UnknownOptions[256] = {};
  EXPECT_TRUE(Parser.check("-cl-std=CL3.1 -cl-mad-enable -D FOO -I /inc "
                           "-Wno-error=foo -spir-std=1.2",
                           UnknownOptions, sizeof(UnknownOptions)));
}

TEST(OptionParser, CheckReportsUnknownOptions) {
  OptionParser Parser("200");
  char UnknownOptions[256] = {};
  EXPECT_FALSE(Parser.check("-cl-mad-enable -foo -cl-std=CL1.3 -bar",
                            UnknownOptions, sizeof(UnknownOptions)));
  EXPECT_STREQ(UnknownOptions, "-foo -cl-std=CL1.3 -bar ");
}

TEST(OptionParser, CheckReportsInputs) {
  OptionParser Parser("200");
  char UnknownOptions[256] = {};
  EXPECT_FALSE(Parser.check("-cl-mad-enable input.cl", UnknownOptions,
                            sizeof(UnknownOptions)));
  EXPECT_STREQ(UnknownOptions, "input.cl ");
}

TEST(OptionParser, CheckReportsMissingArgument) {
  OptionParser Parser("200");
  char UnknownOptions[256] = {};
  EXPECT_FALSE(Parser.check("-cl-mad-enable -s", UnknownOptions,
                            sizeof(UnknownOptions)));
  EXPECT_STREQ(UnknownOptions, "-s");
}

TEST(OptionParser, CheckTruncatesTheReport) {
  OptionParser Parser("200");
  char UnknownOptions[5];
  EXPECT_FALSE(Parser.check("-foobar", UnknownOptions, sizeof(UnknownOptions)));
  EXPECT_STREQ(UnknownOptions, "-foo");
}

} // namespace
