Common clang is a thin wrapper library around clang. Common clang has OpenCL-oriented API and is capable to compile OpenCL C kernels to SPIR-V modules.

## Build

Source code in this repo is intended to be built in-tree as an llvm project. Before the build all dependencies must be downloaded and layed out as the following:

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
git clone https://github.com/llvm-mirror/llvm.git
cd tools
git clone https://github.com/llvm-mirror/clang.git
cd <workspace>/llvm/projects
git clone https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git llvm-spirv
git clone https://github.com/intel/opencl-clang.git
```

Then we need to create a build directory and run the build:
```
cd <workspace>
mkdir build && cd build
cmake -DLLVM_TARGET_TO_BUILD="X86" ../llvm
make common_clang -j`nproc`
```

For sanity check of the built please run `make check-clang` and `make check-llvm-spirv`

