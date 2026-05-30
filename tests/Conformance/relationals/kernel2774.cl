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
        (uchar16)(5, 21, 25, 5, 19, 18, 20, 12, 29, 11, 28, 14, 21, 29, 30, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(7, 9, 0, 5, 29, 19, 8, 11, 31, 11, 7, 14, 8, 7, 29, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 src2 = secondSource[2];
    uchar16 mask =
        (uchar16)(26, 29, 3, 2, 18, 16, 5, 5, 2, 31, 19, 23, 2, 30, 15, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 src2 = secondSource[3];
    uchar16 mask = (uchar16)(19, 20, 30, 30, 29, 13, 19, 12, 16, 4, 20, 25, 29,
                             29, 31, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(1, 9, 31, 17, 25, 10, 2, 5, 25, 21, 21, 23, 28, 20, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 src2 = secondSource[5];
    uchar16 mask =
        (uchar16)(16, 29, 26, 11, 15, 19, 16, 26, 7, 17, 10, 27, 9, 13, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(18, 19, 26, 10, 24, 6, 7, 9, 18, 11, 15, 13, 26, 10, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(1, 19, 28, 19, 21, 5, 5, 11, 6, 22, 12, 26, 15, 12, 10, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(16, 12, 28, 29, 20, 28, 11, 30, 27, 9, 22, 7, 18, 31, 16, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(2, 8, 18, 0, 12, 14, 17, 31, 3, 7, 25, 13, 16, 12, 26, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(6, 19, 30, 24, 18, 28, 2, 14, 10, 31, 31, 20, 19, 0, 13, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(29, 10, 11, 19, 23, 15, 4, 28, 22, 13, 15, 9, 13, 1, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(31, 28, 3, 17, 6, 14, 12, 24, 4, 22, 29, 27, 29, 28, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(15, 19, 1, 29, 26, 1, 24, 2, 12, 21, 15, 22, 21, 9, 14, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(8, 0, 9, 9, 16, 19, 31, 12, 15, 15, 1, 29, 30, 1, 9, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(1, 18, 2, 21, 5, 23, 20, 4, 11, 29, 29, 13, 25, 15, 10, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(31, 16, 21, 13, 0, 21, 14, 21, 29, 7, 9, 13, 29, 0, 19, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(18, 28, 11, 20, 30, 28, 13, 0, 20, 24, 20, 25, 20, 12, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(27, 29, 18, 17, 12, 14, 10, 10, 3, 20, 19, 25, 25, 29, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(29, 24, 4, 24, 15, 18, 20, 7, 18, 21, 28, 11, 21, 9, 26, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(21, 12, 11, 22, 8, 27, 11, 10, 13, 4, 26, 18, 22, 15, 26, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(29, 5, 26, 13, 30, 25, 30, 10, 10, 14, 12, 5, 18, 27, 22, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(14, 10, 25, 6, 20, 16, 19, 0, 4, 17, 5, 21, 10, 3, 30, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(2, 24, 30, 13, 15, 19, 13, 28, 27, 7, 26, 15, 4, 8, 25, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(16, 31, 10, 16, 3, 28, 18, 16, 24, 25, 28, 7, 31, 14, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(12, 1, 1, 26, 20, 1, 28, 7, 21, 20, 12, 2, 24, 12, 31, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(0, 18, 26, 16, 10, 4, 23, 10, 7, 22, 6, 5, 25, 16, 24, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(25, 6, 24, 14, 3, 0, 28, 2, 12, 15, 7, 27, 18, 0, 11, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(22, 9, 22, 29, 27, 29, 31, 7, 25, 2, 4, 14, 24, 6, 18, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(18, 19, 10, 10, 5, 16, 5, 11, 1, 27, 25, 23, 23, 24, 27, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(22, 3, 5, 3, 23, 17, 17, 25, 3, 28, 28, 10, 28, 14, 20, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(13, 3, 7, 18, 3, 25, 25, 16, 30, 20, 0, 23, 15, 26, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
