/* OpenCL source code converted from the following C file: */
/*  'testsuite/ocl/hsd/5200927/prog.c'  */
__kernel void ocl_test_kernel(__global int* x) {
  ushort  v = 3;
  int kuvoffset = 3;

  ushort swapped = (v>>8) | (v<<8);
  float flu =  (float)((swapped>>6) - kuvoffset);

  x[0]=2;
  x[3]=flu-9.0f;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
