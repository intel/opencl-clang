//===--- PCHManager.h - Precompiled header resource manager -----*- C++ -*-===//
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

#ifndef OPENCL_CLANG_LIB_PCHMANAGER_H
#define OPENCL_CLANG_LIB_PCHMANAGER_H

#include "llvm/Support/Mutex.h"

#include <map>
#include <list>
#include <iostream>
#include <string>
#include <vector>

struct Resource
{
  const char* Data;
  size_t      Size;
  std::string Name;

  Resource() {
    Data = nullptr;
    Size = 0;
    Name = "";
  }

  Resource(const char* data, size_t size, const std::string& name):
    Data(data), Size(size), Name(name) {}

  bool operator!() {
    return Data == nullptr;
  }
};


// Singleton class for resource management
// Its main purpose is to cache the buffers loaded from the resources
// but it could be easily extended to support file based buffers as well
class ResourceManager {
public:
  static ResourceManager &instance() { return Instance; }

  Resource getResource(const char *name, const char *id,
                        const char *type, bool requireNullTerminate);

  const char *getFile(const char *path, bool binary, bool requireNullTerminate,
                       size_t &out_size);

private:
  ResourceManager() {}

  bool loadResource(const char *id, const char *pszType,
                     bool requireNullTerminate);

  void loadFile(const char *path, bool binary, bool requireNullTerminate);

  const char* reallocBuffer(const char *id, const char* buf, size_t size,
                             bool requireNullTerminate);

#ifdef _WIN32
  bool getResourceWin32(const char *id, const char *pszType,
                        const char *&res, size_t &size);

#else
  bool getResourceUnix(const char *id, const char *pszType,
                       const char *lib, bool relocate,
                       const char *&res, size_t &size);

#endif

private:
  static ResourceManager Instance;
  llvm::sys::Mutex Lock;
  // map that caches the pointers to the loaded buffers and their sizes
  // those buffers could be either the pointer to the loaded
  // resource or to the cached buffers (stored in the Allocations var below)
  std::map<std::string, std::pair<const char *, size_t>> Buffers;
  std::map<std::string, std::vector<char>> Allocations;
};

#endif // OPENCL_CLANG_LIB_PCHMANAGER_H
