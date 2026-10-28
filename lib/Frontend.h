//===--- Frontend.h - Clang frontend wrapper interface ----------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_FRONTEND_H
#define OPENCL_CLANG_LIB_FRONTEND_H

#include "Action.h"

#include "llvm/ADT/StringRef.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"

#include <memory>

struct FrontendSource {
  FrontendSource(const char *Data, const char *Filename)
      : Data(Data), Filename(Filename) {}
  FrontendSource(const char *Data, const std::string &Filename)
      : Data(Data), Filename(Filename) {}

  llvm::StringRef Data;
  llvm::StringRef Filename;
};

struct FrontendInput {
  llvm::ArrayRef<FrontendSource> Sources;
  llvm::ArrayRef<const char *> Args;
};

class FrontendAction : public Action<FrontendAction, FrontendInput,
                                     std::unique_ptr<llvm::Module>> {
  using Base =
      Action<FrontendAction, FrontendInput, std::unique_ptr<llvm::Module>>;

public:
  std::string &&getDiagnostics();

  static std::unique_ptr<FrontendAction> get(llvm::LLVMContext &Ctx);

protected:
  friend Base;
  llvm::Expected<OutputType> runImpl(InputType &&Input);

  FrontendAction() = default;
};

#endif // OPENCL_CLANG_LIB_FRONTEND_H
