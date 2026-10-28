//===--- BuiltInHeaders.cpp - Built-in OpenCL header manager ----*- C++ -*-===//
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

#include "BuiltInHeaders.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"

#include "opencl-headers.h"

using namespace llvm;

// Define the root path for the in-memory file system.
// The path is defined as a macro to allow compile-time concatenation.
#if defined(_WIN32)
// On Windows use UNC style paths to avoid interference with drive letters.
#define VFS_ROOT "//__opencl_clang/"
#else // defined(_WIN32)
// On non-Windows platforms use a standard POSIX-style path.
#define VFS_ROOT "/__opencl_clang/"
#endif // defined(_WIN32)

static void embedHeaders(IntrusiveRefCntPtr<vfs::InMemoryFileSystem> FS,
                         StringRef Base, const unsigned char *Storage,
                         const char *Names[], const unsigned Offsets[],
                         const unsigned Sizes[], size_t Count) {
  for (size_t I = 0; I < Count; ++I) {
    StringRef Name = Names[I];
    ArrayRef<unsigned char> Data(Storage + Offsets[I], Sizes[I]);

    StringRef DataRef(reinterpret_cast<const char *>(Data.data()), Data.size());
    FS->addFileNoOwn(Base + Name, static_cast<time_t>(0),
                     MemoryBufferRef(DataRef, Name));
  }
}

const BuiltInHeaders &BuiltInHeaders::get() {
  static const BuiltInHeaders Instance;
  return Instance;
}

const char *BuiltInHeaders::getIncludePath() const {
  return VFS_ROOT "opencl/";
}

IntrusiveRefCntPtr<vfs::InMemoryFileSystem>
BuiltInHeaders::createOpenCLHeadersFS() const {
  IntrusiveRefCntPtr<vfs::InMemoryFileSystem> FS(new vfs::InMemoryFileSystem);
  StringRef Base = getIncludePath();

  embedHeaders(FS, Base, opencl_headers_data, opencl_headers_filenames,
               opencl_headers_offsets, opencl_headers_sizes,
               opencl_headers_count);
  return FS;
}

IntrusiveRefCntPtr<vfs::OverlayFileSystem>
BuiltInHeaders::getFileSystem() const {
  auto OvlFS =
      makeIntrusiveRefCnt<vfs::OverlayFileSystem>(vfs::getRealFileSystem());
  auto OCLFS = createOpenCLHeadersFS();
  OvlFS->pushOverlay(OCLFS.get());
  return OvlFS;
}
