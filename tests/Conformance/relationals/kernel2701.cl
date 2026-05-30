// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *source, __global double8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double8 src1 /*, src2*/;
  double8 tmp;
  tmp = (double8)((double)0);
  {
    double8 src1 = source[0];
    ulong8 mask = (ulong8)(2, 2, 5, 4, 6, 2, 0, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[1];
    ulong8 mask = (ulong8)(7, 4, 2, 5, 2, 0, 7, 2);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[2];
    ulong8 mask = (ulong8)(0, 2, 5, 6, 2, 2, 7, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[3];
    ulong8 mask = (ulong8)(3, 6, 7, 4, 5, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[4];
    ulong8 mask = (ulong8)(1, 1, 5, 7, 3, 5, 3, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[5];
    ulong8 mask = (ulong8)(6, 4, 7, 0, 6, 4, 5, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[6];
    ulong8 mask = (ulong8)(4, 1, 4, 6, 0, 1, 4, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[7];
    ulong8 mask = (ulong8)(0, 3, 6, 0, 0, 4, 3, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[8];
    ulong8 mask = (ulong8)(7, 6, 3, 4, 4, 2, 1, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[9];
    ulong8 mask = (ulong8)(3, 5, 6, 0, 0, 6, 3, 6);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[10];
    ulong8 mask = (ulong8)(6, 5, 5, 5, 7, 0, 4, 3);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[11];
    ulong8 mask = (ulong8)(6, 3, 2, 4, 7, 2, 0, 3);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[12];
    ulong8 mask = (ulong8)(4, 5, 6, 4, 3, 3, 6, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[13];
    ulong8 mask = (ulong8)(1, 4, 3, 6, 1, 6, 6, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[14];
    ulong8 mask = (ulong8)(0, 1, 5, 6, 3, 4, 5, 5);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[15];
    ulong8 mask = (ulong8)(7, 3, 6, 2, 0, 3, 4, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[16];
    ulong8 mask = (ulong8)(5, 2, 3, 4, 1, 6, 4, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[17];
    ulong8 mask = (ulong8)(5, 6, 7, 1, 7, 2, 7, 3);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[18];
    ulong8 mask = (ulong8)(5, 5, 0, 2, 4, 6, 3, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[19];
    ulong8 mask = (ulong8)(0, 0, 2, 6, 7, 7, 4, 2);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[20];
    ulong8 mask = (ulong8)(3, 1, 3, 3, 7, 2, 4, 7);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[21];
    ulong8 mask = (ulong8)(5, 6, 2, 1, 0, 0, 2, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[22];
    ulong8 mask = (ulong8)(0, 0, 3, 0, 4, 3, 6, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[23];
    ulong8 mask = (ulong8)(5, 6, 7, 3, 4, 1, 5, 4);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[24];
    ulong8 mask = (ulong8)(0, 2, 4, 0, 2, 2, 5, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[25];
    ulong8 mask = (ulong8)(0, 0, 6, 0, 4, 6, 7, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[26];
    ulong8 mask = (ulong8)(5, 2, 0, 0, 6, 7, 6, 7);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[27];
    ulong8 mask = (ulong8)(2, 5, 7, 5, 7, 5, 3, 5);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[28];
    ulong8 mask = (ulong8)(1, 2, 7, 3, 7, 7, 4, 4);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[29];
    ulong8 mask = (ulong8)(6, 2, 5, 2, 7, 6, 4, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[30];
    ulong8 mask = (ulong8)(1, 5, 0, 3, 0, 0, 2, 7);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[31];
    ulong8 mask = (ulong8)(3, 7, 2, 4, 7, 1, 6, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
