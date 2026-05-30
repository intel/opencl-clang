/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/vec1.c'  */
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) {
  float4 f = (float4)(1.0f, 2.0f, 3.0f, 4.0f);
  uchar4 uc = (uchar4)(0xFA, 0xFB, 0xFC, 0xFD);

  printf("f4 = %2.2v4hlf\n", f);  // { dg-printf "f4 = 1.00,2.00,3.00,4.00" }
  printf("uc = %#v4hhx\n", uc);   // { dg-printf "uc = 0xfa,0xfb,0xfc,0xfd" }

  return 0;
}
__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  const constant char *args[] = {"ocl", "c99", "gcc"};
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(3,args,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/failed.error.line.parse.error.lst: status: fail, errorcode: -1002, message: error: Error, unimplemented function called: _Z15convert_double4U8__vector4f()
