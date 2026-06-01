/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/scalars1.c'  */
int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) {
  int a = 123;
  printf("number1: %d\n",a);         // { dg-printf "number1: 123" }
  printf("number2: %i\n",a);         // { dg-printf "number2: 123" }

  unsigned int b = 11259375;
  printf("octal number3: %o\n",b);   // { dg-printf "octal number3: 52746757" }
  printf("hex number4: %x\n",b);     // { dg-printf "hex number4: abcdef" }
  printf("hex number5: %X\n",b);     // { dg-printf "hex number5: ABCDEF" }

  float c = 3.14159;
  printf("float number6: %F\n",c);
  printf("float number7: %f\n",c);   // { dg-printf "float number7: 3.14159" }
  printf("float number8: %g\n",c);   // { dg-printf "float number8: 3.14159" }
  printf("float number9: %G\n",c);   // { dg-printf "float number9: 3.14159" }
  printf("float number10: %a\n",c);
  printf("float number10: %A\n",c);

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
// From groups/failed.error.line.parse.error.lst: status: fatal, errorcode: -1007, message: Executing kernel
