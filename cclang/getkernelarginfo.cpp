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

  \file getkernelarginfo.cpp

\*****************************************************************************/

#include "common_clang.h"

#include "llvm/ADT/StringSwitch.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/Mutex.h"
#include "llvm/Support/MemoryBuffer.h"

#include <string>
#include <vector>

using namespace Intel::OpenCL::ClangFE;

struct CachedArgInfo {
  std::string name;
  std::string typeName;
  cl_kernel_arg_address_qualifier adressQualifier;
  cl_kernel_arg_access_qualifier accessQualifier;
  cl_kernel_arg_type_qualifier typeQualifier;
};

static llvm::ManagedStatic<llvm::sys::SmartMutex<true> > kernelArgInfoMutex;

class OCLFEKernelArgInfo : public IOCLFEKernelArgInfo {
public:
  unsigned int getNumArgs() const { return m_argsInfo.size(); }
  const char *getArgName(unsigned int index) const {
    return m_argsInfo[index].name.c_str();
  }
  const char *getArgTypeName(unsigned int index) const {
    return m_argsInfo[index].typeName.c_str();
  }
  cl_kernel_arg_address_qualifier
  getArgAdressQualifier(unsigned int index) const {
    return m_argsInfo[index].adressQualifier;
  }
  cl_kernel_arg_access_qualifier
  getArgAccessQualifier(unsigned int index) const {
    return m_argsInfo[index].accessQualifier;
  }
  cl_kernel_arg_type_qualifier getArgTypeQualifier(unsigned int index) const {
    return m_argsInfo[index].typeQualifier;
  }

  void Release() { delete this; }

public:
  void addInfo(const CachedArgInfo &info) { m_argsInfo.push_back(info); }

private:
  std::vector<CachedArgInfo> m_argsInfo;
};

void CommonClangInitialize();

extern "C" CC_DLL_EXPORT int GetKernelArgInfo(const void *pBin,
                                              size_t uiBinarySize,
                                              const char *szKernelName,
                                              IOCLFEKernelArgInfo **ppResult) {
  // Lazy initialization
  CommonClangInitialize();

  // LLVM doesn't guarantee thread safety,
  // therefore we serialize execution of LLVM code.
  llvm::sys::SmartScopedLock<true> kernelArgInfoGuard {*kernelArgInfoMutex};

  try {
    std::unique_ptr<llvm::MemoryBuffer> pBinBuff(
        llvm::MemoryBuffer::getMemBuffer(
            llvm::StringRef((const char *)pBin, uiBinarySize), "", false));

    std::unique_ptr<llvm::LLVMContext> context(new llvm::LLVMContext());
    auto ModuleOr =
        parseBitcodeFile(pBinBuff.get()->getMemBufferRef(), *context);
    if (!ModuleOr)
      throw ModuleOr.takeError();

    std::unique_ptr<llvm::Module> pModule = std::move(ModuleOr.get());
    if (!pModule)
      throw std::bad_alloc();

    auto Func = pModule->getFunction(szKernelName);
    if (!Func)
      throw std::string("Can't find ")+szKernelName+std::string(" in the module.");
    if (Func->getCallingConv() != llvm::CallingConv::SPIR_KERNEL)
      throw std::string("Function ") + szKernelName + std::string(" is not an OpenCL kernel.");

    llvm::MDNode *pAddressQualifiers = Func->getMetadata("kernel_arg_addr_space");
    llvm::MDNode *pAccessQualifiers = Func->getMetadata("kernel_arg_access_qual");
    llvm::MDNode *pTypeNames = Func->getMetadata("kernel_arg_type");
    llvm::MDNode *pTypeQualifiers = Func->getMetadata("kernel_arg_type_qual");
    llvm::MDNode *pArgNames = Func->getMetadata("kernel_arg_name");
    assert(pAddressQualifiers && pAccessQualifiers && pTypeNames &&
           pTypeQualifiers && "invalid kernel metadata");

    std::unique_ptr<OCLFEKernelArgInfo> pResult(new OCLFEKernelArgInfo);
    for (unsigned int i = 0; i < pAddressQualifiers->getNumOperands(); ++i) {
      CachedArgInfo argInfo;

      // Address qualifier
      llvm::ConstantInt *pAddressQualifier =
          llvm::mdconst::dyn_extract<llvm::ConstantInt>(
              pAddressQualifiers->getOperand(i));
      assert(pAddressQualifier &&
             "pAddressQualifier is not a valid ConstantInt*");

      uint64_t uiAddressQualifier = pAddressQualifier->getZExtValue();
      switch (uiAddressQualifier) {
      case 0:
        argInfo.adressQualifier = CL_KERNEL_ARG_ADDRESS_PRIVATE;
        break;
      case 1:
        argInfo.adressQualifier = CL_KERNEL_ARG_ADDRESS_GLOBAL;
        break;
      case 2:
        argInfo.adressQualifier = CL_KERNEL_ARG_ADDRESS_CONSTANT;
        break;
      case 3:
        argInfo.adressQualifier = CL_KERNEL_ARG_ADDRESS_LOCAL;
        break;
      }

      // Access qualifier
      llvm::MDString *pAccessQualifier =
          llvm::dyn_cast<llvm::MDString>(pAccessQualifiers->getOperand(i));
      assert(pAccessQualifier && "pAccessQualifier is not a valid MDString");

      argInfo.accessQualifier =
          llvm::StringSwitch<cl_kernel_arg_access_qualifier>(
              pAccessQualifier->getString())
              .Case("read_only", CL_KERNEL_ARG_ACCESS_READ_ONLY)
              .Case("write_only", CL_KERNEL_ARG_ACCESS_WRITE_ONLY)
              .Case("read_write", CL_KERNEL_ARG_ACCESS_READ_ONLY)
              .Default(CL_KERNEL_ARG_ACCESS_NONE);

      // Type qualifier
      llvm::MDString *pTypeQualifier =
          llvm::dyn_cast<llvm::MDString>(pTypeQualifiers->getOperand(i));
      assert(pTypeQualifier && "pTypeQualifier is not a valid MDString*");
      argInfo.typeQualifier = 0;
      llvm::StringRef typeQualStr = pTypeQualifier->getString();
      if (typeQualStr.find("const") != llvm::StringRef::npos)
        argInfo.typeQualifier |= CL_KERNEL_ARG_TYPE_CONST;
      if (typeQualStr.find("restrict") != llvm::StringRef::npos)
        argInfo.typeQualifier |= CL_KERNEL_ARG_TYPE_RESTRICT;
      if (typeQualStr.find("volatile") != llvm::StringRef::npos)
        argInfo.typeQualifier |= CL_KERNEL_ARG_TYPE_VOLATILE;
      if (typeQualStr.find("pipe") != llvm::StringRef::npos)
        argInfo.typeQualifier |= CL_KERNEL_ARG_TYPE_PIPE;

      // Type name
      llvm::MDString *pTypeName =
          llvm::dyn_cast<llvm::MDString>(pTypeNames->getOperand(i));
      assert(pTypeName && "pTypeName is not a valid MDString*");
      argInfo.typeName = pTypeName->getString().str();

      if (pArgNames) {
        // Parameter name
        llvm::MDString *pArgName =
            llvm::dyn_cast<llvm::MDString>(pArgNames->getOperand(i));
        assert(pArgName && "pArgName is not a valid MDString*");

        argInfo.name = pArgName->getString().str();
      }

      pResult->addInfo(argInfo);
    }

    if (ppResult)
      *ppResult = pResult.release();

    return CL_SUCCESS;
  } catch (std::bad_alloc &) {
    return CL_OUT_OF_HOST_MEMORY;
  } catch (std::string &) {
    return CL_KERNEL_ARG_INFO_NOT_AVAILABLE;
  } catch (llvm::Error &err) {
    std::string Message;
    handleAllErrors(std::move(err),
                    [&](llvm::ErrorInfoBase &EIB) { Message = EIB.message(); });
    return CL_KERNEL_ARG_INFO_NOT_AVAILABLE;
  }
}
