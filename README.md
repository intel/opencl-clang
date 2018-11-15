Common clang is a thin wrapper library around clang. Common clang has
OpenCL-oriented API and is capable to compile OpenCL C kernels to SPIR-V
modules.

## Build

Source code in this repo can be built in different manners:
* in-tree as an LLVM project
* out-of-tree using pre-built LLVM

### In-tree build

Before the build all dependencies must be downloaded and layed out as the
following:

```
<workspace>
`-- llvm
    |-- tools
    |   `-- clang
    `-- projects
        |-- llvm-spirv
        `-- common-clang
```

This can be done using the following commands:
```
cd <workspace>
git clone https://github.com/llvm-mirror/llvm.git -b release_70
cd tools
git clone https://github.com/llvm-mirror/clang.git -b release_70
cd <workspace>/llvm/projects
git clone https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git llvm-spirv
git clone https://github.com/intel/opencl-clang.git -b ocl-open-70
```

Then we need to create a build directory and run the build:
```
cd <workspace>
mkdir build && cd build
cmake -DLLVM_TARGET_TO_BUILD="X86" ../llvm
make common_clang -j`nproc`
```

For sanity check of the built please run `make check-clang` and
`make check-llvm-spirv`

### Out-of-tree build

To build Common clang as standalone project, you need to obtain pre-built LLVM
and SPIR-V Translator libraries. **Note:** currently this kind of build is
supported on Linux only.

Integration with pre-built LLVM is done using standard `find_package` way as
documented in [Embedding LLVM in your project](https://llvm.org/docs/CMake.html#embedding-llvm-in-your-project).

Commands to checkout sources and build:
```
cd <workspace>
git clone https://github.com/intel/opencl-clang.git -b ocl-open-70
mkdir build && cd build
cmake ../opencl-clang
make all -j`nproc`
```

#### Configuration options

##### Preferred LLVM version

By default, Common clang's cmake script is searching for LLVM 7.0.0. You can
override target version of LLVM by using `PREFERRED_LLVM_VERSION` cmake option:

Example:
```
cmake -DPREFERRED_LLVM_VERSION="7.0.1" ../opencl-clang
```

##### Custom LLVM installation

If LLVM is installed somewhere in custom (non-system directories) location, you
could point to it using `LLVM_DIR` cmake option. **Note**: You need to specify a'
path to a directory containing `LLVMConfig.cmake` file.

This file is available in two different locations.
* `<INSTALL_PREFIX>/lib/cmake/llvm/LLVMConfig.cmake` where `<INSTALL_PREFIX>`
  is the install prefix of an installed version of LLVM. On Linux typically this
  is `/usr/lib/cmake/llvm/LLVMConfig.cmake`.
* `<LLVM_BUILD_ROOT>/lib/cmake/llvm/LLVMConfig.cmake` where `<LLVM_BUILD_ROOT>`
  is the root of the LLVM build tree.
  **Note: this is only available when building LLVM with CMake.**

Example:
```
cmake -DLLVM_DIR=/path/to/installed/llvm/lib/cmake/llvm ../opencl-clang
```

##### Location of SPIR-V Translator library

By default, Common clang's cmake script assumes that SPIR-V Translator library
is built as part of LLVM, installed in the same place and libLLVMSPIRVLib is
linked into libLLVM.

If that is not true for you, you can override this: firstly, you need to set
`LLVMSPIRV_INCLUDED_IN_LLVM` cmake option to `OFF`. Then you need to specify
directory where SPIR-V Translator is installed by using `SPIRV_TRANSLATOR_DIR`
cmake option.

Example:
```
cmake -DLLVMSPIRV_INCLUDED_IN_LLVM=OFF -DSPIRV_TRANSLATOR_DIR=/path/to/installed/spirv/translator ../opencl-clang
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
