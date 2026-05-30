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
    ushort8 mask = (ushort8)(13, 0, 10, 10, 0, 8, 23, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[1];
    short16 src2 = secondSource[1];
    ushort8 mask = (ushort8)(14, 11, 11, 26, 5, 0, 15, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[2];
    short16 src2 = secondSource[2];
    ushort8 mask = (ushort8)(8, 9, 16, 10, 8, 16, 9, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[3];
    short16 src2 = secondSource[3];
    ushort8 mask = (ushort8)(13, 1, 19, 11, 26, 2, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[4];
    short16 src2 = secondSource[4];
    ushort8 mask = (ushort8)(10, 5, 20, 0, 31, 24, 7, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[5];
    short16 src2 = secondSource[5];
    ushort8 mask = (ushort8)(7, 22, 26, 26, 25, 26, 10, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[6];
    short16 src2 = secondSource[6];
    ushort8 mask = (ushort8)(0, 0, 13, 17, 17, 24, 24, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[7];
    short16 src2 = secondSource[7];
    ushort8 mask = (ushort8)(21, 11, 21, 5, 25, 28, 24, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[8];
    short16 src2 = secondSource[8];
    ushort8 mask = (ushort8)(15, 7, 3, 29, 26, 3, 19, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[9];
    short16 src2 = secondSource[9];
    ushort8 mask = (ushort8)(1, 27, 25, 19, 12, 6, 10, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[10];
    short16 src2 = secondSource[10];
    ushort8 mask = (ushort8)(16, 26, 21, 29, 29, 18, 0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[11];
    short16 src2 = secondSource[11];
    ushort8 mask = (ushort8)(9, 20, 1, 22, 26, 28, 22, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[12];
    short16 src2 = secondSource[12];
    ushort8 mask = (ushort8)(8, 30, 24, 0, 20, 21, 21, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[13];
    short16 src2 = secondSource[13];
    ushort8 mask = (ushort8)(24, 4, 5, 23, 19, 0, 16, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[14];
    short16 src2 = secondSource[14];
    ushort8 mask = (ushort8)(10, 13, 23, 2, 13, 29, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[15];
    short16 src2 = secondSource[15];
    ushort8 mask = (ushort8)(6, 29, 23, 13, 0, 12, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[16];
    short16 src2 = secondSource[16];
    ushort8 mask = (ushort8)(17, 28, 8, 11, 5, 15, 11, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[17];
    short16 src2 = secondSource[17];
    ushort8 mask = (ushort8)(3, 1, 23, 22, 18, 12, 1, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[18];
    short16 src2 = secondSource[18];
    ushort8 mask = (ushort8)(30, 30, 24, 28, 31, 3, 20, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[19];
    short16 src2 = secondSource[19];
    ushort8 mask = (ushort8)(30, 3, 25, 1, 9, 13, 24, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[20];
    short16 src2 = secondSource[20];
    ushort8 mask = (ushort8)(3, 13, 16, 5, 29, 25, 16, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[21];
    short16 src2 = secondSource[21];
    ushort8 mask = (ushort8)(30, 7, 12, 8, 16, 0, 18, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[22];
    short16 src2 = secondSource[22];
    ushort8 mask = (ushort8)(30, 26, 22, 26, 19, 11, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[23];
    short16 src2 = secondSource[23];
    ushort8 mask = (ushort8)(7, 11, 3, 27, 16, 4, 31, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[24];
    short16 src2 = secondSource[24];
    ushort8 mask = (ushort8)(26, 7, 15, 28, 16, 10, 1, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[25];
    short16 src2 = secondSource[25];
    ushort8 mask = (ushort8)(26, 17, 12, 23, 0, 27, 29, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[26];
    short16 src2 = secondSource[26];
    ushort8 mask = (ushort8)(14, 8, 21, 1, 17, 10, 25, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[27];
    short16 src2 = secondSource[27];
    ushort8 mask = (ushort8)(30, 30, 19, 27, 3, 0, 18, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[28];
    short16 src2 = secondSource[28];
    ushort8 mask = (ushort8)(1, 20, 11, 21, 2, 15, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[29];
    short16 src2 = secondSource[29];
    ushort8 mask = (ushort8)(28, 7, 6, 25, 25, 20, 12, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[30];
    short16 src2 = secondSource[30];
    ushort8 mask = (ushort8)(11, 30, 27, 10, 13, 0, 31, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[31];
    short16 src2 = secondSource[31];
    ushort8 mask = (ushort8)(6, 14, 28, 5, 8, 26, 17, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
