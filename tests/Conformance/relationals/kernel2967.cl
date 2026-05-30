// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *secondSource,
                          __global ulong16 *source, __global ulong16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 , src2;
  ulong16 tmp;
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong16 src2 = secondSource[0];
    ulong16 mask =
        (ulong16)(9, 22, 1, 25, 30, 1, 30, 16, 19, 0, 31, 26, 27, 17, 0, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(21, 1, 18, 6, 6, 28, 27, 31, 7, 28, 10, 22, 13, 29, 24, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(1, 22, 23, 4, 0, 16, 4, 8, 26, 9, 2, 26, 10, 13, 4, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(21, 16, 1, 28, 4, 17, 30, 25, 15, 27, 20, 6, 1, 22, 18, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(30, 7, 18, 8, 13, 28, 0, 9, 8, 5, 10, 9, 8, 18, 9, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(16, 9, 4, 5, 2, 25, 5, 0, 3, 21, 29, 24, 16, 4, 25, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(13, 26, 13, 9, 10, 14, 13, 27, 16, 6, 7, 28, 18, 22, 6, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 src2 = secondSource[7];
    ulong16 mask = (ulong16)(15, 29, 27, 24, 15, 12, 15, 13, 20, 30, 26, 14, 24,
                             15, 18, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(24, 15, 5, 11, 18, 17, 1, 13, 22, 28, 4, 14, 12, 20, 21, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(3, 8, 4, 24, 31, 30, 21, 18, 16, 29, 13, 9, 18, 21, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(2, 15, 2, 19, 6, 12, 25, 30, 2, 5, 9, 28, 7, 7, 19, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(21, 13, 11, 13, 21, 27, 15, 16, 30, 26, 16, 26, 16, 18, 0, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(23, 0, 6, 4, 18, 29, 22, 24, 20, 4, 2, 23, 21, 11, 30, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(14, 9, 2, 13, 28, 25, 13, 1, 1, 9, 29, 11, 0, 4, 14, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(10, 0, 7, 11, 6, 21, 6, 3, 6, 21, 29, 18, 27, 17, 13, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(17, 1, 19, 25, 3, 27, 12, 9, 30, 8, 2, 26, 21, 13, 3, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(31, 17, 18, 31, 3, 5, 7, 16, 23, 15, 22, 30, 5, 5, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(1, 21, 6, 16, 16, 5, 18, 26, 0, 21, 19, 26, 18, 15, 2, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(6, 11, 25, 19, 6, 17, 18, 16, 31, 12, 10, 5, 5, 23, 21, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(1, 15, 9, 14, 30, 26, 6, 5, 18, 17, 12, 4, 23, 3, 14, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(29, 30, 7, 5, 24, 15, 8, 29, 22, 27, 1, 13, 9, 7, 25, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(19, 19, 0, 13, 6, 24, 1, 30, 29, 15, 24, 14, 6, 27, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(9, 30, 17, 25, 4, 24, 27, 8, 24, 0, 1, 27, 31, 28, 28, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(0, 11, 27, 4, 27, 2, 9, 13, 13, 5, 30, 15, 10, 26, 26, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(24, 6, 14, 14, 7, 13, 11, 23, 9, 24, 30, 8, 12, 2, 28, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(23, 6, 19, 26, 21, 17, 31, 9, 6, 26, 22, 4, 21, 25, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(7, 10, 13, 26, 7, 15, 17, 7, 13, 29, 6, 26, 5, 0, 27, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(12, 16, 21, 25, 24, 13, 23, 24, 23, 4, 30, 7, 17, 10, 29, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(2, 1, 10, 30, 20, 21, 30, 28, 27, 26, 10, 20, 15, 2, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(26, 8, 24, 21, 13, 26, 13, 5, 4, 24, 29, 18, 6, 19, 18, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(7, 6, 3, 15, 23, 22, 15, 31, 31, 4, 18, 4, 29, 29, 21, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(5, 22, 2, 10, 24, 1, 29, 5, 23, 26, 15, 10, 6, 11, 14, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
