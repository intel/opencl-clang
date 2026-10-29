//===--- CommandLine.cpp - Command line parsing utilities -------*- C++ -*-===//
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

#include "opencl-clang/Options/CommandLine.h"

#include "llvm/ADT/SmallString.h"

using namespace llvm;

void tokenizeCommandLine(StringRef Data, StringSaver &Saver,
                         SmallVectorImpl<const char *> &OutArgs,
                         StringRef Delimiters, char Quote, char Escape) {
  size_t Pos = Data.find_first_not_of(Delimiters);
  const size_t End = Data.size();

  bool InQuote = false;
  SmallString<128> Token;

  while (Pos < End) {
    const char C = Data[Pos];

    if (Escape != '\0' && C == Escape && Pos + 1 < End) {
      const char Next = Data[Pos + 1];
      if ((Quote != '\0' && Next == Quote) || Next == Escape ||
          Delimiters.contains(Next)) {
        Token.push_back(Next);
        Pos += 2;
        continue;
      }
    }

    if (Quote != '\0' && C == Quote) {
      InQuote = !InQuote;
    } else if (Delimiters.contains(C)) {
      if (InQuote) {
        Token.push_back(C);
      } else {
        OutArgs.push_back(Saver.save(Token.str()).data());
        Token.clear();
        Pos = Data.find_first_not_of(Delimiters, Pos);
        continue;
      }
    } else {
      Token.push_back(C);
    }
    ++Pos;
  }

  if (!Token.empty())
    OutArgs.push_back(Saver.save(Token.str()).data());
}
