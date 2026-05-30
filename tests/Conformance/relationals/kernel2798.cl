// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *secondSource,
                          __global short8 *source, __global short16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 , src2;
  short16 tmp;
  tmp = (short16)((short)0);
  {
    short8 src1 = source[0];
    short8 src2 = secondSource[0];
    ushort16 mask =
        (ushort16)(2, 0, 6, 8, 4, 9, 6, 3, 14, 10, 6, 12, 14, 14, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[1];
    short8 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(4, 8, 5, 7, 5, 8, 9, 0, 10, 9, 15, 10, 14, 15, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[2];
    short8 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(0, 14, 8, 13, 6, 6, 8, 12, 0, 8, 15, 1, 0, 1, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[3];
    short8 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(1, 4, 8, 7, 5, 6, 6, 3, 12, 10, 14, 15, 2, 9, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[4];
    short8 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(7, 5, 1, 4, 6, 2, 4, 2, 14, 3, 3, 9, 11, 4, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[5];
    short8 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(10, 1, 9, 3, 7, 5, 13, 1, 3, 13, 7, 4, 15, 6, 2, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[6];
    short8 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(8, 13, 4, 4, 1, 0, 13, 1, 9, 10, 9, 10, 8, 6, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[7];
    short8 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(9, 8, 1, 14, 10, 14, 0, 2, 3, 2, 4, 4, 4, 4, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[8];
    short8 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(4, 11, 1, 9, 1, 10, 2, 1, 6, 4, 3, 4, 3, 1, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[9];
    short8 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(4, 4, 8, 8, 15, 0, 12, 11, 2, 13, 12, 9, 11, 2, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[10];
    short8 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(6, 1, 13, 2, 11, 10, 4, 1, 6, 1, 13, 4, 12, 1, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[11];
    short8 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(13, 9, 15, 7, 14, 7, 6, 12, 8, 10, 13, 6, 11, 11, 11, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[12];
    short8 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(4, 0, 9, 14, 0, 3, 4, 13, 3, 14, 6, 13, 11, 12, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[13];
    short8 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(2, 0, 13, 3, 14, 9, 7, 12, 3, 7, 4, 15, 6, 15, 12, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[14];
    short8 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(8, 8, 9, 1, 15, 8, 1, 7, 7, 6, 7, 13, 8, 6, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[15];
    short8 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(2, 15, 6, 15, 9, 13, 4, 15, 7, 3, 15, 7, 0, 0, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[16];
    short8 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(7, 12, 11, 11, 4, 3, 12, 1, 6, 12, 1, 2, 10, 10, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[17];
    short8 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(11, 13, 0, 2, 9, 14, 13, 13, 11, 5, 9, 4, 6, 12, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[18];
    short8 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(5, 8, 6, 0, 8, 13, 2, 13, 14, 11, 10, 9, 5, 12, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[19];
    short8 src2 = secondSource[19];
    ushort16 mask =
        (ushort16)(13, 9, 9, 4, 5, 12, 5, 12, 1, 4, 5, 7, 3, 15, 9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[20];
    short8 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(11, 13, 4, 10, 8, 8, 12, 7, 10, 0, 11, 12, 3, 3, 10, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[21];
    short8 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(4, 7, 3, 11, 4, 0, 5, 6, 7, 11, 3, 15, 5, 3, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[22];
    short8 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(2, 10, 3, 3, 0, 5, 11, 10, 8, 2, 7, 7, 0, 11, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[23];
    short8 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(13, 2, 13, 14, 14, 1, 12, 11, 2, 7, 15, 13, 14, 0, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[24];
    short8 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(4, 8, 0, 7, 7, 13, 9, 11, 15, 13, 2, 4, 1, 10, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[25];
    short8 src2 = secondSource[25];
    ushort16 mask =
        (ushort16)(12, 15, 5, 15, 10, 3, 14, 7, 12, 6, 1, 4, 7, 14, 0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[26];
    short8 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(2, 12, 12, 14, 2, 9, 8, 1, 9, 2, 2, 4, 14, 2, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[27];
    short8 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(14, 5, 1, 3, 14, 6, 5, 5, 12, 4, 6, 11, 11, 6, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[28];
    short8 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(8, 7, 6, 0, 6, 5, 0, 13, 0, 14, 11, 0, 6, 13, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[29];
    short8 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(13, 9, 10, 15, 7, 15, 5, 11, 5, 10, 5, 3, 14, 11, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[30];
    short8 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(0, 7, 2, 12, 5, 13, 2, 6, 13, 15, 15, 10, 5, 7, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[31];
    short8 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(0, 3, 3, 8, 3, 10, 6, 6, 13, 11, 6, 11, 11, 7, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
