//===--- SPIRV.cpp - SPIR-V writer wrapper implementation -------*- C++ -*-===//
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

#include "opencl-clang/SPIRV.h"
#include "opencl-clang/SmallVectorStream.h"

#ifdef USE_PREBUILT_LLVM
#include "LLVMSPIRVLib/LLVMSPIRVLib.h"
#else // USE_PREBUILT_LLVM
#include "LLVMSPIRVLib.h"
#endif // USE_PREBUILT_LLVM

#include <ostream>

using namespace llvm;

Expected<SPIRVWriterAction::OutputType>
SPIRVWriterAction::runImpl(InputType &&Input) {
  SmallVector<char> Output;
  SmallVectorBuffer OutBuffer(Output);
  std::ostream Out(&OutBuffer);

  std::string ErrMsg;
  bool Success = writeSpirv(Input.get(), Opts, Out, ErrMsg);
  if (!Success)
    return createStringError(inconvertibleErrorCode(), ErrMsg);

  return Output;
}
