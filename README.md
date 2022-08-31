opencl-clang is a thin wrapper library around clang. The library has
OpenCL-oriented API and is capable to compile OpenCL C kernels to SPIR-V
modules.

## Build

Source code in this repo can be built in different manners:
* in-tree as an LLVM project
* out-of-tree using pre-built LLVM

### In-tree build

Before the build all dependencies must be downloaded and laid out as follows:

```
<workspace>
|-- llvm
|-- clang
|-- SPIRV-LLVM-Translator
`-- opencl-clang
```

This can be done using the following commands:
```bash
cd <workspace>
git clone https://github.com/llvm/llvm-project.git . -b release/15.x
git clone https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git -b llvm_release_150
git clone https://github.com/intel/opencl-clang.git -b ocl-open-150
```

Then we need to create a build directory and run the build:
```bash
export OCL_CLANG_WS=<workspace>
cd $OCL_CLANG_WS
mkdir build && cd build
cmake -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_ENABLE_PROJECTS="clang" \
      -DLLVM_EXTERNAL_PROJECTS="llvm-spirv;opencl-clang" \
      -DLLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR="$OCL_CLANG_WS/SPIRV-LLVM-Translator" \
      -DLLVM_EXTERNAL_OPENCL_CLANG_SOURCE_DIR="$OCL_CLANG_WS/opencl-clang" \
      $OCL_CLANG_WS/llvm
make opencl-clang -j`nproc`
```

For sanity check of the build please run `make check-clang` and
`make check-llvm-spirv`

### Out-of-tree build

To build opencl-clang as a standalone project, you need to obtain pre-built LLVM
and SPIR-V Translator libraries. **Note:** currently this kind of build is
supported on Linux only.

Integration with pre-built LLVM is done using standard `find_package` way as
documented in [Embedding LLVM in your project](https://llvm.org/docs/CMake.html#embedding-llvm-in-your-project).

Commands to checkout sources and build:
```bash
cd <workspace>
git clone https://github.com/intel/opencl-clang.git -b ocl-open-150
mkdir build && cd build
cmake ../opencl-clang
make all -j`nproc`
```

#### Configuration options

##### Preferred LLVM version

By default, opencl-clang's cmake script is searching for LLVM 15.0.0. You can
override target version of LLVM by using the `PREFERRED_LLVM_VERSION` cmake
option:

Example:
```bash
cmake -DPREFERRED_LLVM_VERSION="10.0.0" ../opencl-clang
```

##### Custom LLVM installation

If LLVM is installed somewhere in custom (non-system directories) location, you
could point to it using the `LLVM_DIR` cmake option. **Note**: You need to
specify the path to a directory containing the `LLVMConfig.cmake` file.

This file is available in two different locations.
* `<INSTALL_PREFIX>/lib/cmake/llvm/LLVMConfig.cmake` where `<INSTALL_PREFIX>`
  is the install prefix of an installed version of LLVM. On Linux this is
  typically `/usr/lib/cmake/llvm/LLVMConfig.cmake`.
* `<LLVM_BUILD_ROOT>/lib/cmake/llvm/LLVMConfig.cmake` where `<LLVM_BUILD_ROOT>`
  is the root of the LLVM build tree.
  **Note: this is only available when building LLVM with CMake.**

Example:
```bash
cmake -DLLVM_DIR=/path/to/installed/llvm/lib/cmake/llvm ../opencl-clang
```

##### Location of SPIR-V Translator library

By default, opencl-clang's cmake script assumes that SPIR-V Translator library
is built as part of LLVM, installed in the same place and libLLVMSPIRVLib is
linked into libLLVM.

If that is not true for you, you can override this: firstly, you need to set
`LLVMSPIRV_INCLUDED_IN_LLVM` cmake option to `OFF`. Then you need to specify
directory where SPIR-V Translator is installed by using `SPIRV_TRANSLATOR_DIR`
cmake option.

Example:
```bash
cmake -DLLVMSPIRV_INCLUDED_IN_LLVM=OFF -DSPIRV_TRANSLATOR_DIR=/path/to/installed/spirv/translator ../opencl-clang
```

There is a known issue (linker crash) for this kind of build on Ubuntu 16.04
Xenial.
In this case the following cmake option should fix it:
```
-DLLVM_NO_DEAD_STRIP=ON
```

Installation directory of SPIR-V Translator is expected to contain the
following files:
```
<installation_dir>
|-- include
|   `-- LLVMSPIRVLib
|       `-- LLVMSPIRVLib.h
`-- lib64
    `-- libLLVMSPIRVLib.so
```
