//===--- Options.h - Option table definitions -------------------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_OPTIONS_OPTIONS_H
#define OPENCL_CLANG_LIB_OPTIONS_OPTIONS_H

#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Option/OptTable.h"

enum OptionID {
  OPT_INVALID = 0,
#define OPTION(PREFIX, NAME, ID, ...) OPT_##ID,
#include "Options.inc"
#undef OPTION
  OPT_LAST,
};

const llvm::opt::OptTable &getOptTable();

// Returns the list of accepted values declared for the given option via the
// Values<> field in Options.td. Returns an empty list if the option declares no
// values or the ID is invalid.
llvm::SmallVector<llvm::StringRef> getOptionValuesSplit(OptionID ID);

// Returns the list of accepted values declared for the given option via the
// Values<> field in Options.td as a comma-separated string. Returns an empty
// string if the option declares no values or the ID is invalid.
llvm::StringRef getOptionValues(OptionID ID);

#endif // OPENCL_CLANG_LIB_OPTIONS_OPTIONS_H
