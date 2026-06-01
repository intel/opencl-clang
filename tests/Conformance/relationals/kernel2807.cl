// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *secondSource,
                          __global short16 *source, __global short16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 , src2;
  short16 tmp;
  tmp = (short16)((short)0);
  {
    short16 src1 = source[0];
    short16 src2 = secondSource[0];
    ushort16 mask =
        (ushort16)(30, 30, 26, 20, 1, 6, 24, 6, 19, 19, 23, 5, 31, 25, 7, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[1];
    short16 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(11, 10, 17, 13, 10, 7, 27, 0, 17, 25, 0, 12, 29, 20, 16, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[2];
    short16 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(21, 23, 16, 1, 19, 22, 31, 25, 14, 0, 22, 6, 27, 29, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[3];
    short16 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(18, 3, 14, 1, 31, 29, 29, 9, 5, 5, 3, 17, 14, 27, 0, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[4];
    short16 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(15, 5, 23, 2, 28, 23, 30, 4, 29, 8, 29, 15, 10, 8, 12, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[5];
    short16 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(26, 11, 14, 24, 4, 4, 14, 1, 11, 20, 2, 15, 11, 16, 30, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[6];
    short16 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(29, 25, 31, 7, 18, 27, 3, 6, 7, 22, 5, 22, 6, 17, 28, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[7];
    short16 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(6, 29, 12, 5, 2, 11, 1, 8, 30, 18, 24, 26, 13, 11, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[8];
    short16 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(31, 1, 13, 0, 17, 11, 2, 24, 8, 6, 8, 11, 4, 4, 28, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[9];
    short16 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(6, 20, 0, 22, 31, 2, 30, 30, 23, 5, 26, 16, 4, 14, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[10];
    short16 src2 = secondSource[10];
    ushort16 mask = (ushort16)(27, 23, 11, 21, 10, 30, 22, 3, 24, 20, 19, 28, 3,
                               26, 11, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[11];
    short16 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(0, 0, 3, 2, 23, 26, 8, 27, 5, 31, 31, 31, 26, 3, 21, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[12];
    short16 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(10, 11, 5, 8, 26, 26, 29, 20, 27, 31, 8, 22, 2, 20, 16, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[13];
    short16 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(24, 4, 31, 26, 29, 6, 1, 6, 0, 13, 20, 12, 4, 21, 19, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[14];
    short16 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(0, 26, 23, 6, 12, 10, 24, 26, 22, 24, 15, 14, 16, 16, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[15];
    short16 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(20, 5, 20, 12, 26, 25, 1, 11, 6, 21, 21, 13, 17, 9, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[16];
    short16 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(0, 25, 26, 3, 9, 25, 11, 19, 14, 28, 17, 3, 7, 15, 15, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[17];
    short16 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(29, 6, 6, 16, 17, 2, 31, 25, 15, 26, 28, 4, 1, 19, 16, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[18];
    short16 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(0, 16, 8, 19, 29, 9, 13, 13, 14, 24, 12, 15, 23, 6, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[19];
    short16 src2 = secondSource[19];
    ushort16 mask =
        (ushort16)(16, 8, 2, 5, 22, 25, 17, 13, 31, 19, 27, 26, 11, 12, 11, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[20];
    short16 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(21, 18, 14, 15, 17, 3, 31, 16, 2, 31, 19, 1, 21, 9, 7, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[21];
    short16 src2 = secondSource[21];
    ushort16 mask = (ushort16)(18, 19, 24, 22, 9, 19, 31, 24, 4, 11, 15, 28, 23,
                               23, 14, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[22];
    short16 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(16, 31, 15, 5, 1, 29, 10, 9, 2, 25, 24, 24, 15, 27, 13, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[23];
    short16 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(24, 31, 21, 12, 13, 30, 4, 5, 15, 14, 6, 3, 13, 27, 28, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[24];
    short16 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(8, 2, 13, 20, 1, 8, 28, 17, 2, 16, 20, 17, 31, 6, 29, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[25];
    short16 src2 = secondSource[25];
    ushort16 mask =
        (ushort16)(0, 22, 8, 13, 3, 20, 12, 16, 14, 20, 5, 14, 24, 31, 11, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[26];
    short16 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(12, 23, 9, 3, 9, 22, 13, 1, 13, 29, 16, 14, 22, 30, 3, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[27];
    short16 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(2, 24, 4, 14, 3, 16, 5, 30, 0, 14, 26, 6, 25, 10, 0, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[28];
    short16 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(10, 21, 20, 16, 4, 0, 5, 16, 2, 13, 5, 8, 20, 28, 20, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[29];
    short16 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(8, 9, 8, 1, 13, 26, 15, 22, 29, 19, 21, 24, 10, 24, 24, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[30];
    short16 src2 = secondSource[30];
    ushort16 mask = (ushort16)(14, 22, 18, 21, 21, 13, 10, 15, 16, 22, 3, 23,
                               27, 27, 30, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[31];
    short16 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(28, 2, 1, 26, 27, 31, 26, 15, 4, 17, 23, 28, 1, 30, 25, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
