//===--- OptionsTest.cpp - Option table tests -------------------*- C++ -*-===//
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

// Unit tests for the TableGen-derived option table
// (opencl-clang/Options/Options.h): the OptTable instance, and the Values<>
// accessors used to validate option arguments in OptionParser.

#include "opencl-clang/Options/Options.h"

#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Option/Option.h"
#include "gtest/gtest.h"

using namespace llvm;

namespace {

opt::InputArgList parse(ArrayRef<const char *> Args) {
  unsigned MissingArgIndex = 0, MissingArgCount = 0;
  return getOptTable().ParseArgs(Args, MissingArgIndex, MissingArgCount);
}

TEST(Options, OptTableFindsKnownOption) {
  const char *Args[] = {"-cl-std=CL2.0"};
  opt::InputArgList ParsedArgs = parse(Args);
  opt::Arg *Arg = ParsedArgs.getLastArg(OPT_cl_std);
  ASSERT_NE(Arg, nullptr);
  EXPECT_STREQ(Arg->getValue(), "CL2.0");
}

TEST(Options, OptTableReturnsUnknownForUnrecognizedOption) {
  const char *Args[] = {"-cl-intel-256-GRF-per-thread"};
  opt::InputArgList ParsedArgs = parse(Args);
  EXPECT_TRUE(ParsedArgs.hasArg(OPT_UNKNOWN));
}

TEST(Options, OptTableParsesSeparateAndJoinedForms) {
  const char *Args[] = {"-D", "FOO=1", "-DBAR", "-I", "/inc", "-s", "k.cl"};
  opt::InputArgList ParsedArgs = parse(Args);
  EXPECT_EQ(ParsedArgs.getAllArgValues(OPT_D),
            (std::vector<std::string>{"FOO=1", "BAR"}));
  EXPECT_EQ(ParsedArgs.getLastArgValue(OPT_I), "/inc");
  EXPECT_EQ(ParsedArgs.getLastArgValue(OPT_s), "k.cl");
}

TEST(Options, OptTableParsesOptionsStartingWithPrefixChars) {
  // The options which names start with the characters of the "-cl-" string
  // must be recognized.
  const char *Args[] = {"-coverage", "-cl-mad-enable"};
  opt::InputArgList ParsedArgs = parse(Args);
  EXPECT_TRUE(ParsedArgs.hasArg(OPT_coverage));
  EXPECT_TRUE(ParsedArgs.hasArg(OPT_cl_mad_enable));
  EXPECT_FALSE(ParsedArgs.hasArg(OPT_UNKNOWN));
}

TEST(Options, OptTableParsesWarningOptions) {
  const char *Args[] = {"-Werror", "-Wno-error=foo", "-w"};
  opt::InputArgList ParsedArgs = parse(Args);
  EXPECT_TRUE(ParsedArgs.hasArg(OPT_Werror));
  EXPECT_EQ(ParsedArgs.getLastArgValue(OPT_W_Joined), "no-error=foo");
  EXPECT_TRUE(ParsedArgs.hasArg(OPT_w));
}

TEST(Options, GetOptionValuesClStd) {
  EXPECT_EQ(getOptionValues(OPT_cl_std),
            "CL1.0,CL1.1,CL1.2,CL2.0,CL3.0,CL3.1,CLC++,CLC++1.0,CLC++2021");
}

TEST(Options, GetOptionValuesSplitClStd) {
  SmallVector<StringRef> Values = getOptionValuesSplit(OPT_cl_std);
  SmallVector<StringRef> Expected = {"CL1.0", "CL1.1",    "CL1.2",
                                     "CL2.0", "CL3.0",    "CL3.1",
                                     "CLC++", "CLC++1.0", "CLC++2021"};
  EXPECT_EQ(Values, Expected);
}

TEST(Options, GetOptionValuesSpirStd) {
  SmallVector<StringRef> Values = getOptionValuesSplit(OPT_spir_std);
  SmallVector<StringRef> Expected = {"1.0", "1.2"};
  EXPECT_EQ(Values, Expected);
}

TEST(Options, GetOptionValuesEmptyForOptionWithoutValues) {
  // -g (OPT_g) does not declare a Values<> list in Options.td.
  EXPECT_TRUE(getOptionValues(OPT_g).empty());
  EXPECT_TRUE(getOptionValuesSplit(OPT_g).empty());
}

TEST(Options, GetOptionValuesEmptyForInvalidID) {
  EXPECT_TRUE(getOptionValues(OPT_INVALID).empty());
  EXPECT_TRUE(getOptionValuesSplit(OPT_INVALID).empty());
  EXPECT_TRUE(getOptionValues(OPT_LAST).empty());
  EXPECT_TRUE(getOptionValuesSplit(OPT_LAST).empty());
}

} // namespace
