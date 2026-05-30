/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/printfs/strings1.c'  */
char  constant stringGlobal[] = "stringGlobal";

int main_function_ocl(int argc, const constant char **argv, __global int *ocl_test_results) {

  printf("string2 = %s\n",stringGlobal);   // { dg-printf "string2 = stringGlobal" }

  // { dg-printf "string3 = A B C D E F" }
  unsigned int av[] = {65,66,67,68,69,70};
  printf("string3 = %c %c %c %c %c %c\n",av[0],av[1],av[2],av[3],av[4],av[5]);

  char pool1[100] = {0};
  char pool2[100] = {0};
  printf("addres = %p\n", pool1);
  printf("addres = %p\n", pool2);


  printf("string4 = %% \n");               // { dg-printf "string4 = %" }

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
// From groups/failed.error.line.parse.error.lst: status: fail, errorcode: -1002, message: error: 
