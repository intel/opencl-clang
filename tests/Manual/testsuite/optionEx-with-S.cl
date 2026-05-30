// RUN: %occ-cli %s --cl-options-ex=-I/tmp/OCL-Sample %cfg_path --cl-device=%cl_device --output=%t.bc
// RUN: llvm-dis %t.bc -o - | FileCheck %s

// Regression test for the following bug.
// If current working directory contains "-S", common clang produced no output
// CPU runtime passes current working directory along with -I flag to cclang
// via pszOptionsEx argument of Compile method.

__kernel void test() {}
// CHECK: void @test()
