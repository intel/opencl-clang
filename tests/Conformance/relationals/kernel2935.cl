// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *secondSource,
                          __global long16 *source, __global long16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 , src2;
  long16 tmp;
  tmp = (long16)((long)0);
  {
    long16 src1 = source[0];
    long16 src2 = secondSource[0];
    ulong16 mask =
        (ulong16)(10, 7, 21, 27, 5, 28, 27, 3, 22, 21, 30, 20, 2, 25, 21, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[1];
    long16 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(15, 24, 11, 19, 19, 2, 6, 18, 5, 11, 28, 14, 23, 13, 5, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[2];
    long16 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(30, 14, 1, 10, 4, 14, 29, 1, 0, 28, 23, 31, 20, 5, 23, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[3];
    long16 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(1, 2, 7, 25, 17, 18, 22, 4, 24, 1, 22, 12, 24, 8, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[4];
    long16 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(18, 2, 18, 12, 21, 12, 23, 7, 2, 20, 2, 23, 9, 24, 11, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[5];
    long16 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(2, 5, 11, 10, 26, 6, 4, 2, 30, 24, 10, 30, 17, 17, 3, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[6];
    long16 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(0, 4, 24, 21, 29, 15, 12, 18, 1, 15, 18, 17, 26, 28, 11, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[7];
    long16 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(16, 19, 11, 3, 28, 16, 19, 19, 5, 2, 15, 18, 28, 27, 22, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[8];
    long16 src2 = secondSource[8];
    ulong16 mask = (ulong16)(23, 23, 2, 17, 31, 13, 23, 27, 27, 26, 24, 15, 23,
                             24, 18, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[9];
    long16 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(7, 9, 2, 5, 20, 4, 6, 6, 9, 2, 13, 10, 7, 1, 24, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[10];
    long16 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(2, 31, 18, 31, 10, 19, 23, 0, 15, 23, 7, 30, 9, 20, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[11];
    long16 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(0, 3, 7, 20, 2, 28, 11, 18, 20, 7, 21, 22, 17, 8, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[12];
    long16 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(9, 14, 10, 18, 26, 23, 20, 6, 22, 7, 0, 14, 29, 20, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[13];
    long16 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(8, 0, 25, 18, 18, 24, 26, 15, 11, 12, 25, 23, 2, 28, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[14];
    long16 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(22, 14, 9, 10, 14, 10, 25, 1, 31, 28, 16, 28, 2, 8, 31, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[15];
    long16 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(25, 12, 1, 27, 3, 4, 30, 14, 28, 15, 23, 21, 0, 13, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[16];
    long16 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(25, 29, 18, 10, 5, 13, 21, 2, 12, 17, 2, 4, 5, 24, 20, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[17];
    long16 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(30, 2, 18, 11, 3, 14, 1, 18, 4, 31, 27, 18, 28, 30, 23, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[18];
    long16 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(19, 0, 2, 3, 8, 26, 7, 17, 4, 14, 0, 13, 16, 25, 30, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[19];
    long16 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(26, 12, 25, 30, 23, 17, 13, 21, 3, 24, 8, 23, 21, 0, 21, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[20];
    long16 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(29, 11, 10, 3, 16, 27, 12, 30, 8, 3, 18, 29, 20, 18, 24, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[21];
    long16 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(5, 4, 6, 11, 25, 4, 22, 19, 23, 8, 12, 12, 14, 27, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[22];
    long16 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(3, 24, 6, 27, 18, 22, 12, 22, 19, 14, 26, 10, 2, 0, 25, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[23];
    long16 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(17, 22, 31, 25, 20, 19, 19, 30, 2, 5, 30, 18, 28, 3, 26, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[24];
    long16 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(27, 19, 16, 18, 9, 9, 4, 21, 25, 23, 30, 15, 21, 8, 23, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[25];
    long16 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(23, 25, 10, 31, 29, 24, 11, 12, 7, 29, 16, 16, 4, 27, 10, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[26];
    long16 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(12, 1, 13, 26, 6, 14, 31, 22, 10, 10, 24, 11, 16, 28, 0, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[27];
    long16 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(10, 30, 11, 2, 18, 1, 23, 4, 23, 25, 27, 12, 24, 14, 16, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[28];
    long16 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(31, 11, 25, 10, 10, 19, 12, 23, 20, 0, 18, 3, 31, 17, 19, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[29];
    long16 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(0, 23, 31, 13, 16, 10, 24, 26, 0, 20, 5, 15, 19, 20, 7, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[30];
    long16 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(1, 18, 24, 31, 23, 13, 9, 23, 5, 11, 0, 26, 1, 6, 8, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[31];
    long16 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(22, 27, 11, 8, 19, 24, 13, 4, 28, 31, 12, 11, 29, 20, 21, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
