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
        (ulong16)(27, 23, 3, 18, 25, 17, 24, 27, 6, 3, 0, 5, 19, 5, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[1];
    long16 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(12, 24, 20, 17, 1, 15, 10, 17, 28, 25, 26, 12, 14, 8, 3, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[2];
    long16 src2 = secondSource[2];
    ulong16 mask = (ulong16)(18, 25, 10, 27, 21, 24, 16, 1, 14, 26, 22, 23, 13,
                             24, 20, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[3];
    long16 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(7, 3, 9, 12, 2, 29, 26, 4, 15, 16, 24, 9, 28, 31, 31, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[4];
    long16 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(15, 29, 24, 13, 19, 19, 25, 28, 29, 13, 16, 28, 11, 21, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[5];
    long16 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(30, 4, 13, 19, 14, 24, 25, 3, 29, 12, 24, 20, 3, 3, 29, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[6];
    long16 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(24, 14, 18, 16, 16, 5, 13, 15, 31, 10, 24, 0, 31, 18, 26, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[7];
    long16 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(17, 19, 13, 28, 24, 11, 22, 24, 28, 25, 11, 3, 25, 26, 20, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[8];
    long16 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(0, 27, 8, 18, 23, 2, 20, 6, 23, 3, 12, 24, 21, 24, 27, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[9];
    long16 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(22, 28, 28, 18, 3, 13, 29, 25, 14, 16, 0, 28, 31, 21, 10, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[10];
    long16 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(2, 15, 11, 23, 20, 1, 17, 1, 19, 6, 18, 21, 15, 13, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[11];
    long16 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(24, 13, 8, 22, 22, 21, 9, 7, 4, 20, 30, 16, 16, 30, 25, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[12];
    long16 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(4, 3, 24, 28, 21, 3, 28, 0, 3, 8, 19, 20, 28, 21, 31, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[13];
    long16 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(2, 5, 20, 30, 13, 14, 21, 14, 24, 25, 27, 6, 24, 14, 24, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[14];
    long16 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(2, 19, 29, 5, 12, 0, 12, 22, 22, 1, 7, 30, 3, 10, 6, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[15];
    long16 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(7, 23, 15, 17, 26, 10, 15, 3, 13, 30, 12, 20, 15, 12, 27, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[16];
    long16 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(0, 30, 7, 11, 26, 0, 14, 26, 23, 27, 21, 14, 21, 9, 14, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[17];
    long16 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(31, 5, 10, 14, 20, 27, 5, 30, 5, 14, 27, 17, 25, 27, 31, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[18];
    long16 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(8, 0, 17, 24, 9, 21, 31, 24, 12, 2, 6, 25, 23, 11, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[19];
    long16 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(15, 2, 26, 22, 18, 30, 27, 14, 16, 26, 2, 26, 27, 7, 10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[20];
    long16 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(22, 21, 21, 17, 16, 16, 27, 25, 28, 3, 23, 20, 14, 14, 2, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[21];
    long16 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(15, 4, 18, 6, 4, 31, 15, 10, 12, 7, 2, 20, 12, 12, 30, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[22];
    long16 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(12, 22, 4, 10, 29, 25, 2, 9, 22, 19, 11, 28, 9, 22, 29, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[23];
    long16 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(9, 19, 4, 30, 21, 6, 2, 5, 4, 18, 14, 13, 13, 9, 21, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[24];
    long16 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(31, 5, 16, 23, 6, 12, 12, 30, 4, 21, 9, 27, 31, 2, 22, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[25];
    long16 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(19, 6, 22, 6, 26, 6, 2, 5, 28, 8, 29, 0, 18, 8, 9, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[26];
    long16 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(1, 6, 18, 0, 16, 19, 11, 13, 1, 28, 8, 5, 5, 1, 8, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[27];
    long16 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(18, 19, 0, 8, 19, 14, 10, 9, 3, 2, 12, 24, 25, 25, 31, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[28];
    long16 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(20, 23, 31, 28, 14, 5, 14, 25, 7, 22, 14, 22, 29, 27, 5, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[29];
    long16 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(11, 5, 13, 3, 19, 29, 3, 8, 15, 6, 22, 1, 8, 13, 13, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[30];
    long16 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(3, 18, 16, 3, 1, 3, 10, 18, 6, 30, 8, 4, 19, 13, 31, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[31];
    long16 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(11, 20, 21, 3, 1, 0, 14, 24, 3, 18, 30, 1, 23, 0, 12, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
