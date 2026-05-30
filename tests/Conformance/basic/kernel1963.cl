// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float *float_out, __global int *int_out,
                   __global uint *uint_out) {
  int_out[0] = CHAR_BIT;
  int_out[1] = SCHAR_MAX;
  int_out[2] = SCHAR_MIN;
  int_out[3] = CHAR_MAX;
  int_out[4] = CHAR_MIN;
  int_out[5] = UCHAR_MAX;
  int_out[6] = SHRT_MAX;
  int_out[7] = SHRT_MIN;
  int_out[8] = USHRT_MAX;
  int_out[9] = INT_MAX;
  int_out[10] = INT_MIN;
  uint_out[0] = UINT_MAX;
  int_out[11] = FLT_DIG;
  int_out[12] = FLT_MANT_DIG;
  int_out[13] = FLT_MAX_10_EXP;
  int_out[14] = FLT_MAX_EXP;
  int_out[15] = FLT_MIN_10_EXP;
  int_out[16] = FLT_MIN_EXP;
  int_out[17] = FLT_RADIX;
#ifdef __IMAGE_SUPPORT__
  int_out[18] = __IMAGE_SUPPORT__;
#else
  int_out[18] = 0xf00baa;
#endif
  float_out[0] = FLT_MAX;
  float_out[1] = FLT_MIN;
  float_out[2] = FLT_EPSILON;
  float_out[3] = M_E_F;
  float_out[4] = M_LOG2E_F;
  float_out[5] = M_LOG10E_F;
  float_out[6] = M_LN2_F;
  float_out[7] = M_LN10_F;
  float_out[8] = M_PI_F;
  float_out[9] = M_PI_2_F;
  float_out[10] = M_PI_4_F;
  float_out[11] = M_1_PI_F;
  float_out[12] = M_2_PI_F;
  float_out[13] = M_2_SQRTPI_F;
  float_out[14] = M_SQRT2_F;
  float_out[15] = M_SQRT1_2_F;
}
