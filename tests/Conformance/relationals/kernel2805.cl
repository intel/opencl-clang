// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *secondSource,
                          __global short16 *source, __global short8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 , src2;
  short8 tmp;
  tmp = (short8)((short)0);
  {
    short16 src1 = source[0];
    short16 src2 = secondSource[0];
    ushort8 mask = (ushort8)(3, 7, 1, 9, 11, 27, 5, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[1];
    short16 src2 = secondSource[1];
    ushort8 mask = (ushort8)(15, 2, 7, 28, 1, 11, 22, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[2];
    short16 src2 = secondSource[2];
    ushort8 mask = (ushort8)(10, 19, 5, 22, 30, 24, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[3];
    short16 src2 = secondSource[3];
    ushort8 mask = (ushort8)(18, 10, 30, 15, 3, 5, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[4];
    short16 src2 = secondSource[4];
    ushort8 mask = (ushort8)(22, 11, 17, 9, 13, 20, 3, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[5];
    short16 src2 = secondSource[5];
    ushort8 mask = (ushort8)(18, 25, 14, 13, 21, 3, 9, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[6];
    short16 src2 = secondSource[6];
    ushort8 mask = (ushort8)(12, 10, 9, 1, 6, 13, 16, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[7];
    short16 src2 = secondSource[7];
    ushort8 mask = (ushort8)(26, 7, 1, 30, 15, 20, 24, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[8];
    short16 src2 = secondSource[8];
    ushort8 mask = (ushort8)(20, 23, 31, 17, 1, 3, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[9];
    short16 src2 = secondSource[9];
    ushort8 mask = (ushort8)(10, 19, 0, 9, 16, 30, 20, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[10];
    short16 src2 = secondSource[10];
    ushort8 mask = (ushort8)(13, 15, 13, 14, 28, 5, 19, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[11];
    short16 src2 = secondSource[11];
    ushort8 mask = (ushort8)(8, 28, 10, 8, 6, 25, 8, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[12];
    short16 src2 = secondSource[12];
    ushort8 mask = (ushort8)(21, 10, 20, 28, 8, 28, 17, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[13];
    short16 src2 = secondSource[13];
    ushort8 mask = (ushort8)(27, 24, 8, 14, 0, 17, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[14];
    short16 src2 = secondSource[14];
    ushort8 mask = (ushort8)(30, 28, 0, 16, 3, 20, 5, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[15];
    short16 src2 = secondSource[15];
    ushort8 mask = (ushort8)(22, 31, 31, 28, 18, 7, 2, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[16];
    short16 src2 = secondSource[16];
    ushort8 mask = (ushort8)(14, 17, 25, 8, 5, 13, 9, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[17];
    short16 src2 = secondSource[17];
    ushort8 mask = (ushort8)(21, 23, 10, 2, 23, 4, 25, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[18];
    short16 src2 = secondSource[18];
    ushort8 mask = (ushort8)(26, 1, 17, 25, 12, 23, 19, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[19];
    short16 src2 = secondSource[19];
    ushort8 mask = (ushort8)(5, 0, 6, 25, 26, 9, 26, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[20];
    short16 src2 = secondSource[20];
    ushort8 mask = (ushort8)(13, 4, 14, 3, 13, 15, 14, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[21];
    short16 src2 = secondSource[21];
    ushort8 mask = (ushort8)(7, 17, 6, 14, 26, 2, 21, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[22];
    short16 src2 = secondSource[22];
    ushort8 mask = (ushort8)(31, 30, 5, 22, 29, 25, 24, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[23];
    short16 src2 = secondSource[23];
    ushort8 mask = (ushort8)(16, 22, 20, 31, 26, 9, 16, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[24];
    short16 src2 = secondSource[24];
    ushort8 mask = (ushort8)(20, 22, 31, 25, 23, 12, 2, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[25];
    short16 src2 = secondSource[25];
    ushort8 mask = (ushort8)(22, 5, 31, 14, 12, 19, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[26];
    short16 src2 = secondSource[26];
    ushort8 mask = (ushort8)(23, 18, 9, 7, 29, 30, 5, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[27];
    short16 src2 = secondSource[27];
    ushort8 mask = (ushort8)(12, 4, 0, 22, 14, 25, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[28];
    short16 src2 = secondSource[28];
    ushort8 mask = (ushort8)(19, 0, 23, 2, 8, 9, 4, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[29];
    short16 src2 = secondSource[29];
    ushort8 mask = (ushort8)(3, 23, 8, 14, 26, 0, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[30];
    short16 src2 = secondSource[30];
    ushort8 mask = (ushort8)(6, 23, 9, 2, 11, 17, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[31];
    short16 src2 = secondSource[31];
    ushort8 mask = (ushort8)(17, 9, 18, 4, 24, 9, 22, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
