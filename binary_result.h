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

  \file binary_result.h

\*****************************************************************************/

#pragma once

#include "common_clang.h"
#include "llvm/ADT/SmallVector.h"
#include <string>

// The following #define is taken from
// https://github.com/KhronosGroup/OpenCL-Headers/blob/master/CL/cl.h
#define CL_SUCCESS 0

class OCLFEBinaryResult : public Intel::OpenCL::ClangFE::IOCLFEBinaryResult {
  // IOCLFEBinaryResult
public:
  size_t GetIRSize() const override { return m_IRBuffer.size(); }

  const void *GetIR() const override { return m_IRBuffer.data(); }

  const char *GetIRName() const override { return m_IRName.c_str(); }

  Intel::OpenCL::ClangFE::IR_TYPE GetIRType() const override { return m_type; }

  const char *GetErrorLog() const override { return m_log.c_str(); }

  void Release() override { delete this; }
  // OCLFEBinaryResult
public:
  OCLFEBinaryResult()
      : m_type(Intel::OpenCL::ClangFE::IR_TYPE_UNKNOWN), m_result(CL_SUCCESS) {}

  llvm::SmallVectorImpl<char> &getIRBufferRef() { return m_IRBuffer; }

  std::string &getLogRef() { return m_log; }

  void setLog(const std::string &log) { m_log = log; }

  void setIRName(const std::string &name) { m_IRName = name; }

  void setIRType(Intel::OpenCL::ClangFE::IR_TYPE type) { m_type = type; }

  void setResult(int result) { m_result = result; }

  int getResult(void) const { return m_result; }

private:
  llvm::SmallVector<char, 4096> m_IRBuffer;
  std::string m_log;
  std::string m_IRName;
  Intel::OpenCL::ClangFE::IR_TYPE m_type;
  int m_result;
};
