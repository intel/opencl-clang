/* OpenCL source code converted from the following C file: */
/*  'testsuite\gcc.c-torture\compile\20000314-1.c'  */
int a;
int main_function_ocl(int argc, char **argv, __global int *ocl_test_results)
{
   a = 0;
   return a;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(0,0,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1 | FileCheck %s
// From groups/negative.read-only.lst: status: skip, errorcode: -1004, message: :6:6:read-only variable is not assignable

// CHECK: 1:3:5: error: program scope variable must reside in constant address space
// CHECK: int a;
// CHECK: ^
// XFAIL: *
