//===--- SmallVectorStream.h - SmallVector-based streambuf ------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_SMALLVECTORSTREAM_H
#define OPENCL_CLANG_LIB_SMALLVECTORSTREAM_H

#include "llvm/ADT/SmallVector.h"

#include <streambuf>

class SmallVectorBuffer : public std::streambuf {
public:
  SmallVectorBuffer() = delete;
  SmallVectorBuffer(const SmallVectorBuffer &) = delete;
  SmallVectorBuffer &operator=(const SmallVectorBuffer &) = delete;
  SmallVectorBuffer(llvm::SmallVectorImpl<char> &O) : OS(O) {}

private:
  // Since we don't touch any pointer in streambuf(pbase, pptr, epptr) this is
  // the only method we need to override.
  virtual std::streamsize xsputn(const char *s, std::streamsize n) override {
    OS.append(s, s + n);
    return n;
  }

  // All memory management is delegated to llvm::SmallVectorImpl
  llvm::SmallVectorImpl<char> &OS;
};

#endif // OPENCL_CLANG_LIB_SMALLVECTORSTREAM_H
