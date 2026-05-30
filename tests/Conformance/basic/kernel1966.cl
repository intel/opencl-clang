// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global int *intOut, __global float *floatOut) {
  intOut[0] = isinf(MAXFLOAT) ? 1 : 0;
  intOut[1] = isnormal(MAXFLOAT) ? 1 : 0;
  intOut[2] = isnan(MAXFLOAT) ? 1 : 0;
  intOut[3] = sizeof(MAXFLOAT);
  intOut[4] = (MAXFLOAT == FLT_MAX) ? 1 : 0;
  intOut[6] = (MAXFLOAT == MAXFLOAT) ? 1 : 0;
  intOut[7] = (MAXFLOAT == 0x1.fffffep127f) ? 1 : 0;
  floatOut[0] = MAXFLOAT;
}
