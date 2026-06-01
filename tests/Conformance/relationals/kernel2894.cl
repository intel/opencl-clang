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
        (uint16)(4, 13, 4, 12, 15, 2, 12, 1, 14, 14, 3, 11, 6, 4, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[1];
    uint8 src2 = secondSource[1];
    uint16 mask =
        (uint16)(15, 3, 9, 11, 8, 14, 12, 0, 6, 13, 12, 13, 12, 0, 9, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[2];
    uint8 src2 = secondSource[2];
    uint16 mask = (uint16)(2, 1, 3, 0, 4, 10, 14, 3, 3, 2, 13, 12, 1, 0, 5, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[3];
    uint8 src2 = secondSource[3];
    uint16 mask = (uint16)(7, 5, 4, 4, 0, 2, 5, 10, 9, 13, 9, 8, 7, 6, 15, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[4];
    uint8 src2 = secondSource[4];
    uint16 mask =
        (uint16)(15, 11, 13, 13, 6, 13, 14, 0, 3, 4, 9, 3, 12, 1, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[5];
    uint8 src2 = secondSource[5];
    uint16 mask = (uint16)(5, 3, 6, 10, 10, 7, 1, 1, 5, 5, 13, 9, 15, 5, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[6];
    uint8 src2 = secondSource[6];
    uint16 mask =
        (uint16)(2, 4, 3, 2, 12, 6, 11, 10, 7, 13, 13, 10, 6, 13, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[7];
    uint8 src2 = secondSource[7];
    uint16 mask = (uint16)(0, 2, 5, 11, 11, 4, 9, 8, 15, 8, 14, 1, 3, 9, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[8];
    uint8 src2 = secondSource[8];
    uint16 mask =
        (uint16)(12, 2, 9, 13, 5, 11, 2, 10, 10, 0, 8, 13, 11, 1, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[9];
    uint8 src2 = secondSource[9];
    uint16 mask = (uint16)(13, 0, 7, 15, 3, 6, 8, 13, 9, 6, 1, 1, 4, 1, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[10];
    uint8 src2 = secondSource[10];
    uint16 mask = (uint16)(5, 9, 9, 4, 6, 8, 6, 13, 0, 8, 14, 3, 9, 9, 7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[11];
    uint8 src2 = secondSource[11];
    uint16 mask =
        (uint16)(7, 13, 12, 6, 6, 14, 11, 9, 13, 6, 11, 12, 9, 10, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[12];
    uint8 src2 = secondSource[12];
    uint16 mask =
        (uint16)(12, 3, 9, 15, 5, 3, 1, 14, 0, 6, 13, 15, 2, 15, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[13];
    uint8 src2 = secondSource[13];
    uint16 mask = (uint16)(7, 2, 11, 7, 7, 6, 10, 7, 2, 14, 8, 6, 4, 14, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[14];
    uint8 src2 = secondSource[14];
    uint16 mask =
        (uint16)(12, 15, 11, 11, 0, 6, 10, 3, 6, 11, 0, 9, 11, 12, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[15];
    uint8 src2 = secondSource[15];
    uint16 mask = (uint16)(2, 9, 14, 2, 3, 6, 10, 4, 9, 7, 2, 1, 9, 11, 13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[16];
    uint8 src2 = secondSource[16];
    uint16 mask = (uint16)(13, 6, 11, 6, 14, 3, 7, 15, 2, 2, 4, 0, 2, 8, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[17];
    uint8 src2 = secondSource[17];
    uint16 mask =
        (uint16)(11, 3, 12, 7, 6, 8, 5, 11, 3, 0, 6, 0, 13, 14, 10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[18];
    uint8 src2 = secondSource[18];
    uint16 mask =
        (uint16)(11, 13, 6, 10, 8, 6, 7, 12, 11, 9, 13, 9, 15, 9, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[19];
    uint8 src2 = secondSource[19];
    uint16 mask =
        (uint16)(14, 13, 1, 10, 14, 12, 7, 5, 9, 10, 3, 6, 0, 9, 4, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[20];
    uint8 src2 = secondSource[20];
    uint16 mask =
        (uint16)(8, 9, 9, 13, 6, 2, 3, 7, 9, 12, 2, 10, 11, 10, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[21];
    uint8 src2 = secondSource[21];
    uint16 mask = (uint16)(1, 5, 9, 1, 5, 1, 7, 15, 10, 10, 13, 7, 15, 1, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[22];
    uint8 src2 = secondSource[22];
    uint16 mask = (uint16)(8, 6, 4, 12, 10, 9, 9, 0, 1, 3, 1, 9, 3, 4, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[23];
    uint8 src2 = secondSource[23];
    uint16 mask =
        (uint16)(0, 4, 8, 13, 1, 15, 12, 13, 13, 3, 11, 3, 9, 8, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[24];
    uint8 src2 = secondSource[24];
    uint16 mask =
        (uint16)(13, 10, 9, 9, 11, 11, 6, 12, 11, 4, 6, 13, 9, 4, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[25];
    uint8 src2 = secondSource[25];
    uint16 mask =
        (uint16)(0, 15, 12, 5, 6, 3, 7, 10, 2, 14, 9, 1, 3, 7, 13, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[26];
    uint8 src2 = secondSource[26];
    uint16 mask = (uint16)(15, 0, 3, 8, 8, 6, 6, 8, 13, 2, 0, 5, 6, 8, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[27];
    uint8 src2 = secondSource[27];
    uint16 mask =
        (uint16)(14, 4, 12, 12, 6, 15, 11, 0, 3, 15, 9, 0, 10, 7, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[28];
    uint8 src2 = secondSource[28];
    uint16 mask = (uint16)(2, 12, 3, 8, 5, 0, 9, 15, 8, 10, 2, 13, 8, 7, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[29];
    uint8 src2 = secondSource[29];
    uint16 mask = (uint16)(2, 10, 9, 6, 8, 14, 10, 1, 11, 9, 7, 11, 9, 1, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[30];
    uint8 src2 = secondSource[30];
    uint16 mask =
        (uint16)(4, 14, 6, 15, 13, 12, 15, 0, 15, 8, 6, 2, 8, 3, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint8 src1 = source[31];
    uint8 src2 = secondSource[31];
    uint16 mask =
        (uint16)(0, 14, 14, 12, 10, 12, 2, 0, 3, 14, 11, 10, 9, 13, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
