//===--- CommandLineTest.cpp - Command line tokenizer tests -----*- C++ -*-===//
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

// Unit tests for tokenizeCommandLine (opencl-clang/Options/CommandLine.h).
// Covers default and custom delimiters/quote/escape characters, quoted
// strings, escape sequences and empty tokens.

#include "opencl-clang/Options/CommandLine.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/Allocator.h"
#include "llvm/Support/StringSaver.h"
#include "gtest/gtest.h"

using namespace llvm;

namespace {

/// Tokenizes \p Input with the given (optional) delimiters/quote/escape and
/// checks the result against \p Reference.
template <typename... Args>
void testTokenizer(StringRef Input, ArrayRef<const char *> Reference,
                   Args &&...Options) {
  SmallVector<const char *> Actual;
  BumpPtrAllocator Alloc;
  StringSaver Saver(Alloc);
  tokenizeCommandLine(Input, Saver, Actual, std::forward<Args>(Options)...);
  ASSERT_EQ(Reference.size(), Actual.size())
      << "Token count mismatch for input: <" << Input.str() << ">";
  for (size_t I = 0, E = Actual.size(); I != E; ++I)
    EXPECT_STREQ(Reference[I], Actual[I])
        << "Token mismatch at index " << I << " for input: <" << Input.str()
        << ">";
}

TEST(TokenizeCommandLine, Empty) { testTokenizer("", {}); }

TEST(TokenizeCommandLine, OnlyDelimiters) { testTokenizer("   \t\t  \t ", {}); }

TEST(TokenizeCommandLine, SimpleTokens) {
  const char *Reference[] = {"-cl-std=CL2.0", "-x", "cl", "input.cl"};
  testTokenizer("-cl-std=CL2.0 -x cl input.cl", Reference);
}

TEST(TokenizeCommandLine, AdjacentDelimitersCollapse) {
  const char *Reference[] = {"foo", "bar", "baz"};
  testTokenizer("  foo    bar\t\tbaz  ", Reference);
}

TEST(TokenizeCommandLine, QuotedStringWithSpaces) {
  const char *Reference[] = {"foo bar"};
  testTokenizer(R"("foo bar")", Reference);
}

TEST(TokenizeCommandLine, QuotesInsideToken) {
  // Unescaped quotes are dropped, so a quoted section can be a part of a
  // token.
  const char *Reference[] = {"-DSTR=a b", "-s/path with spaces/kernel.cl"};
  testTokenizer(R"(-DSTR="a b" -s"/path with spaces/kernel.cl")", Reference);
}

TEST(TokenizeCommandLine, SingleQuoteIsNotSpecial) {
  const char *Reference[] = {"'foo", "bar'"};
  testTokenizer("'foo bar'", Reference);
}

TEST(TokenizeCommandLine, EscapedDelimiterIsLiteral) {
  const char *Reference[] = {"/path with spaces/kernel.cl"};
  testTokenizer(R"(/path\ with\ spaces/kernel.cl)", Reference);
}

TEST(TokenizeCommandLine, EscapedQuoteIsLiteral) {
  const char *Reference[] = {R"(-DSTRING="%d\n")"};
  testTokenizer(R"(-DSTRING=\"%d\n\")", Reference);
}

TEST(TokenizeCommandLine, EscapedEscapeIsLiteral) {
  const char *Reference[] = {R"(foo\)", "bar"};
  testTokenizer(R"(foo\\ bar)", Reference);
}

TEST(TokenizeCommandLine, EscapeBeforeOrdinaryCharIsKept) {
  // A backslash that does not escape a quote, itself or a delimiter is passed
  // through verbatim, e.g. "\n" inside a macro value or Windows paths.
  const char *Reference[] = {R"(-DSTRING=%d\n)", R"(C:\path\to\kernel.cl)"};
  testTokenizer(R"(-DSTRING="%d\n" C:\path\to\kernel.cl)", Reference);
}

TEST(TokenizeCommandLine, TrailingEscapeIsKept) {
  const char *Reference[] = {"foo", R"(bar\)"};
  testTokenizer(R"(foo bar\)", Reference);
}

TEST(TokenizeCommandLine, EmptyQuotedTokens) {
  // An empty quoted section produces an empty token if it is followed by a
  // delimiter.
  const char *Reference[] = {"foo=", "", ""};
  testTokenizer(R"(foo=""  "" "" "")", Reference);
}

TEST(TokenizeCommandLine, QuotedSpaceIsKept) {
  const char *Reference[] = {" ", " "};
  testTokenizer(R"(" "  " ")", Reference);
}

TEST(TokenizeCommandLine, UnclosedQuote) {
  const char *Reference[] = {"foo", "bar baz"};
  testTokenizer(R"(foo "bar baz)", Reference);
}

TEST(TokenizeCommandLine, CustomDelimiters) {
  const char *Reference[] = {"foo", "bar", "baz"};
  testTokenizer("foo,bar;baz", Reference, StringRef(",;"));
}

TEST(TokenizeCommandLine, CustomQuote) {
  const char *Reference[] = {"foo bar"};
  testTokenizer("|foo bar|", Reference, StringRef(" "), '|');
}

TEST(TokenizeCommandLine, CustomEscapeChar) {
  const char *Reference[] = {"foo bar", R"(a\b)"};
  testTokenizer(R"(foo^ bar a\b)", Reference, StringRef(" \t"), '"', '^');
}

TEST(TokenizeCommandLine, EscapingDisabled) {
  const char *Reference[] = {R"(-IC:\path\)", R"(-DSTRING=\%d\n\)"};
  testTokenizer(R"(-IC:\path\ -DSTRING=\"%d\n\")", Reference, StringRef(" \t"),
                '"', '\0');
}

TEST(TokenizeCommandLine, QuotingDisabled) {
  const char *Reference[] = {R"("foo)", R"(bar")"};
  testTokenizer(R"("foo bar")", Reference, StringRef(" \t"), '\0');
}

TEST(TokenizeCommandLine, OutArgsAreAppendedNotCleared) {
  SmallVector<const char *> Actual;
  Actual.push_back("preexisting");

  BumpPtrAllocator Alloc;
  StringSaver Saver(Alloc);
  tokenizeCommandLine("foo bar", Saver, Actual);
  ASSERT_EQ(Actual.size(), 3u);
  EXPECT_STREQ(Actual[0], "preexisting");
  EXPECT_STREQ(Actual[1], "foo");
  EXPECT_STREQ(Actual[2], "bar");
}

} // namespace
