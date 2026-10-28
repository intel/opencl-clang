//===--- CommandLine.h - Command line parsing utilities ---------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_OPTIONS_COMMANDLINE_H
#define OPENCL_CLANG_LIB_OPTIONS_COMMANDLINE_H

#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/StringSaver.h"

/// Tokenize a command line string into individual arguments.
///
/// This function splits a command line string into separate tokens based on
/// delimiters, while respecting quoted strings and escape sequences. Tokens
/// are saved using the provided StringSaver and pointers to them are appended
/// to the output vector.
///
/// \param Data The command line string to tokenize.
/// \param Saver A StringSaver used to allocate and store the tokenized strings.
/// \param OutArgs Output vector where pointers to the tokenized arguments
///                will be appended.
/// \param Delimiters Characters that act as token separators. Default is
///                   space and tab (" \t").
/// \param Quote The character used for quoting. A quoted section allows
///              delimiters to be treated as literal characters. Unescaped
///              quotes are dropped. Default is the double quote. The null
///              character disables quoting.
/// \param Escape The escape character. It escapes the quote character, the
///               escape character itself and the delimiters; otherwise it is
///               passed through verbatim, so that arbitrary text (e.g. "\n"
///               inside a macro value, or Windows paths) isn't corrupted.
///               Default is backslash. The null character disables escaping.
///
/// \note Tokens are appended to OutArgs, which is not cleared by this function.
/// \note An empty token is produced for an empty quoted section ("") that is
///       followed by a delimiter.
void tokenizeCommandLine(llvm::StringRef Data, llvm::StringSaver &Saver,
                         llvm::SmallVectorImpl<const char *> &OutArgs,
                         llvm::StringRef Delimiters = " \t", char Quote = '"',
                         char Escape = '\\');

#endif // OPENCL_CLANG_LIB_OPTIONS_COMMANDLINE_H
