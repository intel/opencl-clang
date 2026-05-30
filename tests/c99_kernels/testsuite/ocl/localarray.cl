/* OpenCL source code converted from the following C file: */
/*  'testsuite\gcc.dg\graphite\interchange-9.c'  */

#define N 260111+1

int
main_function_ocl(int argc, constant char **argv, __global int *ocl_test_results)
{
  int A[N];
  int i, errCnt = 0;

  for (i = 0; i < N; i++)
    A[i] = 2;

  for (i = 0; i < N; i++)
  {
    if(A[i] != 2)
      errCnt++;
      //return i+1;
  }
  return errCnt;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  constant char *args[] = {"ocl", "c99", "gcc"};
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(3,args,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From c99_expres.txt: status: fail, errorcode: -1002, message: .*

// From groups/failed.execution.lst: status: fail, errorcode: -1003, message: 260111

