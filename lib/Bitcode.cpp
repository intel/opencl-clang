//===--- Bitcode.cpp - LLVM bitcode writer implementation -------*- C++ -*-===//
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

#include "Bitcode.h"

#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Support/SmallVectorMemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

Expected<BCWriterAction::OutputType>
BCWriterAction::runImpl(InputType &&Input) {
  SmallVector<char> Buffer;
  raw_svector_ostream OS(Buffer);
  WriteBitcodeToFile(*Input.get(), OS);
  return Buffer;
}
