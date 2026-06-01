// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *secondSource,
                          __global uint16 *source, __global uint8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 , src2;
  uint8 tmp;
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[0];
    uint16 src2 = secondSource[0];
    uint8 mask = (uint8)(16, 19, 30, 29, 9, 23, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[1];
    uint16 src2 = secondSource[1];
    uint8 mask = (uint8)(9, 19, 20, 13, 27, 27, 4, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[2];
    uint16 src2 = secondSource[2];
    uint8 mask = (uint8)(9, 17, 31, 24, 28, 6, 4, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[3];
    uint16 src2 = secondSource[3];
    uint8 mask = (uint8)(6, 15, 11, 17, 4, 6, 29, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[4];
    uint16 src2 = secondSource[4];
    uint8 mask = (uint8)(15, 4, 0, 15, 1, 27, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[5];
    uint16 src2 = secondSource[5];
    uint8 mask = (uint8)(28, 15, 3, 24, 11, 1, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[6];
    uint16 src2 = secondSource[6];
    uint8 mask = (uint8)(26, 26, 29, 1, 26, 19, 14, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[7];
    uint16 src2 = secondSource[7];
    uint8 mask = (uint8)(7, 14, 6, 12, 20, 15, 15, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[8];
    uint16 src2 = secondSource[8];
    uint8 mask = (uint8)(17, 19, 27, 24, 30, 23, 28, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[9];
    uint16 src2 = secondSource[9];
    uint8 mask = (uint8)(7, 0, 13, 15, 18, 17, 15, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[10];
    uint16 src2 = secondSource[10];
    uint8 mask = (uint8)(8, 19, 7, 27, 8, 7, 18, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[11];
    uint16 src2 = secondSource[11];
    uint8 mask = (uint8)(17, 16, 23, 31, 7, 0, 29, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[12];
    uint16 src2 = secondSource[12];
    uint8 mask = (uint8)(6, 3, 21, 8, 19, 15, 3, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[13];
    uint16 src2 = secondSource[13];
    uint8 mask = (uint8)(6, 5, 26, 27, 29, 14, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[14];
    uint16 src2 = secondSource[14];
    uint8 mask = (uint8)(29, 19, 0, 24, 17, 26, 26, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[15];
    uint16 src2 = secondSource[15];
    uint8 mask = (uint8)(19, 18, 27, 7, 5, 20, 8, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[16];
    uint16 src2 = secondSource[16];
    uint8 mask = (uint8)(2, 4, 3, 1, 22, 16, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[17];
    uint16 src2 = secondSource[17];
    uint8 mask = (uint8)(23, 28, 23, 17, 1, 31, 3, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[18];
    uint16 src2 = secondSource[18];
    uint8 mask = (uint8)(9, 1, 2, 22, 26, 10, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[19];
    uint16 src2 = secondSource[19];
    uint8 mask = (uint8)(0, 16, 24, 0, 13, 9, 14, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[20];
    uint16 src2 = secondSource[20];
    uint8 mask = (uint8)(27, 20, 14, 20, 25, 9, 12, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[21];
    uint16 src2 = secondSource[21];
    uint8 mask = (uint8)(2, 22, 11, 15, 2, 10, 6, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[22];
    uint16 src2 = secondSource[22];
    uint8 mask = (uint8)(24, 24, 7, 9, 3, 26, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[23];
    uint16 src2 = secondSource[23];
    uint8 mask = (uint8)(18, 29, 8, 12, 24, 14, 31, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[24];
    uint16 src2 = secondSource[24];
    uint8 mask = (uint8)(20, 13, 21, 29, 5, 17, 26, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[25];
    uint16 src2 = secondSource[25];
    uint8 mask = (uint8)(1, 17, 29, 21, 10, 2, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[26];
    uint16 src2 = secondSource[26];
    uint8 mask = (uint8)(3, 7, 17, 14, 1, 12, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[27];
    uint16 src2 = secondSource[27];
    uint8 mask = (uint8)(26, 5, 24, 24, 3, 28, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[28];
    uint16 src2 = secondSource[28];
    uint8 mask = (uint8)(27, 8, 22, 5, 1, 25, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[29];
    uint16 src2 = secondSource[29];
    uint8 mask = (uint8)(29, 9, 21, 20, 24, 15, 17, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[30];
    uint16 src2 = secondSource[30];
    uint8 mask = (uint8)(3, 17, 15, 25, 16, 23, 14, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[31];
    uint16 src2 = secondSource[31];
    uint8 mask = (uint8)(31, 16, 9, 15, 8, 26, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
