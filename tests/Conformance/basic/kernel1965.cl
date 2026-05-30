// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double *double_out, __global long *long_out) {
  long_out[0] = DBL_DIG;
  long_out[1] = DBL_MANT_DIG;
  long_out[2] = DBL_MAX_10_EXP;
  long_out[3] = DBL_MAX_EXP;
  long_out[4] = DBL_MIN_10_EXP;
  long_out[5] = DBL_MIN_EXP;
  long_out[6] = DBL_RADIX;
  double_out[0] = DBL_MAX;
  double_out[1] = DBL_MIN;
  double_out[2] = DBL_EPSILON;
  double_out[3] = M_E;
  double_out[4] = M_LOG2E;
  double_out[5] = M_LOG10E;
  double_out[6] = M_LN2;
  double_out[7] = M_LN10;
  double_out[8] = M_PI;
  double_out[9] = M_PI_2;
  double_out[10] = M_PI_4;
  double_out[11] = M_1_PI;
  double_out[12] = M_2_PI;
  double_out[13] = M_2_SQRTPI;
  double_out[14] = M_SQRT2;
  double_out[15] = M_SQRT1_2;
}
