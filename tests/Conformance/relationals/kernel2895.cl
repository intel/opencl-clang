// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint8 *secondSource, __global uint8 *source,
                          __global uint16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint8 src1 , src2;
  uint16 tmp;
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[0];
    uint8 src2 = secondSource[0];
    uint16 mask =
        (uint16)(12, 9, 2, 15, 2, 6, 12, 3, 9, 12, 11, 8, 3, 2, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[1];
    uint8 src2 = secondSource[1];
    uint16 mask = (uint16)(8, 12, 12, 1, 1, 3, 13, 11, 5, 7, 9, 14, 5, 0, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[2];
    uint8 src2 = secondSource[2];
    uint16 mask = (uint16)(1, 11, 4, 1, 7, 4, 5, 15, 5, 0, 12, 6, 0, 7, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[3];
    uint8 src2 = secondSource[3];
    uint16 mask = (uint16)(7, 2, 10, 13, 9, 11, 3, 13, 2, 6, 0, 4, 3, 8, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[4];
    uint8 src2 = secondSource[4];
    uint16 mask =
        (uint16)(14, 1, 6, 8, 8, 5, 5, 3, 11, 7, 14, 12, 8, 13, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[5];
    uint8 src2 = secondSource[5];
    uint16 mask =
        (uint16)(1, 14, 11, 15, 1, 2, 14, 14, 4, 15, 15, 5, 9, 6, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[6];
    uint8 src2 = secondSource[6];
    uint16 mask = (uint16)(14, 14, 2, 8, 2, 2, 7, 1, 3, 4, 8, 4, 7, 10, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[7];
    uint8 src2 = secondSource[7];
    uint16 mask = (uint16)(1, 13, 1, 2, 5, 11, 11, 9, 15, 10, 2, 8, 2, 8, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[8];
    uint8 src2 = secondSource[8];
    uint16 mask =
        (uint16)(0, 12, 4, 0, 12, 2, 14, 8, 15, 2, 14, 1, 1, 14, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[9];
    uint8 src2 = secondSource[9];
    uint16 mask = (uint16)(3, 4, 3, 9, 11, 5, 15, 5, 15, 7, 0, 7, 3, 2, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[10];
    uint8 src2 = secondSource[10];
    uint16 mask = (uint16)(14, 13, 6, 10, 12, 0, 9, 8, 4, 1, 1, 2, 2, 8, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[11];
    uint8 src2 = secondSource[11];
    uint16 mask =
        (uint16)(1, 13, 14, 5, 9, 3, 4, 11, 6, 11, 13, 3, 10, 2, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[12];
    uint8 src2 = secondSource[12];
    uint16 mask =
        (uint16)(11, 13, 11, 12, 1, 12, 6, 1, 7, 9, 3, 14, 8, 10, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[13];
    uint8 src2 = secondSource[13];
    uint16 mask = (uint16)(9, 2, 6, 6, 9, 10, 2, 3, 6, 12, 4, 11, 15, 7, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[14];
    uint8 src2 = secondSource[14];
    uint16 mask =
        (uint16)(0, 4, 2, 10, 9, 5, 13, 12, 10, 0, 14, 11, 9, 8, 6, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[15];
    uint8 src2 = secondSource[15];
    uint16 mask =
        (uint16)(10, 11, 13, 3, 14, 8, 1, 9, 12, 1, 13, 4, 0, 8, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[16];
    uint8 src2 = secondSource[16];
    uint16 mask =
        (uint16)(11, 13, 3, 11, 6, 7, 5, 15, 7, 6, 15, 12, 5, 10, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[17];
    uint8 src2 = secondSource[17];
    uint16 mask = (uint16)(12, 6, 4, 8, 13, 8, 14, 2, 9, 2, 0, 6, 1, 1, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[18];
    uint8 src2 = secondSource[18];
    uint16 mask =
        (uint16)(8, 15, 5, 15, 4, 12, 2, 13, 13, 7, 6, 3, 3, 15, 5, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[19];
    uint8 src2 = secondSource[19];
    uint16 mask = (uint16)(14, 0, 8, 5, 13, 0, 9, 9, 7, 12, 3, 9, 5, 4, 7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[20];
    uint8 src2 = secondSource[20];
    uint16 mask = (uint16)(10, 14, 9, 2, 0, 5, 1, 11, 6, 12, 5, 2, 9, 13, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[21];
    uint8 src2 = secondSource[21];
    uint16 mask =
        (uint16)(12, 6, 15, 1, 0, 2, 10, 7, 10, 0, 13, 11, 1, 15, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[22];
    uint8 src2 = secondSource[22];
    uint16 mask =
        (uint16)(15, 1, 4, 3, 5, 0, 13, 11, 11, 11, 3, 5, 8, 13, 0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[23];
    uint8 src2 = secondSource[23];
    uint16 mask =
        (uint16)(6, 0, 4, 6, 14, 12, 0, 14, 13, 11, 15, 2, 9, 14, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[24];
    uint8 src2 = secondSource[24];
    uint16 mask =
        (uint16)(3, 6, 5, 13, 4, 3, 15, 10, 14, 13, 9, 6, 11, 11, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[25];
    uint8 src2 = secondSource[25];
    uint16 mask = (uint16)(9, 15, 0, 7, 2, 8, 5, 8, 0, 11, 7, 15, 0, 7, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[26];
    uint8 src2 = secondSource[26];
    uint16 mask =
        (uint16)(13, 8, 3, 4, 6, 14, 8, 4, 9, 10, 14, 2, 7, 12, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[27];
    uint8 src2 = secondSource[27];
    uint16 mask = (uint16)(2, 0, 7, 6, 6, 9, 5, 4, 9, 7, 6, 4, 6, 0, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[28];
    uint8 src2 = secondSource[28];
    uint16 mask = (uint16)(15, 13, 0, 1, 3, 5, 11, 10, 4, 3, 8, 0, 4, 15, 6, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[29];
    uint8 src2 = secondSource[29];
    uint16 mask = (uint16)(5, 5, 8, 11, 5, 7, 9, 1, 10, 4, 9, 14, 15, 0, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[30];
    uint8 src2 = secondSource[30];
    uint16 mask =
        (uint16)(5, 11, 5, 10, 13, 10, 4, 15, 5, 7, 11, 10, 3, 9, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[31];
    uint8 src2 = secondSource[31];
    uint16 mask =
        (uint16)(13, 14, 9, 5, 10, 2, 3, 13, 0, 3, 0, 10, 4, 2, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
