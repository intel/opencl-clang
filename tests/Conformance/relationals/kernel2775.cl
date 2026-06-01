// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *secondSource,
                          __global uchar16 *source, __global uchar16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar16 src1 , src2;
  uchar16 tmp;
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[0];
    uchar16 src2 = secondSource[0];
    uchar16 mask =
        (uchar16)(13, 9, 18, 4, 13, 22, 0, 24, 31, 10, 29, 12, 24, 22, 12, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(22, 20, 22, 28, 10, 28, 1, 23, 19, 18, 30, 7, 23, 2, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 src2 = secondSource[2];
    uchar16 mask = (uchar16)(17, 27, 12, 20, 17, 14, 23, 23, 15, 21, 29, 25, 22,
                             29, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(19, 27, 14, 0, 25, 22, 0, 12, 18, 18, 0, 15, 31, 18, 16, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(8, 8, 3, 8, 10, 4, 20, 18, 31, 1, 3, 30, 6, 9, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 src2 = secondSource[5];
    uchar16 mask =
        (uchar16)(24, 13, 2, 22, 28, 2, 7, 6, 22, 21, 24, 27, 28, 11, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(23, 13, 11, 5, 12, 31, 16, 12, 4, 17, 11, 6, 30, 29, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(10, 18, 25, 28, 7, 5, 5, 5, 6, 2, 31, 29, 13, 12, 12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(24, 8, 2, 27, 5, 31, 23, 21, 10, 25, 22, 20, 0, 13, 18, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(17, 27, 4, 18, 3, 23, 29, 23, 16, 2, 1, 21, 4, 21, 21, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(15, 9, 19, 9, 14, 19, 29, 26, 26, 8, 31, 24, 30, 15, 23, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(1, 24, 31, 16, 15, 30, 1, 17, 31, 7, 18, 4, 14, 2, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(13, 20, 5, 9, 23, 8, 0, 25, 17, 31, 1, 16, 22, 30, 30, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(1, 17, 3, 28, 16, 16, 31, 16, 13, 18, 19, 12, 24, 16, 29, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(5, 23, 29, 0, 20, 6, 25, 30, 9, 14, 16, 18, 6, 23, 27, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(6, 31, 17, 13, 13, 0, 1, 25, 13, 2, 25, 15, 16, 7, 9, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(14, 6, 24, 21, 21, 18, 3, 2, 16, 23, 6, 17, 31, 2, 23, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(2, 21, 7, 6, 2, 21, 11, 8, 26, 24, 2, 0, 5, 19, 8, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(19, 5, 31, 28, 26, 19, 6, 19, 22, 20, 17, 31, 15, 2, 29, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(18, 19, 4, 25, 5, 1, 29, 28, 2, 4, 4, 17, 20, 24, 7, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(26, 24, 13, 9, 15, 27, 4, 8, 0, 22, 24, 3, 2, 29, 20, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(17, 4, 16, 4, 9, 25, 24, 25, 12, 21, 4, 31, 1, 31, 10, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(19, 26, 7, 24, 23, 2, 3, 20, 15, 13, 17, 15, 26, 7, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(0, 28, 17, 29, 4, 23, 18, 23, 1, 26, 15, 9, 12, 26, 4, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(14, 25, 15, 27, 2, 28, 21, 0, 29, 14, 19, 30, 20, 18, 23, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(29, 10, 31, 2, 15, 18, 30, 13, 11, 0, 23, 3, 29, 14, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(29, 15, 28, 9, 6, 18, 13, 15, 3, 7, 23, 20, 24, 24, 28, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(14, 5, 20, 22, 26, 12, 2, 18, 3, 16, 26, 5, 14, 19, 25, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(0, 25, 3, 16, 11, 2, 12, 31, 26, 14, 16, 22, 29, 4, 13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(2, 5, 14, 4, 13, 4, 17, 31, 20, 11, 1, 6, 19, 13, 4, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(13, 14, 28, 14, 4, 23, 6, 21, 13, 10, 1, 5, 9, 22, 2, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(15, 31, 18, 23, 23, 12, 29, 31, 14, 4, 20, 10, 1, 16, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
