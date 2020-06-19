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

#include <string>

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

  Resource(const char* data, size_t size, const char* name):
    m_data(data), m_size(size), m_name(name) {}

  bool operator!() {
    return m_data == nullptr;
  }
};
