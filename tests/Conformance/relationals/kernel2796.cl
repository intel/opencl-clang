// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *secondSource,
                          __global short8 *source, __global short8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 , src2;
  short8 tmp;
  tmp = (short8)((short)0);
  {
    short8 src1 = source[0];
    short8 src2 = secondSource[0];
    ushort8 mask = (ushort8)(14, 0, 6, 11, 7, 6, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[1];
    short8 src2 = secondSource[1];
    ushort8 mask = (ushort8)(6, 6, 9, 10, 11, 14, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[2];
    short8 src2 = secondSource[2];
    ushort8 mask = (ushort8)(4, 2, 11, 13, 12, 3, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[3];
    short8 src2 = secondSource[3];
    ushort8 mask = (ushort8)(4, 5, 0, 11, 6, 5, 14, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[4];
    short8 src2 = secondSource[4];
    ushort8 mask = (ushort8)(6, 8, 12, 1, 0, 4, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[5];
    short8 src2 = secondSource[5];
    ushort8 mask = (ushort8)(15, 8, 15, 1, 9, 15, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[6];
    short8 src2 = secondSource[6];
    ushort8 mask = (ushort8)(13, 15, 11, 15, 0, 4, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[7];
    short8 src2 = secondSource[7];
    ushort8 mask = (ushort8)(11, 10, 1, 6, 8, 5, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[8];
    short8 src2 = secondSource[8];
    ushort8 mask = (ushort8)(14, 3, 7, 3, 8, 4, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[9];
    short8 src2 = secondSource[9];
    ushort8 mask = (ushort8)(8, 2, 13, 1, 15, 8, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[10];
    short8 src2 = secondSource[10];
    ushort8 mask = (ushort8)(3, 4, 13, 12, 5, 1, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[11];
    short8 src2 = secondSource[11];
    ushort8 mask = (ushort8)(8, 6, 1, 6, 7, 7, 11, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[12];
    short8 src2 = secondSource[12];
    ushort8 mask = (ushort8)(13, 12, 5, 3, 13, 2, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[13];
    short8 src2 = secondSource[13];
    ushort8 mask = (ushort8)(9, 5, 5, 12, 8, 8, 3, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[14];
    short8 src2 = secondSource[14];
    ushort8 mask = (ushort8)(3, 3, 13, 5, 12, 4, 13, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[15];
    short8 src2 = secondSource[15];
    ushort8 mask = (ushort8)(7, 5, 10, 13, 7, 15, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[16];
    short8 src2 = secondSource[16];
    ushort8 mask = (ushort8)(0, 13, 14, 15, 11, 4, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[17];
    short8 src2 = secondSource[17];
    ushort8 mask = (ushort8)(1, 13, 14, 6, 2, 9, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[18];
    short8 src2 = secondSource[18];
    ushort8 mask = (ushort8)(12, 15, 11, 7, 10, 7, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[19];
    short8 src2 = secondSource[19];
    ushort8 mask = (ushort8)(10, 8, 1, 12, 13, 11, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[20];
    short8 src2 = secondSource[20];
    ushort8 mask = (ushort8)(7, 12, 14, 0, 12, 3, 0, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[21];
    short8 src2 = secondSource[21];
    ushort8 mask = (ushort8)(7, 13, 8, 7, 13, 11, 9, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[22];
    short8 src2 = secondSource[22];
    ushort8 mask = (ushort8)(1, 6, 6, 4, 10, 0, 15, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[23];
    short8 src2 = secondSource[23];
    ushort8 mask = (ushort8)(6, 4, 15, 6, 8, 9, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[24];
    short8 src2 = secondSource[24];
    ushort8 mask = (ushort8)(6, 10, 9, 2, 6, 11, 6, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[25];
    short8 src2 = secondSource[25];
    ushort8 mask = (ushort8)(15, 3, 7, 5, 12, 3, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[26];
    short8 src2 = secondSource[26];
    ushort8 mask = (ushort8)(3, 4, 15, 8, 14, 4, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[27];
    short8 src2 = secondSource[27];
    ushort8 mask = (ushort8)(14, 0, 3, 9, 9, 3, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[28];
    short8 src2 = secondSource[28];
    ushort8 mask = (ushort8)(9, 13, 3, 6, 4, 7, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[29];
    short8 src2 = secondSource[29];
    ushort8 mask = (ushort8)(11, 6, 9, 9, 4, 4, 2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[30];
    short8 src2 = secondSource[30];
    ushort8 mask = (ushort8)(10, 6, 3, 13, 2, 8, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[31];
    short8 src2 = secondSource[31];
    ushort8 mask = (ushort8)(11, 5, 11, 3, 14, 10, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
