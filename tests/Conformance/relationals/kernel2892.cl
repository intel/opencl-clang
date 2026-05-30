// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint8 *secondSource, __global uint8 *source,
                          __global uint8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint8 src1 , src2;
  uint8 tmp;
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[0];
    uint8 src2 = secondSource[0];
    uint8 mask = (uint8)(15, 5, 14, 6, 14, 12, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[1];
    uint8 src2 = secondSource[1];
    uint8 mask = (uint8)(7, 7, 3, 12, 0, 5, 15, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[2];
    uint8 src2 = secondSource[2];
    uint8 mask = (uint8)(8, 15, 13, 5, 12, 9, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[3];
    uint8 src2 = secondSource[3];
    uint8 mask = (uint8)(6, 8, 13, 5, 9, 8, 0, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[4];
    uint8 src2 = secondSource[4];
    uint8 mask = (uint8)(6, 4, 14, 11, 6, 11, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[5];
    uint8 src2 = secondSource[5];
    uint8 mask = (uint8)(11, 5, 7, 13, 1, 3, 11, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[6];
    uint8 src2 = secondSource[6];
    uint8 mask = (uint8)(4, 9, 2, 2, 15, 15, 8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[7];
    uint8 src2 = secondSource[7];
    uint8 mask = (uint8)(9, 11, 8, 10, 11, 13, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[8];
    uint8 src2 = secondSource[8];
    uint8 mask = (uint8)(12, 6, 8, 6, 8, 4, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[9];
    uint8 src2 = secondSource[9];
    uint8 mask = (uint8)(14, 6, 11, 0, 11, 15, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[10];
    uint8 src2 = secondSource[10];
    uint8 mask = (uint8)(15, 5, 14, 2, 14, 14, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[11];
    uint8 src2 = secondSource[11];
    uint8 mask = (uint8)(15, 7, 4, 14, 4, 5, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[12];
    uint8 src2 = secondSource[12];
    uint8 mask = (uint8)(4, 4, 11, 15, 13, 9, 4, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[13];
    uint8 src2 = secondSource[13];
    uint8 mask = (uint8)(9, 10, 13, 13, 14, 1, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[14];
    uint8 src2 = secondSource[14];
    uint8 mask = (uint8)(3, 6, 15, 7, 14, 5, 8, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[15];
    uint8 src2 = secondSource[15];
    uint8 mask = (uint8)(6, 13, 4, 14, 7, 2, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[16];
    uint8 src2 = secondSource[16];
    uint8 mask = (uint8)(0, 5, 2, 10, 1, 15, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[17];
    uint8 src2 = secondSource[17];
    uint8 mask = (uint8)(14, 6, 3, 8, 13, 3, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[18];
    uint8 src2 = secondSource[18];
    uint8 mask = (uint8)(3, 3, 7, 6, 14, 2, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[19];
    uint8 src2 = secondSource[19];
    uint8 mask = (uint8)(13, 9, 8, 8, 0, 14, 15, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[20];
    uint8 src2 = secondSource[20];
    uint8 mask = (uint8)(6, 4, 1, 12, 14, 3, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[21];
    uint8 src2 = secondSource[21];
    uint8 mask = (uint8)(8, 15, 9, 0, 0, 6, 10, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[22];
    uint8 src2 = secondSource[22];
    uint8 mask = (uint8)(13, 6, 4, 6, 9, 1, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[23];
    uint8 src2 = secondSource[23];
    uint8 mask = (uint8)(13, 0, 2, 7, 3, 7, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[24];
    uint8 src2 = secondSource[24];
    uint8 mask = (uint8)(8, 0, 2, 1, 3, 10, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[25];
    uint8 src2 = secondSource[25];
    uint8 mask = (uint8)(12, 10, 9, 0, 6, 8, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[26];
    uint8 src2 = secondSource[26];
    uint8 mask = (uint8)(14, 9, 10, 10, 12, 1, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[27];
    uint8 src2 = secondSource[27];
    uint8 mask = (uint8)(15, 14, 0, 14, 14, 10, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[28];
    uint8 src2 = secondSource[28];
    uint8 mask = (uint8)(3, 12, 8, 0, 3, 9, 6, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[29];
    uint8 src2 = secondSource[29];
    uint8 mask = (uint8)(3, 11, 15, 2, 13, 0, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[30];
    uint8 src2 = secondSource[30];
    uint8 mask = (uint8)(4, 2, 12, 4, 12, 13, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint8 src1 = source[31];
    uint8 src2 = secondSource[31];
    uint8 mask = (uint8)(11, 8, 6, 12, 12, 12, 15, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
