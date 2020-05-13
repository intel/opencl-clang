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

  \file pch_mgr.cpp

\*****************************************************************************/

#include "pch_mgr.h"

#include "llvm/Object/ELF.h"
#include "llvm/ADT/Twine.h"

#include <cstdlib>
#include <stdio.h>
#include <assert.h>
#include <fstream>
#ifdef _WIN32
#include <Windows.h>
#else
#include <dlfcn.h>
#include <stdio.h>

struct auto_dlclose {
  auto_dlclose(void *module) : m_pModule(module) {}

  ~auto_dlclose() {
  }

  void *get() { return m_pModule; }

  bool operator!() { return !m_pModule; }

  operator bool() { return m_pModule != NULL; }

  void *release() {
    void *pTemp = m_pModule;
    m_pModule = NULL;
    return pTemp;
  }

private:
  auto_dlclose(const auto_dlclose &);

  void *m_pModule;
};
#endif

ResourceManager ResourceManager::g_instance;

void dummy() {}

// returns the pointer to the buffer loaded from the resource with the given id
Resource ResourceManager::get_resource(const char *name, const char *id,
                                       const char *type,
                                       bool requireNullTerminate) {
  llvm::sys::ScopedLock mutexGuard(m_lock);

  auto res = m_buffers.find(id);
  if (res == m_buffers.end()) {
    // lazy load the resource if not found in the cache
    if (!load_resource(id, type, requireNullTerminate)) {
      return Resource();
    }
  }

  res = m_buffers.find(id);
  assert(res != m_buffers.end());

  const char *data = res->second.first;
  size_t size = res->second.second;
  return Resource(data, size, name);
}

const char *ResourceManager::get_file(const char *path, bool binary,
                                      bool requireNullTerminate,
                                      size_t &out_size) {
  llvm::sys::ScopedLock mutexGuard(m_lock);

  std::string key(path);

  if (m_buffers.find(key) == m_buffers.end()) {
    // lazy load the resource if not found in the cache
    load_file(path, binary, requireNullTerminate);
  }

  assert(m_buffers.find(key) != m_buffers.end());
  out_size = m_buffers[key].second;
  return m_buffers[key].first;
}

const char* ResourceManager::realloc_buffer(const char *id,
                                            const char* buf, size_t size,
                                            bool requireNullTerminate) {
  std::vector<char> &buffer = m_allocations[id];

  size_t alloc_size = requireNullTerminate ? size + 1 : size;
  buffer.resize(alloc_size);
  buffer.assign(buf, buf + size);
  // The data in the buffer will be eventually passed to llvm::MemoryBufferMem
  // ctor via argument of StringRef type. The Length of this StringRef will be
  // = the 'size' argument of this function. There is an assert in
  // llvm::MemoryBuffer::init checking that element *past the end* of the memory
  // range passed via the ctor is '\0'. So we add it here.
  buffer.push_back('\0');

  return &buffer[0];
}

#ifdef _WIN32
bool ResourceManager::GetResourceWin32(const char *id, const char *pszType,
                                       const char *&res, size_t &size) {
  HMODULE hMod = NULL;
  // Get the handle to the current module
  GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                    GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                    (LPCSTR)dummy, &hMod);
  if (!hMod) {
    return false;
  }

  std::string ResName = ("\"" + llvm::Twine(id) + "\"").str();
  // Locate the resource
  HRSRC hRes = FindResourceA(hMod, ResName.c_str(), pszType);
  if (!hRes) {
    return false;
  }

  // Load the resource
  HGLOBAL hBytes = LoadResource(hMod, hRes);
  if (!hBytes) {
    return false;
  }

  // Get the base address to the resource. This call doesn't really lock it
  res = (const char*) LockResource(hBytes);
  if (!res) {
    return false;
  }

  // Get the buffer size
  size = SizeofResource(hMod, hRes);
  if (!size) {
    return false;
  }

  return true;
}
#else // WIN32

/**
 * GetResourceUnix loads resource from shared library `lib`.
 *
 * If `relocate` argument is `false`, returned resource is only valid if:
 *   1) library `lib` is loaded into memory before use of this function
 *   2) resource will be used only while library is still loaded
 *
 * If relocate is `true`, resource will be memcpy'ed into an internal buffer,
 * i.e. no resource will be valid as long as the ResourceManager is alive.
 */
bool ResourceManager::GetResourceUnix(const char *id, const char *pszType,
                                      const char *lib, bool relocate,
                                      const char *&res, size_t &size) {

  void *handle = dlopen(lib, RTLD_NOW);
  if (!handle) {
    return false;
  }

  auto_dlclose module(handle);

  std::string name = (pszType + llvm::Twine("_") + llvm::Twine(id)).str();
  std::string size_name = (name.c_str() + llvm::Twine("_size")).str();

  const void *size_ptr = dlsym(module.get(), size_name.c_str());
  if (!size_ptr) {
    return false;
  }

  size = *(const uint32_t *)size_ptr;
  res = (const char *)dlsym(module.get(), name.c_str());

  if (!res) {
    return false;
  }

  return true;
}
#endif // WIN32

bool ResourceManager::load_resource(const char *id, const char *pszType,
                                    bool requireNullTerminate) {
  // this function is called under lock
  assert(m_buffers.find(id) == m_buffers.end());

  const char *res = nullptr;
  size_t size = 0;
#ifdef WIN32
  bool ok = GetResourceWin32(id, pszType, res, size);
#else
  bool ok = GetResourceUnix(id, pszType, LIBCOMMON_CLANG_NAME,
                            false, res, size);
#endif

  if (!ok) {
    return false;
  }

  if (requireNullTerminate && res[size] != '\0') {
    // reallocate the buffer to ensure the null termination
    res = realloc_buffer(id, res, size, requireNullTerminate);
  }

  m_buffers[id] = std::pair<const char *, size_t>(res, size);
  return true;
}

// cache the content of the file to the internal buffers
void ResourceManager::load_file(const char *path, bool binary,
                                bool requireNullTerminate) {
  std::string key(path);
  std::ifstream fs(path, binary ? std::ios::binary : std::ios::in);
  std::vector<char> &buffer = m_allocations[key];

  buffer.assign(std::istreambuf_iterator<char>(fs),
                std::istreambuf_iterator<char>());

  if (requireNullTerminate && buffer.size() > 0 && buffer.back() != '\0') {
    buffer.push_back('\0');
  }
  m_buffers[key] =
      std::pair<const char *, size_t>(buffer.data(), buffer.size());
}
