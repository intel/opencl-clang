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

  \file common_clang.h

  \brief Defines the common structures for both compile and link options parsing

\*****************************************************************************/

#ifndef COMMON_CLANG_OPTIONS_H
#define COMMON_CLANG_OPTIONS_H

#include "llvm/Option/Arg.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Option/Option.h"
#include "clang/Basic/OpenCLOptions.h"

#include <list>

enum COMPILE_OPT_ID {
  OPT_COMPILE_INVALID = 0, // This is not an option ID.
#define PREFIX(NAME, VALUE)
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS, PARAM,  \
               HELPTEXT, METAVAR, VALUES)                                      \
  OPT_COMPILE_##ID,
#include "opencl_clang_options.inc"
  OPT_COMPILE_LAST_OPTION
#undef OPTION
#undef PREFIX
};

typedef std::list<std::string> ArgsVector;

//
// Extend the ArgList to allow the argument parsing from single string.
//
// Originally llvm::opt::ArgList allowed only parsing or array of options
// string.
//
class OpenCLArgList : public llvm::opt::ArgList {
public:
  OpenCLArgList(const char *pszOptions);

  const char *getArgString(unsigned index) const override {
    return m_argStrings[index];
  }

  unsigned getNumInputArgStrings() const override {
    return m_uiOriginalArgsCount;
  }

  std::string getFilteredArgs(int id) const;

public:
  /// MakeIndex - Get an index for the given string(s).
  unsigned MakeIndex(llvm::StringRef str) const;
  unsigned MakeIndex(llvm::StringRef str0, llvm::StringRef str1) const;

  const char *MakeArgStringRef(llvm::StringRef str) const override;

private:
  /// List of argument strings used by the contained Args.
  ///
  /// This is mutable since we treat the ArgList as being the list
  /// of Args, and allow routines to add new strings (to have a
  /// convenient place to store the memory) via MakeIndex.
  mutable llvm::opt::ArgStringList m_argStrings;

  /// Strings for synthesized arguments.
  ///
  /// This is mutable since we treat the ArgList as being the list
  /// of Args, and allow routines to add new strings (to have a
  /// convenient place to store the memory) via MakeIndex.
  mutable std::list<std::string> m_synthesizedStrings;

  /// The number of original input argument strings.
  unsigned m_uiOriginalArgsCount;
};

//
// OpenCL specific OptTable
//
class OpenCLOptTable : public llvm::opt::OptTable {
public:
  OpenCLOptTable(llvm::ArrayRef<Info> pOptionInfos)
      : OptTable(pOptionInfos) {}

  OpenCLArgList *ParseArgs(const char *szOptions, unsigned &missingArgIndex,
                           unsigned &missingArgCount) const;

private:
  /// Synthesized arguments - owned to avoid memory leaks.
  mutable std::vector<std::unique_ptr<llvm::opt::Arg>> m_synthesizedArgs;
};

// OpenCL OptTable for compile options
class OpenCLCompileOptTable : public OpenCLOptTable {
public:
  OpenCLCompileOptTable();
};

// OpenCL OptTable for link options
class OpenCLLinkOptTable : public OpenCLOptTable {
public:
  OpenCLLinkOptTable();
};

///
// Options filter that validates the opencl used options
//
class EffectiveOptionsFilter {
public:
  EffectiveOptionsFilter(const char *pszOpenCLVer)
      : m_opencl_ver(pszOpenCLVer) {
    assert(pszOpenCLVer != NULL);
  }

  std::string processOptions(const OpenCLArgList &args,
                             const char *pszOptionsEx,
                             ArgsVector &effectiveArgs);

private:
  std::string m_opencl_ver;
  static int s_progID;
};

///
// Options parser for the Compile function
//
class CompileOptionsParser {
public:
  CompileOptionsParser(const char *pszOpenCLVersion)
      : m_commonFilter(pszOpenCLVersion), m_emitSPIRV(false), m_optDisable(false) {}

  //
  // Validates and prepares the effective options to pass to clang upon
  // compilation
  //
  void processOptions(const char *pszOptions, const char *pszOptionsEx);

  //
  // Just validates the user supplied OpenCL compile options
  //
  bool checkOptions(const char *pszOptions, char *pszUnknownOptions,
                    size_t uiUnknownOptionsSize);

  //
  // Returns the calculated source name for the input source
  //
  std::string getSourceName() const { return m_sourceName; }

  const char *const *beginArgs() const { return m_effectiveArgsRaw.data(); }

  const char *const *endArgs() const {
    return beginArgs() + m_effectiveArgsRaw.size();
  }

  llvm::ArrayRef<const char *> args() {
    return m_effectiveArgsRaw;
  }

  std::string getEffectiveOptionsAsString() const;

  bool hasEmitSPIRV() const { return m_emitSPIRV; }
  bool hasOptDisable() const { return m_optDisable; }

private:
  OpenCLCompileOptTable m_optTbl;
  EffectiveOptionsFilter m_commonFilter;
  ArgsVector m_effectiveArgs;
  llvm::SmallVector<const char *, 16> m_effectiveArgsRaw;
  std::string m_sourceName;
  bool m_emitSPIRV;
  bool m_optDisable;
};

// Tokenize a string into tokens separated by any char in 'delims'.
// Support quoting to allow some tokens to contain delimiters, with possible
// escape characters to support quotes inside quotes.
// To disable quoting or escaping, set relevant chars to '\x00'.
// Unescaped quotes are dropped.

template <class OutIt>
void quoted_tokenize(OutIt dest, llvm::StringRef str, llvm::StringRef delims,
                     char quote, char escape) {
  llvm::StringRef::size_type ptr = str.find_first_not_of(delims);
  llvm::StringRef::size_type end = str.size();

  if (ptr == llvm::StringRef::npos)
    return;

  // pArg state machine, with the following state vars:
  //
  // ptr        - points to the current char in the string
  // is_escaped - is the current char escaped (i.e. was the
  //              previous char = escape, inside a quote)
  // in_quote   - are we in a quote now (i.e. a quote character
  //              appeared without a matching closing quote)
  // tok        - accumulates the current token. once an unquoted
  //              delimiter or end of string is encountered, tok
  //              is added to the return vector and re-initialized
  //
  bool is_escaped = false;
  bool in_quote = false;
  std::string tok;

  while (ptr < end) {
    char c = str[ptr];
    if (c == escape) {
      tok += c;
      is_escaped = is_escaped ? false : true;
    } else if (c == quote) {
      if (is_escaped) {
        tok += c;
        is_escaped = false;
      } else {
        in_quote = in_quote ? false : true;
      }
    } else if (delims.find(c) != llvm::StringRef::npos) {
      is_escaped = false;
      if (in_quote) {
        tok += c;
      } else {
        *(dest++) = tok;
        tok.clear();
        ptr = str.find_first_not_of(delims, ptr);
        if (ptr != llvm::StringRef::npos) {
          continue;
        } else {
          break;
        }
      }
    } else {
      is_escaped = false;
      tok += c;
    }
    ++ptr;
  }
  if (!tok.empty()) {
    *(dest++) = tok;
  }
}

#endif
