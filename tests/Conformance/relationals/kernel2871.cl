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
        (uint16)(31, 18, 1, 23, 16, 20, 28, 24, 20, 9, 8, 29, 8, 11, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint16 mask =
        (uint16)(1, 6, 2, 15, 30, 22, 16, 4, 2, 6, 17, 18, 9, 10, 25, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint16 mask =
        (uint16)(0, 9, 12, 31, 20, 11, 13, 7, 22, 29, 18, 30, 17, 16, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint16 mask =
        (uint16)(11, 23, 24, 22, 2, 22, 25, 3, 7, 28, 12, 12, 14, 19, 6, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint16 mask =
        (uint16)(29, 28, 22, 16, 0, 18, 25, 29, 6, 1, 13, 12, 26, 29, 29, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint16 mask =
        (uint16)(29, 9, 19, 6, 10, 16, 26, 11, 16, 9, 29, 10, 17, 14, 6, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint16 mask =
        (uint16)(19, 8, 16, 9, 23, 4, 13, 0, 30, 16, 10, 27, 0, 0, 24, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint16 mask =
        (uint16)(14, 11, 23, 29, 6, 17, 10, 0, 3, 14, 14, 30, 1, 2, 20, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint16 mask =
        (uint16)(18, 1, 18, 23, 14, 15, 23, 15, 11, 11, 22, 7, 3, 11, 3, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint16 mask =
        (uint16)(12, 5, 11, 23, 31, 23, 27, 3, 6, 9, 30, 4, 21, 7, 19, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint16 mask =
        (uint16)(23, 19, 0, 0, 22, 31, 26, 17, 0, 9, 17, 21, 27, 5, 29, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint16 mask =
        (uint16)(5, 9, 6, 1, 7, 4, 25, 20, 23, 29, 15, 20, 20, 16, 1, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint16 mask =
        (uint16)(27, 1, 24, 7, 1, 25, 9, 28, 10, 29, 27, 26, 22, 17, 27, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint16 mask =
        (uint16)(4, 3, 19, 30, 9, 16, 9, 19, 30, 21, 15, 20, 0, 3, 0, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint16 mask =
        (uint16)(14, 12, 27, 0, 2, 30, 23, 20, 8, 16, 12, 4, 27, 2, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint16 mask =
        (uint16)(25, 3, 26, 12, 21, 12, 28, 28, 21, 22, 25, 2, 4, 24, 23, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint16 mask =
        (uint16)(20, 0, 0, 11, 31, 7, 11, 8, 2, 4, 5, 22, 8, 10, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint16 mask =
        (uint16)(22, 27, 24, 27, 31, 19, 5, 5, 9, 16, 28, 13, 24, 24, 29, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint16 mask = (uint16)(28, 23, 12, 17, 30, 23, 26, 18, 29, 24, 18, 23, 22,
                           17, 28, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint16 mask =
        (uint16)(17, 0, 4, 4, 25, 23, 16, 26, 0, 5, 31, 24, 4, 15, 30, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint16 mask =
        (uint16)(28, 27, 16, 14, 0, 8, 3, 23, 10, 17, 15, 12, 28, 1, 12, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint16 mask =
        (uint16)(25, 28, 0, 30, 16, 12, 3, 27, 28, 15, 18, 22, 6, 22, 17, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint16 mask =
        (uint16)(21, 4, 9, 3, 13, 27, 2, 30, 24, 16, 18, 6, 31, 15, 29, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint16 mask =
        (uint16)(22, 12, 21, 4, 15, 30, 7, 31, 15, 29, 4, 1, 27, 20, 24, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint16 mask =
        (uint16)(23, 12, 18, 8, 8, 26, 29, 12, 31, 4, 4, 18, 9, 11, 21, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint16 mask =
        (uint16)(22, 6, 15, 13, 10, 19, 23, 28, 14, 19, 20, 28, 21, 19, 17, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint16 mask =
        (uint16)(12, 1, 15, 5, 10, 27, 18, 6, 7, 30, 30, 21, 12, 27, 3, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint16 mask =
        (uint16)(22, 0, 0, 25, 2, 29, 16, 21, 16, 14, 8, 30, 31, 7, 2, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint16 mask =
        (uint16)(20, 8, 19, 30, 30, 22, 22, 24, 10, 18, 0, 2, 12, 2, 30, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint16 mask =
        (uint16)(21, 14, 9, 11, 0, 3, 0, 13, 24, 31, 23, 16, 6, 12, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint16 mask =
        (uint16)(4, 5, 29, 11, 23, 27, 23, 28, 28, 19, 31, 4, 20, 27, 18, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint16 mask =
        (uint16)(17, 11, 5, 27, 29, 30, 7, 25, 20, 31, 24, 1, 18, 9, 21, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
