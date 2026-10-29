//===--- BuiltInHeadersMock.cpp - BuiltInHeaders test double ---*- C++ -*-===//
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

// A lightweight test double for opencl-clang/BuiltInHeaders.h, used in place
// of lib/BuiltInHeaders.cpp (and its embedded headers dependency) so that
// tests exercising OptionParser do not need to link the real embedded OpenCL
// header blobs.
//
// BuiltInHeaders::get()/getIncludePath()/getFileSystem() are ordinary (non-
// virtual) member functions declared in BuiltInHeaders.h and defined out of
// line, so this translation unit provides an alternate definition of those
// symbols instead of the real one -- a link-seam mock. Only one of the two
// definitions (real or mock) may ever be linked into a given binary.

#include "opencl-clang/BuiltInHeaders.h"

using namespace llvm;

const BuiltInHeaders &BuiltInHeaders::get() {
  static const BuiltInHeaders Instance;
  return Instance;
}

const char *BuiltInHeaders::getIncludePath() const {
  return "/mock-include/opencl-clang/";
}

IntrusiveRefCntPtr<vfs::OverlayFileSystem>
BuiltInHeaders::getFileSystem() const {
  return makeIntrusiveRefCnt<vfs::OverlayFileSystem>(vfs::getRealFileSystem());
}
