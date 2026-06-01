// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *source, __global double4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 /*, src2*/;
  double4 tmp;
  tmp = (double4)((double)0);
  {
    double16 src1 = source[0];
    ulong4 mask = (ulong4)(3, 10, 0, 11);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[1];
    ulong4 mask = (ulong4)(1, 14, 11, 7);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[2];
    ulong4 mask = (ulong4)(3, 4, 4, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[3];
    ulong4 mask = (ulong4)(6, 2, 1, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[4];
    ulong4 mask = (ulong4)(10, 6, 11, 9);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[5];
    ulong4 mask = (ulong4)(2, 2, 7, 11);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[6];
    ulong4 mask = (ulong4)(2, 1, 10, 12);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[7];
    ulong4 mask = (ulong4)(10, 14, 5, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[8];
    ulong4 mask = (ulong4)(12, 15, 6, 13);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[9];
    ulong4 mask = (ulong4)(1, 4, 8, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[10];
    ulong4 mask = (ulong4)(15, 3, 13, 4);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[11];
    ulong4 mask = (ulong4)(7, 6, 3, 9);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[12];
    ulong4 mask = (ulong4)(2, 6, 1, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[13];
    ulong4 mask = (ulong4)(8, 10, 14, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[14];
    ulong4 mask = (ulong4)(0, 3, 13, 8);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[15];
    ulong4 mask = (ulong4)(4, 4, 9, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[16];
    ulong4 mask = (ulong4)(6, 4, 5, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[17];
    ulong4 mask = (ulong4)(8, 12, 5, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[18];
    ulong4 mask = (ulong4)(0, 15, 1, 11);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[19];
    ulong4 mask = (ulong4)(8, 6, 0, 9);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[20];
    ulong4 mask = (ulong4)(4, 2, 1, 13);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[21];
    ulong4 mask = (ulong4)(10, 10, 1, 1);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[22];
    ulong4 mask = (ulong4)(11, 15, 0, 15);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[23];
    ulong4 mask = (ulong4)(4, 11, 10, 5);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[24];
    ulong4 mask = (ulong4)(1, 15, 10, 10);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[25];
    ulong4 mask = (ulong4)(5, 2, 4, 14);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[26];
    ulong4 mask = (ulong4)(2, 9, 8, 9);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[27];
    ulong4 mask = (ulong4)(0, 12, 14, 14);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[28];
    ulong4 mask = (ulong4)(6, 7, 15, 7);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[29];
    ulong4 mask = (ulong4)(1, 1, 12, 5);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[30];
    ulong4 mask = (ulong4)(13, 1, 0, 15);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[31];
    ulong4 mask = (ulong4)(6, 2, 1, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
