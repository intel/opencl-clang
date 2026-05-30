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
        (ushort16)(7, 25, 5, 7, 28, 11, 26, 26, 0, 28, 0, 9, 15, 3, 26, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[1];
    short16 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(29, 4, 6, 16, 25, 29, 13, 18, 20, 2, 10, 27, 4, 13, 22, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[2];
    short16 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(9, 20, 0, 5, 30, 31, 13, 6, 3, 30, 25, 17, 27, 23, 9, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[3];
    short16 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(21, 27, 3, 3, 12, 21, 7, 31, 7, 14, 30, 14, 1, 1, 17, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[4];
    short16 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(20, 30, 10, 5, 7, 0, 25, 9, 5, 14, 20, 6, 31, 24, 26, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[5];
    short16 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(13, 4, 21, 27, 18, 8, 20, 30, 9, 8, 16, 3, 2, 17, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[6];
    short16 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(12, 11, 5, 13, 5, 24, 5, 26, 17, 3, 14, 11, 19, 20, 31, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[7];
    short16 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(19, 18, 7, 6, 8, 15, 6, 24, 24, 22, 15, 19, 3, 2, 27, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[8];
    short16 src2 = secondSource[8];
    ushort16 mask = (ushort16)(12, 12, 19, 30, 31, 20, 18, 25, 16, 31, 29, 2,
                               28, 15, 14, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[9];
    short16 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(21, 25, 21, 16, 9, 11, 5, 9, 18, 28, 1, 16, 26, 5, 24, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[10];
    short16 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(22, 9, 29, 10, 30, 0, 14, 9, 21, 23, 31, 26, 27, 29, 20, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[11];
    short16 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(14, 31, 23, 4, 1, 0, 0, 23, 24, 15, 4, 8, 25, 14, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[12];
    short16 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(30, 21, 2, 9, 16, 1, 8, 24, 3, 0, 17, 3, 0, 14, 6, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[13];
    short16 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(14, 18, 11, 22, 27, 8, 9, 13, 10, 26, 29, 6, 5, 12, 19, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[14];
    short16 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(12, 24, 2, 11, 25, 28, 31, 31, 13, 6, 19, 11, 26, 5, 25, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[15];
    short16 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(16, 19, 9, 18, 8, 10, 27, 17, 2, 9, 18, 20, 15, 22, 15, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[16];
    short16 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(25, 29, 4, 3, 31, 9, 10, 9, 26, 5, 5, 24, 24, 8, 21, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[17];
    short16 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(25, 20, 31, 15, 21, 27, 16, 6, 22, 18, 24, 20, 14, 8, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[18];
    short16 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(6, 16, 0, 19, 24, 18, 11, 18, 24, 15, 4, 6, 21, 21, 1, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[19];
    short16 src2 = secondSource[19];
    ushort16 mask = (ushort16)(19, 26, 0, 25, 22, 17, 25, 12, 13, 16, 11, 29, 7,
                               16, 27, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[20];
    short16 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(14, 16, 24, 31, 19, 28, 4, 13, 5, 15, 8, 9, 27, 1, 10, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[21];
    short16 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(28, 6, 20, 19, 22, 27, 8, 9, 1, 26, 14, 11, 20, 23, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[22];
    short16 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(30, 10, 20, 18, 31, 16, 25, 29, 16, 22, 5, 14, 20, 6, 4, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[23];
    short16 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(12, 7, 15, 14, 15, 25, 7, 29, 0, 6, 17, 21, 14, 11, 2, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[24];
    short16 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(16, 11, 3, 27, 31, 11, 23, 15, 11, 0, 26, 31, 3, 28, 28, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[25];
    short16 src2 = secondSource[25];
    ushort16 mask = (ushort16)(21, 18, 2, 29, 13, 31, 19, 11, 19, 23, 23, 10,
                               21, 26, 20, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[26];
    short16 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(26, 21, 0, 19, 30, 18, 13, 22, 9, 2, 15, 4, 30, 19, 29, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[27];
    short16 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(26, 16, 7, 21, 9, 12, 26, 27, 20, 4, 7, 31, 27, 26, 28, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[28];
    short16 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(20, 0, 31, 6, 17, 27, 27, 27, 9, 25, 30, 17, 11, 25, 3, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[29];
    short16 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(4, 19, 20, 26, 24, 23, 1, 12, 15, 5, 25, 2, 16, 3, 13, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[30];
    short16 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(5, 26, 3, 3, 10, 10, 9, 27, 11, 18, 2, 1, 7, 20, 16, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[31];
    short16 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(31, 22, 13, 26, 13, 23, 9, 9, 17, 5, 27, 23, 21, 27, 31, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
