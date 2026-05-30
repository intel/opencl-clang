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
    ulong4 mask = (ulong4)(11, 12, 3, 6);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[1];
    ulong4 mask = (ulong4)(4, 9, 4, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[2];
    ulong4 mask = (ulong4)(15, 15, 11, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[3];
    ulong4 mask = (ulong4)(1, 15, 8, 11);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[4];
    ulong4 mask = (ulong4)(4, 1, 12, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[5];
    ulong4 mask = (ulong4)(13, 6, 7, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[6];
    ulong4 mask = (ulong4)(1, 8, 15, 10);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[7];
    ulong4 mask = (ulong4)(6, 12, 2, 8);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[8];
    ulong4 mask = (ulong4)(9, 7, 8, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[9];
    ulong4 mask = (ulong4)(13, 5, 15, 3);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[10];
    ulong4 mask = (ulong4)(7, 3, 1, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[11];
    ulong4 mask = (ulong4)(0, 7, 8, 9);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[12];
    ulong4 mask = (ulong4)(5, 14, 7, 15);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[13];
    ulong4 mask = (ulong4)(5, 10, 4, 15);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[14];
    ulong4 mask = (ulong4)(1, 14, 14, 6);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[15];
    ulong4 mask = (ulong4)(6, 2, 10, 11);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[16];
    ulong4 mask = (ulong4)(4, 3, 7, 15);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[17];
    ulong4 mask = (ulong4)(4, 15, 1, 8);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[18];
    ulong4 mask = (ulong4)(15, 3, 12, 3);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[19];
    ulong4 mask = (ulong4)(7, 9, 14, 10);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[20];
    ulong4 mask = (ulong4)(5, 10, 10, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[21];
    ulong4 mask = (ulong4)(12, 1, 4, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[22];
    ulong4 mask = (ulong4)(1, 12, 4, 6);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[23];
    ulong4 mask = (ulong4)(6, 4, 15, 5);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[24];
    ulong4 mask = (ulong4)(13, 12, 2, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[25];
    ulong4 mask = (ulong4)(2, 0, 13, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[26];
    ulong4 mask = (ulong4)(8, 2, 7, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[27];
    ulong4 mask = (ulong4)(15, 12, 1, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[28];
    ulong4 mask = (ulong4)(13, 13, 5, 7);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[29];
    ulong4 mask = (ulong4)(5, 8, 15, 0);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[30];
    ulong4 mask = (ulong4)(15, 10, 9, 9);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[31];
    ulong4 mask = (ulong4)(12, 9, 14, 13);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
