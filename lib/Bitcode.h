//===--- Bitcode.h - LLVM bitcode writer interface --------------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_BITCODE_H
#define OPENCL_CLANG_LIB_BITCODE_H

#include "Action.h"

#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/Module.h"

#include <memory>

class BCWriterAction
    : public Action<BCWriterAction, std::unique_ptr<llvm::Module>,
                    llvm::SmallVector<char>> {
  using Base = Action<BCWriterAction, std::unique_ptr<llvm::Module>,
                      llvm::SmallVector<char>>;

public:
  BCWriterAction() = default;

private:
  friend Base;
  llvm::Expected<OutputType> runImpl(InputType &&Input);
};

#endif // OPENCL_CLANG_LIB_BITCODE_H
