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
        (ulong16)(6, 0, 27, 5, 14, 2, 4, 24, 3, 19, 16, 22, 20, 30, 26, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(18, 12, 1, 19, 30, 5, 17, 31, 7, 22, 12, 3, 11, 22, 17, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(26, 5, 30, 28, 4, 26, 14, 31, 11, 12, 9, 0, 22, 3, 15, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(21, 27, 31, 17, 14, 20, 30, 25, 5, 16, 25, 25, 1, 17, 6, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(10, 18, 5, 10, 15, 6, 10, 20, 19, 20, 8, 25, 3, 18, 6, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(15, 28, 2, 29, 11, 26, 16, 29, 21, 11, 23, 18, 22, 4, 31, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(3, 30, 20, 17, 5, 26, 27, 27, 15, 19, 19, 0, 30, 26, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(18, 0, 7, 21, 15, 11, 6, 14, 10, 0, 31, 29, 8, 28, 0, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(20, 14, 22, 4, 0, 28, 17, 22, 8, 12, 13, 19, 21, 8, 27, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(10, 20, 29, 8, 14, 19, 24, 5, 1, 7, 25, 9, 27, 4, 9, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(5, 30, 26, 12, 1, 11, 0, 21, 30, 4, 17, 7, 25, 24, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(19, 12, 12, 10, 5, 1, 17, 16, 6, 18, 0, 13, 29, 27, 3, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(15, 3, 31, 25, 1, 19, 19, 14, 1, 5, 17, 14, 9, 1, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(14, 23, 22, 27, 18, 17, 19, 18, 9, 23, 24, 2, 1, 3, 28, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(29, 15, 0, 0, 7, 24, 11, 1, 10, 20, 15, 26, 28, 14, 28, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(31, 27, 4, 14, 0, 10, 28, 9, 25, 31, 18, 10, 3, 28, 12, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(2, 4, 22, 3, 18, 28, 26, 13, 21, 0, 6, 2, 25, 17, 28, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(8, 0, 3, 20, 21, 4, 22, 8, 1, 6, 12, 16, 17, 10, 27, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(10, 15, 21, 28, 16, 13, 20, 13, 1, 25, 10, 10, 10, 7, 0, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(14, 25, 7, 14, 19, 28, 6, 24, 29, 4, 4, 20, 15, 13, 6, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(8, 22, 30, 30, 28, 26, 5, 7, 13, 29, 10, 13, 4, 2, 2, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(7, 15, 15, 12, 18, 1, 6, 0, 3, 19, 7, 18, 12, 13, 14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(13, 5, 6, 8, 17, 19, 10, 1, 2, 25, 20, 16, 18, 25, 27, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(3, 20, 17, 17, 31, 24, 1, 9, 12, 10, 23, 7, 29, 11, 18, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(3, 14, 13, 26, 6, 17, 23, 4, 4, 11, 10, 2, 18, 9, 31, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(17, 15, 6, 6, 17, 18, 25, 19, 6, 12, 7, 16, 3, 26, 25, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(19, 2, 27, 24, 29, 25, 2, 3, 3, 0, 20, 21, 12, 18, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(12, 8, 13, 12, 28, 14, 5, 7, 0, 2, 13, 5, 1, 19, 18, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(18, 19, 17, 7, 3, 29, 18, 21, 6, 17, 7, 22, 22, 8, 30, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(26, 13, 22, 28, 27, 26, 28, 21, 14, 28, 17, 28, 21, 0, 28, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(3, 26, 12, 26, 1, 11, 7, 9, 28, 24, 29, 14, 15, 29, 14, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(28, 29, 6, 29, 9, 16, 14, 20, 6, 14, 1, 22, 11, 12, 22, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
