// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *source, __global double8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 /*, src2*/;
  double8 tmp;
  tmp = (double8)((double)0);
  {
    double16 src1 = source[0];
    ulong8 mask = (ulong8)(6, 5, 1, 6, 13, 7, 11, 12);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[1];
    ulong8 mask = (ulong8)(2, 5, 11, 10, 10, 15, 11, 10);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[2];
    ulong8 mask = (ulong8)(7, 7, 0, 9, 12, 15, 0, 3);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[3];
    ulong8 mask = (ulong8)(7, 11, 8, 13, 3, 15, 9, 6);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[4];
    ulong8 mask = (ulong8)(11, 8, 13, 3, 13, 0, 1, 11);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[5];
    ulong8 mask = (ulong8)(15, 7, 13, 2, 14, 10, 1, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[6];
    ulong8 mask = (ulong8)(13, 12, 9, 12, 12, 1, 11, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[7];
    ulong8 mask = (ulong8)(2, 12, 2, 12, 5, 14, 10, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[8];
    ulong8 mask = (ulong8)(4, 4, 2, 8, 10, 5, 13, 13);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[9];
    ulong8 mask = (ulong8)(3, 10, 5, 13, 1, 12, 10, 14);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[10];
    ulong8 mask = (ulong8)(9, 10, 11, 2, 15, 6, 4, 12);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[11];
    ulong8 mask = (ulong8)(7, 9, 10, 8, 12, 9, 2, 15);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[12];
    ulong8 mask = (ulong8)(9, 0, 1, 4, 13, 1, 15, 8);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[13];
    ulong8 mask = (ulong8)(15, 11, 6, 12, 2, 8, 0, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[14];
    ulong8 mask = (ulong8)(8, 9, 2, 4, 10, 14, 5, 10);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[15];
    ulong8 mask = (ulong8)(2, 13, 0, 13, 10, 1, 7, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[16];
    ulong8 mask = (ulong8)(7, 3, 8, 2, 11, 5, 10, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[17];
    ulong8 mask = (ulong8)(5, 1, 11, 7, 8, 6, 11, 15);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[18];
    ulong8 mask = (ulong8)(1, 2, 5, 8, 12, 0, 8, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[19];
    ulong8 mask = (ulong8)(6, 6, 12, 5, 11, 2, 5, 14);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[20];
    ulong8 mask = (ulong8)(5, 5, 0, 11, 0, 9, 13, 10);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[21];
    ulong8 mask = (ulong8)(3, 3, 9, 10, 5, 5, 13, 15);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[22];
    ulong8 mask = (ulong8)(13, 2, 11, 4, 0, 12, 3, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[23];
    ulong8 mask = (ulong8)(4, 7, 13, 1, 10, 15, 12, 4);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[24];
    ulong8 mask = (ulong8)(0, 7, 12, 14, 14, 14, 7, 15);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[25];
    ulong8 mask = (ulong8)(8, 11, 11, 3, 12, 11, 3, 11);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[26];
    ulong8 mask = (ulong8)(6, 0, 5, 15, 11, 13, 12, 15);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[27];
    ulong8 mask = (ulong8)(11, 7, 13, 0, 14, 12, 14, 11);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[28];
    ulong8 mask = (ulong8)(5, 8, 0, 15, 1, 14, 2, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[29];
    ulong8 mask = (ulong8)(9, 9, 8, 13, 15, 2, 5, 2);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[30];
    ulong8 mask = (ulong8)(15, 14, 1, 2, 9, 5, 6, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[31];
    ulong8 mask = (ulong8)(3, 11, 8, 14, 1, 14, 5, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
