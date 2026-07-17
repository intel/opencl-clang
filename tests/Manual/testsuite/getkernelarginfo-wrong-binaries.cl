/*  'testsuite/getkernelarginfo-wrong-binaries.cl'  */

// RUN: %occ-cli --method=GetKernelArgInfo --binary-file %s --kernel-name
// ocl_test_kernel XFAIL: *
//
// This is a negative test for CORC-833.
// CClang's GetKernelArgInfo should return valid error code instead of terminate
// application when input binaries is invalid.
//

int foo(__global int *input) {
  *input += 5;

  return 3;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results) {
  int a = foo(ocl_test_results);
}
