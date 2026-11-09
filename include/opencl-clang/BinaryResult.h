//===--- BinaryResult.h - Compilation result wrapper ------------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_BINARYRESULT_H
#define OPENCL_CLANG_BINARYRESULT_H

#include "opencl-clang/OpenCLClang.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include <string>

// The following #defines are used as return value of Compile() API and defined
// in https://github.com/KhronosGroup/OpenCL-Headers/blob/master/CL/cl.h
#define CL_SUCCESS 0
#define CL_COMPILE_PROGRAM_FAILURE -15
#define CL_INVALID_BUILD_OPTIONS -43
#define CL_OUT_OF_HOST_MEMORY -6

class OCLFEBinaryResult : public Intel::OpenCL::ClangFE::IOCLFEBinaryResult {
  // IOCLFEBinaryResult
public:
  size_t GetIRSize() const override { return IRBuffer.size(); }

  const void *GetIR() const override { return IRBuffer.data(); }

  const char *GetIRName() const override { return IRName.c_str(); }

  Intel::OpenCL::ClangFE::IrType GetIRType() const override { return Type; }

  const char *GetErrorLog() const override { return Log.c_str(); }

  void Release() override { delete this; }

  // OCLFEBinaryResult
public:
  OCLFEBinaryResult()
      : Type(Intel::OpenCL::ClangFE::IrTypeUnknown), Result(CL_SUCCESS) {}

  void setIRBuffer(llvm::SmallVector<char> &&Buffer) {
    IRBuffer = std::move(Buffer);
  }

  void setLog(std::string &&L) { Log = std::move(L); }

  void setIRName(llvm::StringRef Name) { IRName = Name.str(); }

  void setIRType(Intel::OpenCL::ClangFE::IrType Type) { this->Type = Type; }

  void setResult(int Result) { this->Result = Result; }

  int getResult() const { return Result; }

private:
  llvm::SmallVector<char> IRBuffer;
  std::string Log;
  std::string IRName;
  Intel::OpenCL::ClangFE::IrType Type;
  int Result;
};

#endif // OPENCL_CLANG_BINARYRESULT_H
