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
    ulong8 mask = (ulong8)(10, 14, 6, 14, 14, 12, 1, 12);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[1];
    ulong8 mask = (ulong8)(14, 0, 8, 13, 2, 0, 0, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[2];
    ulong8 mask = (ulong8)(3, 6, 4, 3, 5, 4, 15, 8);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[3];
    ulong8 mask = (ulong8)(5, 1, 15, 13, 5, 0, 12, 12);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[4];
    ulong8 mask = (ulong8)(15, 12, 15, 2, 10, 12, 7, 13);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[5];
    ulong8 mask = (ulong8)(13, 10, 14, 4, 6, 7, 7, 14);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[6];
    ulong8 mask = (ulong8)(1, 14, 3, 9, 5, 12, 4, 0);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[7];
    ulong8 mask = (ulong8)(3, 9, 2, 1, 1, 3, 8, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[8];
    ulong8 mask = (ulong8)(12, 1, 6, 3, 2, 13, 12, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[9];
    ulong8 mask = (ulong8)(14, 6, 12, 10, 11, 7, 11, 12);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[10];
    ulong8 mask = (ulong8)(4, 5, 4, 11, 4, 9, 2, 11);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[11];
    ulong8 mask = (ulong8)(10, 0, 1, 11, 12, 11, 10, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[12];
    ulong8 mask = (ulong8)(4, 14, 0, 14, 2, 5, 14, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[13];
    ulong8 mask = (ulong8)(11, 11, 3, 5, 0, 10, 11, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[14];
    ulong8 mask = (ulong8)(3, 11, 9, 7, 1, 3, 5, 7);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[15];
    ulong8 mask = (ulong8)(6, 10, 7, 8, 14, 1, 10, 15);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[16];
    ulong8 mask = (ulong8)(4, 6, 12, 8, 7, 14, 11, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[17];
    ulong8 mask = (ulong8)(0, 3, 3, 8, 9, 15, 10, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[18];
    ulong8 mask = (ulong8)(2, 8, 15, 14, 2, 5, 13, 3);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[19];
    ulong8 mask = (ulong8)(4, 14, 13, 4, 5, 8, 12, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[20];
    ulong8 mask = (ulong8)(1, 4, 2, 13, 12, 6, 8, 13);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[21];
    ulong8 mask = (ulong8)(2, 1, 5, 8, 14, 3, 13, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[22];
    ulong8 mask = (ulong8)(9, 0, 12, 0, 7, 9, 8, 14);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[23];
    ulong8 mask = (ulong8)(0, 14, 2, 8, 11, 8, 14, 9);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[24];
    ulong8 mask = (ulong8)(6, 4, 1, 9, 15, 0, 0, 14);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[25];
    ulong8 mask = (ulong8)(15, 9, 3, 4, 5, 11, 9, 4);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[26];
    ulong8 mask = (ulong8)(13, 10, 10, 12, 14, 8, 15, 7);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[27];
    ulong8 mask = (ulong8)(0, 2, 9, 9, 1, 3, 5, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[28];
    ulong8 mask = (ulong8)(12, 1, 8, 6, 2, 14, 2, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[29];
    ulong8 mask = (ulong8)(7, 15, 7, 0, 0, 1, 7, 12);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[30];
    ulong8 mask = (ulong8)(5, 6, 2, 8, 14, 3, 10, 8);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[31];
    ulong8 mask = (ulong8)(8, 5, 8, 14, 13, 5, 5, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
