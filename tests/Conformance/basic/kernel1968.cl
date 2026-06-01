// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global int *intOut, __global double *doubleOut) {
  intOut[0] = sizeof(HUGE_VAL);
  intOut[1] = (HUGE_VAL == INFINITY) ? 1 : 0;
  intOut[2] = isinf(HUGE_VAL) ? 1 : 0;
  intOut[3] = isnormal(HUGE_VAL) ? 1 : 0;
  intOut[4] = isnan(HUGE_VAL) ? 1 : 0;
  intOut[5] = (HUGE_VAL == HUGE_VALF) ? 1 : 0;
  intOut[6] = (as_ulong(HUGE_VAL) == 0x7ff0000000000000UL) ? 1 : 0;
  doubleOut[0] = HUGE_VAL;
}
