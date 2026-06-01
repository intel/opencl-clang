// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *source, __global double16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 /*, src2*/;
  double16 tmp;
  tmp = (double16)((double)0);
  {
    double16 src1 = source[0];
    ulong16 mask =
        (ulong16)(5, 12, 9, 9, 12, 8, 1, 8, 8, 11, 3, 12, 15, 10, 0, 13);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[1];
    ulong16 mask =
        (ulong16)(11, 14, 8, 3, 14, 2, 3, 4, 8, 9, 5, 11, 0, 1, 9, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[2];
    ulong16 mask =
        (ulong16)(1, 6, 12, 9, 9, 8, 6, 5, 14, 5, 3, 10, 2, 11, 6, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[3];
    ulong16 mask =
        (ulong16)(2, 15, 8, 12, 11, 15, 13, 14, 4, 1, 10, 15, 2, 2, 15, 14);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[4];
    ulong16 mask = (ulong16)(6, 14, 9, 7, 0, 10, 7, 7, 4, 12, 1, 9, 5, 1, 5, 9);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[5];
    ulong16 mask = (ulong16)(5, 3, 8, 15, 6, 7, 6, 4, 3, 12, 2, 10, 4, 2, 6, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[6];
    ulong16 mask =
        (ulong16)(10, 12, 10, 3, 4, 15, 5, 1, 4, 2, 9, 10, 13, 11, 15, 4);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[7];
    ulong16 mask =
        (ulong16)(13, 15, 10, 2, 2, 14, 10, 10, 15, 6, 12, 5, 12, 4, 8, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[8];
    ulong16 mask =
        (ulong16)(15, 13, 15, 11, 15, 15, 13, 8, 10, 11, 3, 10, 3, 1, 13, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[9];
    ulong16 mask =
        (ulong16)(5, 4, 11, 0, 0, 15, 14, 14, 15, 2, 13, 13, 9, 0, 11, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[10];
    ulong16 mask =
        (ulong16)(8, 1, 10, 6, 6, 5, 15, 10, 5, 12, 6, 8, 9, 8, 1, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[11];
    ulong16 mask =
        (ulong16)(12, 3, 2, 13, 10, 5, 2, 2, 10, 0, 10, 14, 6, 2, 4, 11);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[12];
    ulong16 mask =
        (ulong16)(14, 3, 11, 14, 7, 6, 1, 13, 13, 10, 1, 15, 0, 10, 12, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[13];
    ulong16 mask =
        (ulong16)(0, 13, 12, 0, 9, 1, 1, 4, 3, 6, 13, 3, 5, 14, 8, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[14];
    ulong16 mask =
        (ulong16)(14, 4, 3, 1, 11, 10, 9, 1, 4, 1, 15, 1, 9, 4, 14, 13);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[15];
    ulong16 mask =
        (ulong16)(4, 1, 10, 1, 0, 4, 10, 11, 10, 8, 9, 0, 8, 8, 3, 7);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[16];
    ulong16 mask =
        (ulong16)(10, 4, 10, 10, 11, 9, 12, 10, 1, 1, 7, 7, 4, 9, 15, 12);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[17];
    ulong16 mask =
        (ulong16)(12, 2, 10, 2, 11, 10, 6, 6, 7, 15, 5, 1, 7, 9, 11, 15);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[18];
    ulong16 mask =
        (ulong16)(12, 5, 5, 10, 11, 15, 11, 0, 8, 3, 11, 14, 7, 5, 2, 3);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[19];
    ulong16 mask = (ulong16)(0, 8, 5, 6, 13, 2, 14, 7, 6, 14, 5, 0, 4, 4, 0, 2);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[20];
    ulong16 mask =
        (ulong16)(9, 13, 7, 7, 15, 10, 9, 10, 1, 7, 4, 14, 7, 7, 3, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[21];
    ulong16 mask =
        (ulong16)(12, 10, 5, 0, 5, 6, 10, 1, 12, 6, 0, 4, 2, 4, 15, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[22];
    ulong16 mask = (ulong16)(7, 9, 11, 6, 2, 14, 5, 4, 13, 8, 7, 3, 3, 6, 5, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[23];
    ulong16 mask =
        (ulong16)(5, 14, 15, 10, 15, 3, 3, 10, 6, 14, 4, 0, 3, 13, 4, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[24];
    ulong16 mask =
        (ulong16)(1, 9, 7, 15, 9, 0, 2, 14, 11, 9, 2, 7, 8, 9, 11, 11);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[25];
    ulong16 mask =
        (ulong16)(7, 9, 8, 10, 10, 13, 9, 5, 3, 7, 7, 1, 8, 0, 13, 12);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[26];
    ulong16 mask =
        (ulong16)(15, 14, 14, 10, 4, 5, 11, 7, 1, 12, 10, 3, 14, 2, 2, 5);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[27];
    ulong16 mask =
        (ulong16)(11, 3, 3, 10, 2, 4, 11, 0, 8, 4, 3, 3, 14, 13, 7, 8);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[28];
    ulong16 mask =
        (ulong16)(1, 11, 1, 6, 0, 5, 2, 10, 2, 9, 0, 7, 7, 12, 2, 13);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[29];
    ulong16 mask =
        (ulong16)(15, 3, 2, 1, 8, 9, 10, 12, 11, 15, 5, 9, 8, 6, 8, 10);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[30];
    ulong16 mask =
        (ulong16)(14, 3, 1, 5, 8, 11, 5, 13, 6, 4, 3, 7, 8, 8, 13, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[31];
    ulong16 mask =
        (ulong16)(1, 4, 2, 12, 13, 13, 7, 6, 7, 7, 15, 12, 4, 2, 3, 13);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
