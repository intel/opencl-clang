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
        (uint16)(28, 10, 18, 8, 3, 12, 23, 5, 22, 7, 20, 27, 8, 22, 21, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[1];
    uint16 src2 = secondSource[1];
    uint16 mask =
        (uint16)(5, 7, 23, 19, 18, 9, 0, 13, 17, 8, 8, 13, 17, 13, 19, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[2];
    uint16 src2 = secondSource[2];
    uint16 mask =
        (uint16)(20, 12, 2, 6, 7, 28, 25, 30, 2, 9, 27, 9, 23, 28, 2, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[3];
    uint16 src2 = secondSource[3];
    uint16 mask =
        (uint16)(15, 27, 6, 7, 5, 3, 15, 7, 7, 7, 30, 23, 10, 6, 4, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[4];
    uint16 src2 = secondSource[4];
    uint16 mask =
        (uint16)(8, 25, 7, 31, 25, 17, 6, 19, 5, 17, 16, 22, 15, 31, 9, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[5];
    uint16 src2 = secondSource[5];
    uint16 mask =
        (uint16)(4, 19, 28, 21, 11, 18, 18, 22, 6, 19, 8, 12, 15, 18, 12, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[6];
    uint16 src2 = secondSource[6];
    uint16 mask =
        (uint16)(12, 17, 17, 6, 22, 6, 0, 11, 2, 28, 11, 21, 8, 1, 28, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[7];
    uint16 src2 = secondSource[7];
    uint16 mask =
        (uint16)(28, 12, 31, 15, 11, 0, 26, 0, 20, 27, 13, 28, 0, 10, 10, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[8];
    uint16 src2 = secondSource[8];
    uint16 mask =
        (uint16)(13, 21, 2, 31, 3, 9, 4, 27, 0, 18, 11, 12, 17, 29, 19, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[9];
    uint16 src2 = secondSource[9];
    uint16 mask =
        (uint16)(8, 7, 25, 8, 24, 1, 22, 28, 21, 24, 9, 3, 3, 17, 5, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[10];
    uint16 src2 = secondSource[10];
    uint16 mask =
        (uint16)(1, 13, 9, 22, 1, 22, 17, 18, 14, 5, 3, 8, 2, 13, 25, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[11];
    uint16 src2 = secondSource[11];
    uint16 mask =
        (uint16)(11, 25, 28, 9, 0, 16, 10, 10, 13, 14, 29, 4, 1, 0, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[12];
    uint16 src2 = secondSource[12];
    uint16 mask =
        (uint16)(19, 10, 11, 25, 2, 31, 25, 26, 8, 18, 21, 15, 16, 23, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[13];
    uint16 src2 = secondSource[13];
    uint16 mask =
        (uint16)(9, 13, 8, 22, 16, 22, 24, 19, 18, 8, 17, 23, 30, 30, 13, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[14];
    uint16 src2 = secondSource[14];
    uint16 mask =
        (uint16)(29, 0, 7, 13, 4, 6, 24, 0, 5, 30, 15, 6, 0, 24, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[15];
    uint16 src2 = secondSource[15];
    uint16 mask =
        (uint16)(13, 7, 11, 24, 5, 28, 30, 26, 18, 8, 24, 7, 31, 9, 20, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[16];
    uint16 src2 = secondSource[16];
    uint16 mask =
        (uint16)(24, 6, 20, 18, 29, 18, 10, 7, 29, 20, 8, 21, 16, 25, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[17];
    uint16 src2 = secondSource[17];
    uint16 mask =
        (uint16)(25, 18, 4, 6, 26, 16, 17, 31, 30, 23, 14, 21, 9, 11, 29, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[18];
    uint16 src2 = secondSource[18];
    uint16 mask =
        (uint16)(18, 1, 4, 26, 17, 22, 8, 5, 23, 30, 17, 16, 3, 25, 14, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[19];
    uint16 src2 = secondSource[19];
    uint16 mask =
        (uint16)(22, 13, 4, 19, 19, 7, 0, 12, 16, 20, 0, 29, 11, 5, 11, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[20];
    uint16 src2 = secondSource[20];
    uint16 mask =
        (uint16)(14, 19, 28, 9, 5, 31, 18, 6, 9, 29, 29, 17, 1, 18, 5, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[21];
    uint16 src2 = secondSource[21];
    uint16 mask =
        (uint16)(23, 1, 26, 19, 20, 3, 31, 20, 15, 27, 10, 24, 1, 6, 20, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[22];
    uint16 src2 = secondSource[22];
    uint16 mask = (uint16)(17, 7, 7, 1, 24, 8, 4, 11, 6, 3, 6, 24, 18, 6, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[23];
    uint16 src2 = secondSource[23];
    uint16 mask =
        (uint16)(13, 20, 31, 8, 24, 31, 25, 17, 28, 21, 13, 13, 8, 1, 30, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[24];
    uint16 src2 = secondSource[24];
    uint16 mask =
        (uint16)(20, 16, 4, 28, 31, 17, 21, 23, 25, 14, 8, 11, 15, 11, 4, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[25];
    uint16 src2 = secondSource[25];
    uint16 mask =
        (uint16)(11, 0, 17, 23, 13, 18, 2, 25, 23, 4, 24, 7, 12, 23, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[26];
    uint16 src2 = secondSource[26];
    uint16 mask =
        (uint16)(21, 4, 18, 19, 20, 20, 12, 24, 19, 27, 12, 0, 17, 9, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[27];
    uint16 src2 = secondSource[27];
    uint16 mask =
        (uint16)(12, 23, 8, 13, 20, 27, 5, 29, 18, 15, 18, 20, 26, 15, 24, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[28];
    uint16 src2 = secondSource[28];
    uint16 mask =
        (uint16)(0, 10, 19, 15, 2, 30, 2, 12, 26, 14, 8, 23, 23, 28, 31, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[29];
    uint16 src2 = secondSource[29];
    uint16 mask =
        (uint16)(31, 18, 22, 15, 18, 12, 25, 6, 5, 23, 31, 15, 6, 31, 22, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[30];
    uint16 src2 = secondSource[30];
    uint16 mask =
        (uint16)(2, 18, 4, 4, 6, 24, 13, 14, 6, 0, 23, 4, 9, 28, 11, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[31];
    uint16 src2 = secondSource[31];
    uint16 mask =
        (uint16)(21, 7, 0, 18, 30, 8, 12, 10, 7, 6, 25, 12, 11, 14, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
