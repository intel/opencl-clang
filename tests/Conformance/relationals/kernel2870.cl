// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *secondSource, __global int16 *source,
                          __global int16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 , src2;
  int16 tmp;
  tmp = (int16)((int)0);
  {
    int16 src1 = source[0];
    int16 src2 = secondSource[0];
    uint16 mask =
        (uint16)(16, 21, 29, 30, 13, 6, 31, 15, 23, 7, 2, 21, 11, 28, 26, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint16 mask =
        (uint16)(14, 18, 31, 2, 7, 20, 30, 26, 20, 29, 28, 17, 7, 8, 22, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint16 mask =
        (uint16)(20, 19, 11, 17, 11, 17, 1, 29, 7, 15, 29, 28, 11, 8, 20, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint16 mask =
        (uint16)(12, 28, 19, 16, 29, 26, 19, 21, 25, 28, 1, 24, 9, 10, 31, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint16 mask =
        (uint16)(19, 23, 9, 19, 24, 17, 23, 12, 30, 26, 30, 7, 24, 7, 1, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint16 mask =
        (uint16)(0, 0, 27, 21, 25, 15, 31, 7, 17, 22, 3, 5, 1, 15, 17, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint16 mask =
        (uint16)(2, 12, 29, 27, 6, 12, 23, 2, 23, 24, 5, 2, 21, 1, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint16 mask =
        (uint16)(13, 12, 20, 25, 27, 18, 2, 11, 0, 25, 10, 3, 23, 6, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint16 mask =
        (uint16)(15, 16, 2, 10, 25, 28, 21, 6, 28, 21, 28, 9, 23, 11, 16, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint16 mask =
        (uint16)(31, 28, 30, 31, 13, 5, 2, 28, 16, 0, 18, 6, 31, 8, 25, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint16 mask =
        (uint16)(5, 13, 30, 10, 10, 3, 29, 9, 18, 20, 19, 2, 27, 5, 25, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint16 mask =
        (uint16)(24, 14, 23, 17, 17, 29, 0, 17, 19, 4, 25, 12, 3, 15, 27, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint16 mask =
        (uint16)(0, 6, 10, 2, 16, 8, 24, 11, 9, 12, 4, 30, 0, 11, 17, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint16 mask =
        (uint16)(2, 20, 16, 31, 29, 22, 8, 14, 18, 7, 0, 19, 26, 19, 28, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint16 mask =
        (uint16)(25, 14, 29, 5, 13, 8, 10, 5, 0, 31, 5, 7, 19, 3, 25, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint16 mask =
        (uint16)(23, 8, 8, 26, 7, 1, 6, 19, 15, 7, 29, 30, 7, 9, 8, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint16 mask =
        (uint16)(0, 4, 10, 14, 30, 9, 10, 30, 1, 15, 13, 1, 27, 16, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint16 mask =
        (uint16)(16, 3, 29, 8, 8, 31, 10, 26, 17, 8, 11, 25, 4, 14, 11, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint16 mask =
        (uint16)(8, 13, 18, 1, 8, 21, 18, 3, 0, 1, 21, 11, 6, 11, 12, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint16 mask =
        (uint16)(14, 7, 25, 1, 28, 5, 26, 24, 9, 1, 26, 15, 20, 27, 27, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint16 mask =
        (uint16)(5, 18, 31, 2, 4, 23, 20, 4, 0, 15, 29, 4, 7, 11, 26, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint16 mask =
        (uint16)(25, 15, 12, 11, 18, 1, 11, 30, 25, 8, 10, 26, 21, 25, 18, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint16 mask =
        (uint16)(22, 28, 1, 24, 25, 3, 6, 20, 20, 9, 8, 5, 0, 21, 23, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint16 mask =
        (uint16)(2, 21, 18, 22, 16, 30, 2, 6, 25, 13, 25, 6, 12, 25, 14, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint16 mask =
        (uint16)(2, 14, 13, 1, 14, 5, 22, 19, 29, 28, 26, 15, 10, 1, 24, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint16 mask =
        (uint16)(27, 18, 2, 28, 9, 15, 21, 28, 29, 18, 24, 20, 7, 26, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint16 mask =
        (uint16)(11, 7, 15, 8, 13, 6, 11, 15, 18, 31, 31, 20, 21, 8, 12, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint16 mask =
        (uint16)(22, 26, 18, 28, 29, 11, 27, 27, 6, 4, 14, 26, 12, 13, 14, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint16 mask =
        (uint16)(1, 28, 13, 18, 3, 27, 25, 4, 29, 3, 23, 9, 20, 24, 25, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint16 mask =
        (uint16)(15, 18, 11, 10, 3, 3, 25, 4, 26, 17, 13, 6, 9, 26, 10, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint16 mask =
        (uint16)(3, 23, 9, 4, 31, 24, 3, 7, 28, 14, 0, 26, 23, 6, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint16 mask =
        (uint16)(6, 2, 6, 31, 24, 0, 9, 15, 23, 6, 25, 8, 5, 28, 20, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
