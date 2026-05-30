// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int8 *secondSource, __global int8 *source,
                          __global int8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int8 src1 , src2;
  int8 tmp;
  tmp = (int8)((int)0);
  {
    int8 src1 = source[0];
    int8 src2 = secondSource[0];
    uint8 mask = (uint8)(14, 13, 2, 4, 6, 8, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[1];
    int8 src2 = secondSource[1];
    uint8 mask = (uint8)(3, 15, 12, 9, 6, 11, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[2];
    int8 src2 = secondSource[2];
    uint8 mask = (uint8)(4, 13, 7, 12, 1, 2, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[3];
    int8 src2 = secondSource[3];
    uint8 mask = (uint8)(3, 3, 3, 12, 3, 1, 12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[4];
    int8 src2 = secondSource[4];
    uint8 mask = (uint8)(7, 6, 2, 1, 7, 1, 14, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[5];
    int8 src2 = secondSource[5];
    uint8 mask = (uint8)(14, 11, 2, 6, 7, 10, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[6];
    int8 src2 = secondSource[6];
    uint8 mask = (uint8)(12, 12, 8, 8, 1, 0, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[7];
    int8 src2 = secondSource[7];
    uint8 mask = (uint8)(14, 15, 8, 8, 5, 1, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[8];
    int8 src2 = secondSource[8];
    uint8 mask = (uint8)(11, 2, 1, 11, 1, 11, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[9];
    int8 src2 = secondSource[9];
    uint8 mask = (uint8)(7, 15, 3, 6, 8, 11, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[10];
    int8 src2 = secondSource[10];
    uint8 mask = (uint8)(9, 9, 9, 6, 15, 3, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[11];
    int8 src2 = secondSource[11];
    uint8 mask = (uint8)(11, 0, 0, 9, 2, 0, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[12];
    int8 src2 = secondSource[12];
    uint8 mask = (uint8)(13, 9, 13, 5, 12, 14, 12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[13];
    int8 src2 = secondSource[13];
    uint8 mask = (uint8)(0, 14, 2, 14, 6, 8, 11, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[14];
    int8 src2 = secondSource[14];
    uint8 mask = (uint8)(13, 6, 11, 0, 2, 3, 15, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[15];
    int8 src2 = secondSource[15];
    uint8 mask = (uint8)(3, 12, 10, 1, 0, 12, 6, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[16];
    int8 src2 = secondSource[16];
    uint8 mask = (uint8)(11, 13, 1, 4, 14, 8, 4, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[17];
    int8 src2 = secondSource[17];
    uint8 mask = (uint8)(3, 2, 1, 15, 9, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[18];
    int8 src2 = secondSource[18];
    uint8 mask = (uint8)(13, 0, 11, 0, 1, 9, 15, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[19];
    int8 src2 = secondSource[19];
    uint8 mask = (uint8)(14, 6, 15, 13, 1, 9, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[20];
    int8 src2 = secondSource[20];
    uint8 mask = (uint8)(7, 1, 9, 4, 2, 9, 15, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[21];
    int8 src2 = secondSource[21];
    uint8 mask = (uint8)(15, 8, 3, 13, 7, 12, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[22];
    int8 src2 = secondSource[22];
    uint8 mask = (uint8)(8, 15, 7, 15, 7, 9, 13, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[23];
    int8 src2 = secondSource[23];
    uint8 mask = (uint8)(15, 10, 1, 7, 0, 15, 10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[24];
    int8 src2 = secondSource[24];
    uint8 mask = (uint8)(2, 10, 0, 13, 11, 11, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[25];
    int8 src2 = secondSource[25];
    uint8 mask = (uint8)(9, 14, 7, 9, 0, 11, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[26];
    int8 src2 = secondSource[26];
    uint8 mask = (uint8)(10, 14, 14, 11, 7, 13, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[27];
    int8 src2 = secondSource[27];
    uint8 mask = (uint8)(0, 1, 10, 2, 13, 2, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[28];
    int8 src2 = secondSource[28];
    uint8 mask = (uint8)(9, 12, 10, 7, 0, 11, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[29];
    int8 src2 = secondSource[29];
    uint8 mask = (uint8)(11, 12, 15, 4, 4, 3, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[30];
    int8 src2 = secondSource[30];
    uint8 mask = (uint8)(7, 9, 1, 5, 7, 5, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int8 src1 = source[31];
    int8 src2 = secondSource[31];
    uint8 mask = (uint8)(10, 1, 0, 12, 11, 6, 12, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
