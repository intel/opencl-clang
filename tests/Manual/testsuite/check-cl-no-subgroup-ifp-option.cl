/*  'testsuite/check-cl-no-subgroup-ifp-option.cl'  */

// RUN: %occ-cli %s --cl-options=-cl-no-subgroup-ifp  %cfg_path --cl-device=%cl_device --output=%t.bc RUN: llvm-dis %t.bc -o - | FileCheck %s
// XFAIL: *

// buildOptions:
// CHECK: !opencl.compiler.options = !{![[MDN:[0-9]+]]}
// CHECK: ![[MDN]] = {{.*}}"-cl-no-subgroup-ifp"

__kernel void ocl_test_kernel() {}
