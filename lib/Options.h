//===--- Options.h - OpenCL compile/link option parsing ----------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_OPTIONS_H
#define OPENCL_CLANG_LIB_OPTIONS_H

#include "llvm/Option/Arg.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Option/Option.h"
#include "llvm/Option/OptTable.h"
#include "clang/Basic/OpenCLOptions.h"

#ifdef USE_PREBUILT_LLVM
#include "LLVMSPIRVLib/LLVMSPIRVOpts.h"
#else // USE_PREBUILT_LLVM
#include "LLVMSPIRVOpts.h"
#endif // USE_PREBUILT_LLVM

#include <atomic>
#include <list>

enum COMPILE_OPT_ID {
  OPT_COMPILE_INVALID = 0, // This is not an option ID.
#define PREFIX(NAME, VALUE)
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS,         \
               VISIBILITY, PARAM, HELPTEXT, HELPTEXTSFORVARIANTS, METAVAR,     \
               VALUES, SUBCOMMANDIDS_OFFSET)                                   \
  OPT_COMPILE_##ID,
#include "OpenCLClangOptions.inc"
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
    return ArgStrings[index];
  }

  unsigned getNumInputArgStrings() const override {
    return OriginalArgsCount;
  }

  std::string getFilteredArgs(int id) const;

public:
  /// makeIndex - Get an index for the given string(s).
  unsigned makeIndex(llvm::StringRef str) const;
  unsigned makeIndex(llvm::StringRef str0, llvm::StringRef str1) const;

  const char *MakeArgStringRef(llvm::StringRef str) const override;

  virtual ~OpenCLArgList() {}

private:
  /// List of argument strings used by the contained Args.
  ///
  /// This is mutable since we treat the ArgList as being the list
  /// of Args, and allow routines to add new strings (to have a
  /// convenient place to store the memory) via makeIndex.
  mutable llvm::opt::ArgStringList ArgStrings;

  /// Strings for synthesized arguments.
  ///
  /// This is mutable since we treat the ArgList as being the list
  /// of Args, and allow routines to add new strings (to have a
  /// convenient place to store the memory) via makeIndex.
  mutable std::list<std::string> SynthesizedStrings;

  /// The number of original input argument strings.
  unsigned OriginalArgsCount;
};

//
// OpenCL specific OptTable
//
class OpenCLOptTable : public llvm::opt::OptTable {
public:
  OpenCLOptTable(const llvm::opt::OptTable::Tables &pOptionTables)
      : llvm::opt::OptTable(pOptionTables) {}

  OpenCLArgList *parseArgs(const char *szOptions, unsigned &missingArgIndex,
                           unsigned &missingArgCount) const;

private:
  /// Synthesized arguments - owned to avoid memory leaks.
  mutable std::vector<std::unique_ptr<llvm::opt::Arg>> SynthesizedArgs;
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
      : OpenCLVer(pszOpenCLVer) {
    assert(pszOpenCLVer != NULL);
  }

  std::string processOptions(const OpenCLArgList &args,
                             const char *pszOptionsEx,
                             ArgsVector &effectiveArgs);

private:
  std::string OpenCLVer;
  static std::atomic<int> ProgID;
};

///
// Options parser for the Compile function
//
class CompileOptionsParser {
public:
  CompileOptionsParser(const char *pszOpenCLVersion)
      : CommonFilter(pszOpenCLVersion), EmitSPIRV(false), OptDisable(false) {}

  //
  // Validates and prepares the effective options to pass to clang upon
  // compilation
  //
  int processOptions(const char *pszOptions, const char *pszOptionsEx);

  //
  // Just validates the user supplied OpenCL compile options
  //
  bool checkOptions(const char *pszOptions, char *pszUnknownOptions,
                    size_t uiUnknownOptionsSize);

  //
  // Returns the calculated source name for the input source
  //
  std::string getSourceName() const { return SourceName; }

  const char *const *beginArgs() const { return EffectiveArgsRaw.data(); }

  const char *const *endArgs() const {
    return beginArgs() + EffectiveArgsRaw.size();
  }

  llvm::ArrayRef<const char *> args() {
    return EffectiveArgsRaw;
  }

  std::string getEffectiveOptionsAsString() const;

  bool hasEmitSPIRV() const { return EmitSPIRV; }

  bool hasSPIRVExt() const { return HasSPIRVExt; }

  SPIRV::TranslatorOpts::ExtensionsStatusMap getSPIRVExtStatusMap() const {
    return SPIRVExtStatusMap;
  }

  bool hasOptDisable() const { return OptDisable; }

private:
  OpenCLCompileOptTable OptTbl;
  EffectiveOptionsFilter CommonFilter;
  ArgsVector EffectiveArgs;
  llvm::SmallVector<const char *, 16> EffectiveArgsRaw;
  std::string SourceName;
  bool EmitSPIRV;
  bool HasSPIRVExt = false;
  SPIRV::TranslatorOpts::ExtensionsStatusMap SPIRVExtStatusMap = {};
  bool OptDisable;
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
  // in_quote   - are we in a quote now (i.e. a quote character
  //              appeared without a matching closing quote)
  // tok        - accumulates the current token. once an unquoted
  //              delimiter or end of string is encountered, tok
  //              is added to the return vector and re-initialized
  //
  // The escape char only escapes the quote, the escape char itself,
  // or a delimiter - it is otherwise passed through verbatim, so
  // that arbitrary text (e.g. "\n" inside a macro value, or Windows
  // paths) isn't corrupted.
  //
  bool in_quote = false;
  std::string tok;

  while (ptr < end) {
    char c = str[ptr];
    if (c == escape && ptr + 1 < end &&
        (str[ptr + 1] == quote || str[ptr + 1] == escape ||
         delims.find(str[ptr + 1]) != llvm::StringRef::npos)) {
      tok += str[ptr + 1];
      ptr += 2;
      continue;
    } else if (c == quote) {
      in_quote = in_quote ? false : true;
    } else if (delims.find(c) != llvm::StringRef::npos) {
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
      tok += c;
    }
    ++ptr;
  }
  if (!tok.empty()) {
    *(dest++) = tok;
  }
}

#endif // OPENCL_CLANG_LIB_OPTIONS_H
