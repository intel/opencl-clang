/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/returnedValue1.c'  */
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) {
  int i = printf("==== TESTED STRING =====\n");  // { dg-printf "== TESTED STRING ==" }
  return i;
return 0;/* just in case */}
__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  const constant char *args[] = {"ocl", "c99", "gcc"};
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(3,args,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/failed.error.line.parse.error.lst: status: pass, errorcode: 0, message: 0
