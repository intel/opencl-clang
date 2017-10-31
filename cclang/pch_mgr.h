/*****************************************************************************\

Copyright (c) Intel Corporation (2009-2017).

    INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE.  THIS CODE IS
    LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
    ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL DOES NOT
    PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY
    DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
    PARTICULAR PURPOSE, OR ANY OTHER WARRANTY.  Intel disclaims all liability,
    including liability for infringement of any proprietary rights, relating to
    use of the code. No license, express or implied, by estoppel or otherwise,
    to any intellectual property rights is granted herein.

  \file pch_mgr.h

\*****************************************************************************/

#include "llvm/Support/Mutex.h"

#include <map>
#include <list>
#include <iostream>
#include <string>
#include <vector>

struct Resource
{
  const char* m_data;
  size_t      m_size;
  std::string m_name;

  Resource() {
    m_data = nullptr;
    m_size = 0;
    m_name = "";
  }

  Resource(const char* data, size_t size, const std::string& name):
    m_data(data), m_size(size), m_name(name) {}

  bool operator!() {
    return m_data == nullptr;
  }
};


// Singleton class for resource management
// Its main purpose is to cache the buffers loaded from the resources
// but it could be easely extended to support file based buffers as well
class ResourceManager {
public:
  static ResourceManager &instance() { return g_instance; }

  Resource get_resource(const char *name, const char *id,
                        const char *type, bool requireNullTerminate);

  const char *get_file(const char *path, bool binary, bool requireNullTerminate,
                       size_t &out_size);

private:
  ResourceManager() {}

  bool load_resource(const char *id, const char *pszType,
                     bool requireNullTerminate);

  void load_file(const char *path, bool binary, bool requireNullTerminate);

  const char* realloc_buffer(const char *id, const char* buf, size_t size,
                             bool requireNullTerminate);

#ifdef _WIN32
  bool GetResourceWin32(const char *id, const char *pszType,
                        const char *&res, size_t &size);

#else
  bool GetResourceUnix(const char *id, const char *pszType,
                       const char *lib, bool relocate,
                       const char *&res, size_t &size);

#endif

private:
  static ResourceManager g_instance;
  llvm::sys::Mutex m_lock;
  // map that caches the pointers to the loaded buffers and their sizes
  // those buffers could be either the pointer to the loaded
  // resource or to the cached buffers (stored in the m_allocations var below)
  std::map<std::string, std::pair<const char *, size_t>> m_buffers;
  std::map<std::string, std::vector<char>> m_allocations;
};
