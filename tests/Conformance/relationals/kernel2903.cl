// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *secondSource,
                          __global uint16 *source, __global uint16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 , src2;
  uint16 tmp;
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[0];
    uint16 src2 = secondSource[0];
    uint16 mask =
        (uint16)(9, 28, 3, 12, 22, 12, 19, 30, 31, 29, 20, 29, 1, 30, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[1];
    uint16 src2 = secondSource[1];
    uint16 mask =
        (uint16)(0, 24, 10, 30, 16, 10, 30, 18, 0, 27, 30, 18, 29, 24, 21, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[2];
    uint16 src2 = secondSource[2];
    uint16 mask =
        (uint16)(3, 14, 30, 16, 18, 2, 0, 18, 26, 10, 7, 11, 8, 11, 19, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[3];
    uint16 src2 = secondSource[3];
    uint16 mask =
        (uint16)(3, 10, 29, 22, 21, 3, 10, 1, 23, 15, 27, 13, 26, 30, 18, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[4];
    uint16 src2 = secondSource[4];
    uint16 mask =
        (uint16)(25, 27, 5, 24, 20, 2, 11, 20, 9, 19, 4, 18, 1, 2, 0, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[5];
    uint16 src2 = secondSource[5];
    uint16 mask =
        (uint16)(28, 23, 21, 18, 21, 4, 19, 8, 12, 27, 11, 14, 8, 6, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[6];
    uint16 src2 = secondSource[6];
    uint16 mask =
        (uint16)(22, 2, 15, 28, 24, 9, 2, 14, 15, 31, 12, 13, 0, 18, 5, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[7];
    uint16 src2 = secondSource[7];
    uint16 mask =
        (uint16)(2, 6, 11, 28, 22, 25, 20, 23, 19, 10, 15, 18, 2, 21, 17, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[8];
    uint16 src2 = secondSource[8];
    uint16 mask =
        (uint16)(6, 30, 27, 5, 6, 17, 26, 22, 17, 18, 12, 20, 8, 29, 16, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[9];
    uint16 src2 = secondSource[9];
    uint16 mask =
        (uint16)(18, 24, 4, 4, 31, 6, 5, 10, 22, 17, 31, 20, 31, 3, 24, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[10];
    uint16 src2 = secondSource[10];
    uint16 mask =
        (uint16)(29, 27, 24, 27, 20, 19, 6, 31, 2, 21, 1, 7, 13, 16, 18, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[11];
    uint16 src2 = secondSource[11];
    uint16 mask =
        (uint16)(13, 27, 23, 6, 16, 6, 9, 30, 30, 9, 12, 26, 3, 3, 25, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[12];
    uint16 src2 = secondSource[12];
    uint16 mask =
        (uint16)(6, 11, 3, 22, 20, 11, 24, 6, 1, 11, 21, 31, 23, 28, 20, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[13];
    uint16 src2 = secondSource[13];
    uint16 mask =
        (uint16)(27, 4, 1, 28, 30, 20, 20, 19, 15, 15, 2, 24, 1, 14, 28, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[14];
    uint16 src2 = secondSource[14];
    uint16 mask =
        (uint16)(17, 1, 4, 29, 8, 28, 17, 11, 25, 6, 12, 26, 29, 23, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[15];
    uint16 src2 = secondSource[15];
    uint16 mask =
        (uint16)(25, 28, 6, 12, 11, 27, 28, 13, 18, 4, 3, 12, 7, 14, 0, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[16];
    uint16 src2 = secondSource[16];
    uint16 mask =
        (uint16)(10, 30, 16, 11, 18, 14, 30, 28, 27, 12, 27, 9, 24, 30, 16, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[17];
    uint16 src2 = secondSource[17];
    uint16 mask =
        (uint16)(21, 29, 19, 19, 16, 4, 23, 18, 30, 31, 14, 0, 10, 21, 31, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[18];
    uint16 src2 = secondSource[18];
    uint16 mask =
        (uint16)(25, 21, 31, 3, 12, 6, 31, 10, 18, 8, 13, 19, 12, 14, 11, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[19];
    uint16 src2 = secondSource[19];
    uint16 mask =
        (uint16)(13, 24, 15, 3, 29, 0, 19, 21, 19, 30, 16, 23, 2, 6, 9, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[20];
    uint16 src2 = secondSource[20];
    uint16 mask =
        (uint16)(29, 4, 9, 27, 6, 14, 0, 10, 18, 17, 1, 16, 25, 6, 17, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[21];
    uint16 src2 = secondSource[21];
    uint16 mask =
        (uint16)(12, 26, 25, 30, 24, 20, 12, 25, 13, 20, 7, 29, 1, 8, 7, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[22];
    uint16 src2 = secondSource[22];
    uint16 mask =
        (uint16)(9, 24, 22, 20, 28, 13, 8, 6, 29, 18, 7, 30, 10, 26, 28, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[23];
    uint16 src2 = secondSource[23];
    uint16 mask =
        (uint16)(8, 5, 5, 18, 29, 18, 19, 21, 16, 25, 24, 11, 1, 13, 2, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[24];
    uint16 src2 = secondSource[24];
    uint16 mask =
        (uint16)(11, 28, 14, 7, 0, 23, 25, 21, 5, 25, 12, 22, 19, 22, 26, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[25];
    uint16 src2 = secondSource[25];
    uint16 mask =
        (uint16)(16, 2, 12, 28, 23, 11, 14, 7, 30, 0, 24, 10, 12, 4, 14, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[26];
    uint16 src2 = secondSource[26];
    uint16 mask =
        (uint16)(26, 11, 13, 16, 22, 10, 13, 25, 22, 3, 13, 8, 8, 14, 7, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[27];
    uint16 src2 = secondSource[27];
    uint16 mask =
        (uint16)(9, 30, 3, 26, 12, 25, 10, 31, 1, 15, 7, 31, 4, 23, 16, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[28];
    uint16 src2 = secondSource[28];
    uint16 mask =
        (uint16)(21, 21, 20, 7, 24, 16, 3, 1, 31, 23, 3, 29, 31, 9, 3, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[29];
    uint16 src2 = secondSource[29];
    uint16 mask =
        (uint16)(19, 1, 24, 28, 27, 8, 15, 16, 13, 5, 21, 20, 8, 29, 25, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[30];
    uint16 src2 = secondSource[30];
    uint16 mask =
        (uint16)(14, 16, 21, 9, 21, 28, 26, 31, 23, 19, 1, 12, 10, 23, 29, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[31];
    uint16 src2 = secondSource[31];
    uint16 mask =
        (uint16)(6, 2, 25, 5, 14, 6, 6, 28, 0, 7, 16, 11, 4, 8, 26, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
