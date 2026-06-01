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
        (ulong16)(11, 25, 19, 19, 24, 16, 2, 17, 17, 23, 7, 25, 30, 20, 0, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(23, 28, 17, 7, 29, 4, 6, 8, 17, 19, 11, 23, 1, 3, 18, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(3, 12, 25, 18, 19, 16, 13, 11, 29, 10, 7, 20, 5, 22, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(5, 31, 17, 24, 22, 30, 27, 29, 8, 2, 21, 30, 5, 4, 31, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(13, 29, 18, 14, 0, 21, 14, 15, 8, 24, 3, 18, 11, 3, 10, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(10, 7, 16, 30, 12, 14, 13, 8, 7, 24, 4, 21, 9, 4, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(21, 24, 20, 6, 8, 31, 11, 3, 8, 4, 19, 21, 26, 22, 30, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(26, 30, 21, 4, 5, 29, 21, 20, 31, 12, 24, 11, 24, 8, 17, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(30, 27, 31, 22, 30, 31, 26, 16, 20, 23, 7, 20, 6, 2, 26, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(10, 8, 22, 0, 1, 30, 29, 28, 30, 4, 26, 26, 18, 0, 22, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(16, 3, 21, 13, 13, 11, 30, 20, 10, 25, 13, 17, 18, 17, 2, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(24, 6, 5, 27, 21, 11, 5, 5, 21, 0, 21, 28, 13, 4, 9, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(29, 6, 22, 28, 15, 12, 3, 26, 26, 21, 2, 31, 0, 20, 25, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(1, 27, 24, 1, 18, 2, 3, 9, 7, 12, 26, 6, 11, 28, 16, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(29, 8, 6, 2, 22, 20, 19, 3, 8, 2, 30, 2, 19, 9, 28, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(9, 3, 21, 3, 1, 8, 20, 23, 21, 16, 19, 1, 16, 17, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(20, 8, 21, 20, 23, 19, 25, 21, 2, 2, 14, 15, 8, 19, 30, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(24, 5, 21, 5, 22, 20, 12, 12, 14, 31, 10, 2, 14, 19, 22, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(25, 11, 10, 20, 23, 30, 23, 0, 17, 7, 22, 28, 14, 11, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(0, 16, 11, 12, 27, 5, 29, 14, 13, 28, 10, 0, 9, 8, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(18, 27, 14, 15, 31, 21, 18, 20, 3, 14, 9, 28, 15, 15, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(24, 21, 11, 0, 10, 13, 20, 3, 24, 13, 1, 9, 5, 9, 31, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(14, 18, 22, 12, 5, 29, 10, 8, 26, 16, 15, 6, 7, 12, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(11, 28, 31, 21, 31, 7, 6, 21, 13, 28, 8, 0, 6, 27, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(3, 19, 14, 30, 19, 0, 4, 29, 22, 18, 4, 15, 16, 18, 23, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(15, 19, 17, 21, 20, 27, 18, 11, 7, 15, 14, 3, 17, 0, 26, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(31, 28, 28, 21, 9, 10, 23, 15, 2, 25, 20, 7, 28, 5, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(23, 6, 6, 21, 5, 9, 22, 1, 17, 8, 7, 6, 29, 26, 14, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(2, 23, 3, 13, 1, 11, 4, 20, 4, 19, 0, 14, 14, 25, 5, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(31, 7, 4, 2, 16, 18, 21, 25, 22, 31, 11, 19, 17, 13, 17, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(28, 6, 3, 11, 16, 22, 10, 27, 12, 8, 6, 15, 17, 16, 26, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(3, 8, 4, 24, 27, 27, 15, 13, 15, 14, 30, 24, 9, 5, 7, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
