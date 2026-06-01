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
    uint8 mask = (uint8)(19, 0, 8, 18, 1, 13, 25, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint8 mask = (uint8)(27, 21, 5, 14, 6, 20, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint8 mask = (uint8)(24, 31, 12, 12, 19, 29, 16, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint8 mask = (uint8)(22, 22, 26, 7, 28, 20, 2, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint8 mask = (uint8)(27, 11, 24, 30, 28, 15, 29, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint8 mask = (uint8)(31, 3, 2, 11, 11, 14, 22, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint8 mask = (uint8)(8, 17, 29, 3, 9, 0, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint8 mask = (uint8)(29, 30, 9, 25, 9, 21, 10, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint8 mask = (uint8)(31, 7, 4, 17, 15, 18, 10, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint8 mask = (uint8)(4, 11, 12, 15, 20, 23, 14, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint8 mask = (uint8)(9, 0, 28, 18, 9, 23, 0, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint8 mask = (uint8)(17, 29, 2, 23, 26, 16, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint8 mask = (uint8)(2, 13, 15, 27, 13, 31, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint8 mask = (uint8)(21, 3, 28, 23, 21, 30, 7, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint8 mask = (uint8)(5, 15, 6, 17, 16, 10, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint8 mask = (uint8)(4, 6, 14, 12, 0, 20, 19, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint8 mask = (uint8)(14, 28, 31, 26, 5, 26, 14, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint8 mask = (uint8)(0, 1, 5, 28, 30, 19, 31, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint8 mask = (uint8)(0, 26, 25, 23, 13, 22, 25, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint8 mask = (uint8)(15, 16, 29, 13, 5, 18, 7, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint8 mask = (uint8)(8, 0, 29, 4, 10, 7, 30, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint8 mask = (uint8)(20, 19, 27, 17, 27, 27, 4, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint8 mask = (uint8)(7, 11, 30, 23, 3, 26, 23, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint8 mask = (uint8)(28, 30, 16, 19, 11, 30, 12, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint8 mask = (uint8)(7, 9, 30, 28, 13, 7, 1, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint8 mask = (uint8)(4, 20, 4, 29, 7, 28, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint8 mask = (uint8)(11, 0, 7, 2, 24, 15, 28, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint8 mask = (uint8)(6, 20, 21, 8, 18, 6, 19, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint8 mask = (uint8)(1, 26, 6, 8, 9, 12, 2, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint8 mask = (uint8)(30, 17, 24, 3, 4, 22, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint8 mask = (uint8)(25, 4, 16, 0, 2, 16, 8, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint8 mask = (uint8)(4, 10, 16, 3, 16, 4, 31, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
