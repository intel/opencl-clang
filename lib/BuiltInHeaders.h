//===--- BuiltInHeaders.h - Built-in OpenCL header manager ------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_HEADERS_BUILTIN_H
#define OPENCL_CLANG_LIB_HEADERS_BUILTIN_H

#include "llvm/ADT/IntrusiveRefCntPtr.h"
#include "llvm/Support/VirtualFileSystem.h"

/// \brief Provides access to built-in headers embedded in the compiler.
///
/// Used to supply standard OpenCL headers during compilation. The headers
/// are stored in an in-memory file system and overlaid on top of the real
/// file system to allow seamless inclusion during compilation.
///
/// This class follows the singleton pattern to ensure a single instance
/// throughout the compiler's lifetime. Also, it is designed to be thread-safe
/// for concurrent access.
class BuiltInHeaders {
public:
  /// \brief Get the singleton instance of BuiltInHeaders.
  /// \return Reference to the BuiltInHeaders instance.
  static const BuiltInHeaders &get();

  /// \brief Get the include path for built-in headers.
  /// \return The include path as a C-style string.
  const char *getIncludePath() const;

  /// \brief Get the virtual file system containing built-in headers.
  ///
  /// The returned file system is an overlay that takes the real file system
  /// as its base and adds an in-memory file system with the built-in headers
  /// on top.
  ///
  /// \return Intrusive reference-counted pointer to the OverlayFileSystem.
  llvm::IntrusiveRefCntPtr<llvm::vfs::OverlayFileSystem> getFileSystem() const;

private:
  BuiltInHeaders() = default;

  llvm::IntrusiveRefCntPtr<llvm::vfs::InMemoryFileSystem>
  createOpenCLHeadersFS() const;
};

#endif // OPENCL_CLANG_LIB_HEADERS_BUILTIN_H
