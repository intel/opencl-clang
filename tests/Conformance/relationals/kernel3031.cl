// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *secondSource,
                          __global double16 *source, __global double16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 , src2;
  double16 tmp;
  tmp = (double16)((double)0);
  {
    double16 src1 = source[0];
    double16 src2 = secondSource[0];
    ulong16 mask =
        (ulong16)(20, 6, 25, 22, 8, 16, 22, 15, 31, 18, 4, 8, 3, 22, 9, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(31, 27, 1, 20, 20, 4, 22, 4, 2, 5, 23, 31, 10, 13, 30, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(27, 17, 30, 31, 27, 30, 15, 10, 10, 9, 17, 8, 27, 24, 23, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(2, 16, 11, 21, 6, 1, 9, 20, 24, 17, 19, 18, 11, 31, 19, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(27, 0, 8, 17, 15, 26, 18, 7, 5, 6, 10, 18, 25, 4, 29, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(20, 7, 7, 9, 28, 19, 18, 14, 21, 28, 6, 12, 0, 25, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(5, 18, 14, 18, 19, 9, 9, 22, 6, 17, 3, 29, 21, 4, 13, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(20, 24, 31, 27, 11, 7, 18, 22, 21, 18, 12, 20, 16, 7, 21, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(5, 23, 12, 30, 26, 10, 4, 29, 7, 11, 7, 22, 16, 16, 27, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(14, 11, 12, 28, 27, 17, 25, 15, 14, 6, 29, 17, 19, 1, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(24, 6, 27, 1, 30, 14, 16, 31, 7, 24, 3, 21, 19, 0, 31, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(18, 23, 18, 19, 28, 26, 16, 23, 2, 19, 18, 23, 8, 25, 27, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(8, 9, 13, 21, 30, 4, 28, 20, 22, 22, 21, 4, 25, 23, 27, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(19, 30, 30, 12, 13, 17, 30, 15, 8, 12, 7, 2, 16, 30, 2, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(12, 7, 31, 16, 13, 19, 13, 28, 27, 10, 23, 25, 4, 29, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(30, 18, 14, 21, 20, 7, 8, 0, 30, 31, 20, 25, 1, 11, 5, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(17, 26, 29, 14, 18, 7, 23, 18, 11, 3, 17, 15, 22, 18, 20, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(17, 23, 7, 29, 15, 12, 26, 8, 13, 19, 14, 19, 15, 17, 3, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(13, 16, 31, 17, 14, 11, 19, 28, 22, 3, 1, 23, 21, 21, 6, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(3, 8, 9, 30, 24, 18, 6, 25, 0, 14, 18, 3, 12, 24, 16, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(18, 12, 19, 0, 3, 20, 7, 3, 31, 30, 17, 7, 12, 20, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(14, 2, 3, 29, 10, 21, 15, 20, 5, 8, 7, 27, 26, 10, 10, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(24, 7, 14, 20, 10, 7, 28, 18, 24, 17, 1, 12, 21, 21, 3, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong16 mask = (ulong16)(27, 30, 28, 19, 17, 26, 31, 22, 16, 23, 19, 23, 21,
                             23, 29, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(9, 21, 5, 8, 27, 12, 20, 6, 27, 4, 18, 23, 22, 7, 28, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(2, 6, 5, 13, 2, 10, 15, 4, 26, 0, 24, 16, 2, 4, 23, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(9, 2, 22, 29, 29, 18, 26, 23, 22, 0, 9, 19, 22, 24, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(27, 15, 28, 29, 23, 6, 30, 17, 19, 16, 23, 3, 20, 12, 16, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(26, 29, 12, 24, 24, 3, 17, 28, 6, 23, 30, 20, 23, 6, 26, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong16 mask = (ulong16)(20, 16, 14, 28, 14, 25, 21, 30, 19, 31, 1, 25, 24,
                             17, 21, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(11, 31, 27, 26, 4, 10, 23, 1, 6, 4, 20, 21, 20, 9, 27, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(27, 19, 21, 21, 22, 26, 20, 25, 11, 19, 0, 23, 20, 22, 16, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
