// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global int *intOut, __global float *floatOut) {
  intOut[0] = (INFINITY == HUGE_VALF) ? 1 : 0;
  intOut[1] = sizeof(INFINITY);
  intOut[2] = isinf(INFINITY) ? 1 : 0;
  intOut[3] = isnormal(INFINITY) ? 1 : 0;
  intOut[4] = isnan(INFINITY) ? 1 : 0;
  intOut[5] = (INFINITY > MAXFLOAT) ? 1 : 0;
  intOut[6] = (-INFINITY < -MAXFLOAT) ? 1 : 0;
  intOut[7] = ((MAXFLOAT + MAXFLOAT) == INFINITY) ? 1 : 0;
  intOut[8] = (nextafter(MAXFLOAT, INFINITY) == INFINITY) ? 1 : 0;
  intOut[9] = (nextafter(-MAXFLOAT, -INFINITY) == -INFINITY) ? 1 : 0;
  intOut[10] = (INFINITY == INFINITY) ? 1 : 0;
  intOut[11] = (as_uint(INFINITY) == 0x7f800000) ? 1 : 0;
  floatOut[0] = INFINITY;

  intOut[12] = sizeof(HUGE_VALF);
  intOut[13] = (HUGE_VALF == INFINITY) ? 1 : 0;
  floatOut[1] = HUGE_VALF;

  intOut[14] = (NAN == NAN) ? 1 : 0;
  intOut[15] = (NAN != NAN) ? 1 : 0;
  intOut[16] = isnan(NAN) ? 1 : 0;
  intOut[17] = isinf(NAN) ? 1 : 0;
  intOut[18] = isnormal(NAN) ? 1 : 0;
  intOut[19] = ((as_uint(NAN) & 0x7fffffff) > 0x7f800000) ? 1 : 0;
  intOut[20] = sizeof(NAN);
  floatOut[2] = NAN;

  intOut[21] = isnan(INFINITY / INFINITY) ? 1 : 0;
  intOut[22] = isnan(INFINITY - INFINITY) ? 1 : 0;
  intOut[23] = isnan(0.f / 0.f) ? 1 : 0;
  intOut[24] = isnan(INFINITY * 0.f) ? 1 : 0;
  intOut[25] = (INFINITY == NAN);
  intOut[26] = (-INFINITY == NAN);
  intOut[27] = (INFINITY > NAN);
  intOut[28] = (-INFINITY < NAN);
  intOut[29] = (INFINITY != NAN);
  intOut[30] = (NAN > INFINITY);
  intOut[31] = (NAN < -INFINITY);
}
