//===--- OpenCLClang.h - OpenCL Clang Frontend API --------------*- C++ -*-===//
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

#ifndef OPENCL_CLANG_OPENCLCLANG_H
#define OPENCL_CLANG_OPENCLCLANG_H
#include "assert.h"
#include "cstddef" // size_t

#if defined(_WIN32)
#if defined(OPENCL_CLANG_EXPORTS)
#define CC_DLL_EXPORT _declspec(dllexport)
#else
#define CC_DLL_EXPORT _declspec(dllimport)
#endif
#else
#define CC_DLL_EXPORT
#endif

namespace Intel {
namespace OpenCL {
namespace ClangFE {
//
// Type of the binary returned after compilation and/or link
//
enum IrType {
  IrTypeUnknown,
  IrTypeExecutable,
  IrTypeLibrary,
  IrTypeCompiledObject
};

// Backward compatibility aliases
using IR_TYPE = IrType;
constexpr IrType IR_TYPE_UNKNOWN = IrTypeUnknown;
constexpr IrType IR_TYPE_EXECUTABLE = IrTypeExecutable;
constexpr IrType IR_TYPE_LIBRARY = IrTypeLibrary;
constexpr IrType IR_TYPE_COMPILED_OBJECT = IrTypeCompiledObject;

//
// Compilation results interface
// Returned by Compile method
//
struct IOCLFEBinaryResult {
  // Returns the size in bytes of the IR buffer
  virtual size_t GetIRSize() const = 0;
  // Returns the pointer to the IR buffer or NULL if no IR buffer is present
  virtual const void *GetIR() const = 0;
  // Returns the name of the program
  virtual const char *GetIRName() const = 0;
  // Returns the type of the resulted binary
  virtual IrType GetIRType() const = 0;
  // Returns the pointer to the compilation log string or NULL if not log was
  // created
  virtual const char *GetErrorLog() const = 0;
  // Releases the result object
  virtual void Release() = 0;

protected:
  virtual ~IOCLFEBinaryResult() {}
};
} // namespace ClangFE
} // namespace OpenCL
} // namespace Intel

//
// Verifies the given OpenCL application supplied compilation options
// Params:
//    Options - compilation options string
//    UnknownOptions - optional outbound pointer to the space separated
//    unrecognized options
//    UnknownOptionsSize - size of the UnknownOptions buffer
// Returns:
//    true if the options verification was successful, false otherwise
//
extern "C" CC_DLL_EXPORT bool CheckCompileOptions(
    // A string for compile options
    const char *Options,
    // buffer to get the list of unknown options
    char *UnknownOptions,
    // size of the buffer for unknown options
    size_t UnknownOptionsSize);

//
// Compiles the given OpenCL program to the LLVM IR
// Params:
//    ProgramSource - OpenCL source program to compile
//    InputHeaders - array of the header buffers
//    NumInputHeaders - size of the InputHeaders array
//    InputHeadersNames - array of the headers names
//    PCHBuffer - optional pointer to the pch buffer
//    PCHBufferSize - size of the pch buffer
//    Options - OpenCL application supplied options
//    OptionsEx - optional extra options string usually supplied by runtime
//    OpenCLVersion - OpenCL version supported by the device, also defines
//    __OPENCL_VERSION__ macro -- "120" for OpenCL 1.2, "200" for OpenCL 2.0,
//    ... BinaryResult - optional outbound pointer to the compilation results
// Returns:
//    Compilation Result as int:  0 -- success, error otherwise.
//
extern "C" CC_DLL_EXPORT int Compile(
    // A pointer to main program's source (null terminated string)
    const char *ProgramSource,
    // array of additional input headers to be passed in memory (each null
    // terminated)
    const char **InputHeaders,
    // the number of input headers in InputHeaders
    unsigned int NumInputHeaders,
    // array of input headers names corresponding to InputHeaders
    const char **InputHeadersNames,
    // optional pointer to the pch buffer
    const char *PCHBuffer,
    // size of the pch buffer
    size_t PCHBufferSize,
    // OpenCL application supplied options
    const char *Options,
    // optional extra options string usually supplied by runtime
    const char *OptionsEx,
    // OpenCL version string -- "120" for OpenCL 1.2, "200" for OpenCL 2.0, ...
    const char *OpenCLVersion,
    // optional outbound pointer to the compilation results
    Intel::OpenCL::ClangFE::IOCLFEBinaryResult **BinaryResult);

#endif // OPENCL_CLANG_OPENCLCLANG_H
