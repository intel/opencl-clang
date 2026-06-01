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
        (ulong16)(10, 3, 12, 11, 4, 8, 11, 7, 15, 9, 2, 4, 1, 11, 4, 10);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[1];
    ulong16 mask =
        (ulong16)(15, 13, 0, 10, 10, 2, 11, 2, 1, 2, 11, 15, 5, 6, 15, 8);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[2];
    ulong16 mask =
        (ulong16)(13, 8, 15, 15, 13, 15, 7, 5, 5, 4, 8, 4, 13, 12, 11, 15);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[3];
    ulong16 mask =
        (ulong16)(1, 8, 5, 10, 3, 0, 4, 10, 12, 8, 9, 9, 5, 15, 9, 6);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[4];
    ulong16 mask =
        (ulong16)(13, 0, 4, 8, 7, 13, 9, 3, 2, 3, 5, 9, 12, 2, 14, 13);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[5];
    ulong16 mask =
        (ulong16)(10, 3, 3, 4, 14, 9, 9, 7, 10, 14, 3, 6, 0, 12, 5, 4);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[6];
    ulong16 mask = (ulong16)(2, 9, 7, 9, 9, 4, 4, 11, 3, 8, 1, 14, 10, 2, 6, 5);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[7];
    ulong16 mask =
        (ulong16)(10, 12, 15, 13, 5, 3, 9, 11, 10, 9, 6, 10, 8, 3, 10, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[8];
    ulong16 mask =
        (ulong16)(2, 11, 6, 15, 13, 5, 2, 14, 3, 5, 3, 11, 8, 8, 13, 7);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[9];
    ulong16 mask =
        (ulong16)(7, 5, 6, 14, 13, 8, 12, 7, 7, 3, 14, 8, 9, 0, 6, 0);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[10];
    ulong16 mask =
        (ulong16)(12, 3, 13, 0, 15, 7, 8, 15, 3, 12, 1, 10, 9, 0, 15, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[11];
    ulong16 mask =
        (ulong16)(9, 11, 9, 9, 14, 13, 8, 11, 1, 9, 9, 11, 4, 12, 13, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[12];
    ulong16 mask =
        (ulong16)(4, 4, 6, 10, 15, 2, 14, 10, 11, 11, 10, 2, 12, 11, 13, 11);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[13];
    ulong16 mask =
        (ulong16)(9, 15, 15, 6, 6, 8, 15, 7, 4, 6, 3, 1, 8, 15, 1, 14);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[14];
    ulong16 mask =
        (ulong16)(6, 3, 15, 8, 6, 9, 6, 14, 13, 5, 11, 12, 2, 14, 4, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[15];
    ulong16 mask =
        (ulong16)(15, 9, 7, 10, 10, 3, 4, 0, 15, 15, 10, 12, 0, 5, 2, 8);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[16];
    ulong16 mask =
        (ulong16)(8, 13, 14, 7, 9, 3, 11, 9, 5, 1, 8, 7, 11, 9, 10, 5);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[17];
    ulong16 mask =
        (ulong16)(8, 11, 3, 14, 7, 6, 13, 4, 6, 9, 7, 9, 7, 8, 1, 14);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[18];
    ulong16 mask =
        (ulong16)(6, 8, 15, 8, 7, 5, 9, 14, 11, 1, 0, 11, 10, 10, 3, 12);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[19];
    ulong16 mask =
        (ulong16)(1, 4, 4, 15, 12, 9, 3, 12, 0, 7, 9, 1, 6, 12, 8, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[20];
    ulong16 mask =
        (ulong16)(9, 6, 9, 0, 1, 10, 3, 1, 15, 15, 8, 3, 6, 10, 4, 5);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[21];
    ulong16 mask =
        (ulong16)(7, 1, 1, 14, 5, 10, 7, 10, 2, 4, 3, 13, 13, 5, 5, 9);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[22];
    ulong16 mask =
        (ulong16)(12, 3, 7, 10, 5, 3, 14, 9, 12, 8, 0, 6, 10, 10, 1, 15);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[23];
    ulong16 mask =
        (ulong16)(13, 15, 14, 9, 8, 13, 15, 11, 8, 11, 9, 11, 10, 11, 14, 15);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[24];
    ulong16 mask =
        (ulong16)(4, 10, 2, 4, 13, 6, 10, 3, 13, 2, 9, 11, 11, 3, 14, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[25];
    ulong16 mask = (ulong16)(1, 3, 2, 6, 1, 5, 7, 2, 13, 0, 12, 8, 1, 2, 11, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[26];
    ulong16 mask =
        (ulong16)(4, 1, 11, 14, 14, 9, 13, 11, 11, 0, 4, 9, 11, 12, 6, 7);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[27];
    ulong16 mask =
        (ulong16)(13, 7, 14, 14, 11, 3, 15, 8, 9, 8, 11, 1, 10, 6, 8, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[28];
    ulong16 mask =
        (ulong16)(13, 14, 6, 12, 12, 1, 8, 14, 3, 11, 15, 10, 11, 3, 13, 11);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[29];
    ulong16 mask =
        (ulong16)(10, 8, 7, 14, 7, 12, 10, 15, 9, 15, 0, 12, 12, 8, 10, 10);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[30];
    ulong16 mask =
        (ulong16)(5, 15, 13, 13, 2, 5, 11, 0, 3, 2, 10, 10, 10, 4, 13, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[31];
    ulong16 mask =
        (ulong16)(13, 9, 10, 10, 11, 13, 10, 12, 5, 9, 0, 11, 10, 11, 8, 0);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
