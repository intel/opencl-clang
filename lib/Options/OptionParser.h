//===--- OptionParser.h - Option parsing implementation ---------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_OPTIONS_OPTIONPARSER_H
#define OPENCL_CLANG_LIB_OPTIONS_OPTIONPARSER_H

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Option/Arg.h"

#include <string>

/// Translates the OpenCL build options passed to the Compile() API into the
/// list of the Clang frontend (-cc1) arguments.
///
/// The application supplied options (\p Options) are parsed using the option
/// table defined in Options.td. The options unknown to opencl-clang are
/// ignored, as they may be consumed by other components (e.g. the backend).
/// The extra options supplied by the runtime (\p OptionsEx) are passed to the
/// Clang frontend verbatim, except for the opencl-clang specific ones.
class OptionParser {
public:
  explicit OptionParser(const char *OpenCLVersion)
      : OCLVersion(OpenCLVersion) {}

  /// Validates and prepares the effective options to pass to the Clang
  /// frontend. Returns false if the options are invalid.
  bool process(const char *Options, const char *OptionsEx);

  /// Just validates the application supplied OpenCL compile options. The
  /// unknown options are reported in \p UnknownOptions.
  bool check(const char *Options, char *UnknownOptions,
             size_t UnknownOptionsSize) const;

  /// Returns the source name used for the main input file.
  llvm::StringRef getSourceName() const { return SourceName; }

  /// Returns the effective arguments for the Clang frontend.
  llvm::SmallVectorImpl<llvm::SmallString<32>> &getCCArgs() { return CCArgs; }

  bool hasOptDisable() const { return OptDisable; }
  bool hasEmitSPIRV() const { return EmitSPIRV; }

  /// Returns true if the list of the SPIR-V extensions to use is specified.
  bool hasSPIRVExt() const { return HasSPIRVExt; }

  /// Returns the SPIR-V extensions specified by the last --spirv-ext= option,
  /// each one prefixed by '+' or '-'.
  llvm::ArrayRef<llvm::SmallString<64>> getSPIRVExts() const {
    return SPIRVExts;
  }

private:
  void handleOption(const llvm::opt::Arg *A,
                    const llvm::opt::InputArgList &ParsedArgs);
  void initDefaultOCLArgs();
  bool handleOptionEx(llvm::StringRef Arg);

  llvm::SmallString<32> Triple;
  llvm::SmallString<32> SourceName;
  llvm::SmallString<8> OCLVersion;

  llvm::SmallVector<llvm::SmallString<32>> CCArgs;
  llvm::SmallVector<llvm::SmallString<64>> SPIRVExts;

  bool CppStdUsed = false;
  bool OptDisable = false;
  bool EmitSPIRV = false;
  bool HasSPIRVExt = false;
};

#endif // OPENCL_CLANG_LIB_OPTIONS_OPTIONPARSER_H
