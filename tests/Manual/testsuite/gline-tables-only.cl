/*  'testsuite/gline-tables-only.cl'  */

// RUN: %occ-cli %s --cl-options=-gline-tables-only %cfg_path --cl-device=%cl_device --output=%t.bc
// RUN: llvm-dis %t.bc -o - | FileCheck %s

// CHECK: !dbg !{{[0-9]+}}
// CHECK: !{{[0-9]+}} = !DILocation

int foo(__global int *input) {
  *input += 5;

  return 3;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results) {
  int a = foo(ocl_test_results);
}
