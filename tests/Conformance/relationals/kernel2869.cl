// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *secondSource, __global int16 *source,
                          __global int8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 , src2;
  int8 tmp;
  tmp = (int8)((int)0);
  {
    int16 src1 = source[0];
    int16 src2 = secondSource[0];
    uint8 mask = (uint8)(2, 2, 30, 7, 19, 26, 4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint8 mask = (uint8)(15, 5, 4, 17, 27, 26, 22, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint8 mask = (uint8)(29, 1, 30, 22, 4, 25, 24, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint8 mask = (uint8)(8, 28, 31, 17, 6, 23, 11, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint8 mask = (uint8)(9, 15, 22, 10, 10, 28, 7, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint8 mask = (uint8)(4, 7, 4, 23, 30, 26, 28, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint8 mask = (uint8)(21, 7, 28, 15, 31, 15, 11, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint8 mask = (uint8)(24, 6, 19, 24, 3, 18, 10, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint8 mask = (uint8)(0, 9, 30, 14, 11, 25, 21, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint8 mask = (uint8)(30, 4, 31, 20, 14, 5, 1, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint8 mask = (uint8)(30, 3, 1, 0, 25, 11, 0, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint8 mask = (uint8)(25, 20, 10, 19, 16, 16, 1, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint8 mask = (uint8)(2, 27, 7, 7, 16, 31, 27, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint8 mask = (uint8)(1, 22, 28, 2, 5, 2, 10, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint8 mask = (uint8)(22, 20, 29, 9, 7, 25, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint8 mask = (uint8)(8, 15, 21, 0, 25, 21, 18, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint8 mask = (uint8)(7, 0, 5, 5, 3, 27, 26, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint8 mask = (uint8)(2, 31, 29, 12, 10, 22, 19, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint8 mask = (uint8)(23, 31, 20, 7, 8, 16, 25, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint8 mask = (uint8)(8, 26, 7, 29, 11, 17, 20, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint8 mask = (uint8)(19, 2, 29, 13, 6, 2, 25, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint8 mask = (uint8)(3, 29, 18, 11, 30, 9, 31, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint8 mask = (uint8)(4, 4, 1, 23, 15, 17, 12, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint8 mask = (uint8)(18, 3, 31, 10, 5, 27, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint8 mask = (uint8)(19, 14, 21, 26, 11, 25, 20, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint8 mask = (uint8)(27, 29, 22, 23, 0, 30, 12, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint8 mask = (uint8)(0, 7, 4, 2, 18, 13, 17, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint8 mask = (uint8)(2, 4, 1, 19, 15, 21, 6, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint8 mask = (uint8)(28, 16, 3, 29, 4, 8, 2, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint8 mask = (uint8)(12, 31, 30, 23, 15, 3, 9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint8 mask = (uint8)(9, 6, 25, 20, 0, 31, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint8 mask = (uint8)(13, 29, 23, 2, 25, 2, 19, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
