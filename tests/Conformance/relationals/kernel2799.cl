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
        (ushort16)(10, 7, 3, 1, 0, 12, 3, 13, 1, 4, 11, 10, 9, 2, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[1];
    short8 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(6, 3, 4, 9, 13, 5, 9, 2, 7, 2, 14, 13, 5, 0, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[2];
    short8 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(4, 6, 2, 12, 9, 9, 14, 10, 10, 13, 10, 12, 13, 2, 11, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[3];
    short8 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(6, 6, 12, 14, 1, 6, 13, 14, 8, 0, 8, 2, 14, 0, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[4];
    short8 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(1, 6, 4, 15, 11, 6, 1, 4, 4, 9, 4, 13, 11, 11, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[5];
    short8 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(5, 0, 6, 8, 1, 10, 7, 15, 8, 9, 15, 7, 13, 9, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[6];
    short8 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(4, 3, 2, 11, 10, 7, 3, 0, 9, 2, 3, 9, 1, 3, 7, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[7];
    short8 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(10, 12, 1, 15, 8, 0, 6, 13, 4, 14, 2, 15, 3, 9, 14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[8];
    short8 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(0, 6, 2, 7, 8, 10, 10, 12, 6, 1, 3, 4, 4, 11, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[9];
    short8 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(11, 3, 15, 7, 11, 13, 6, 3, 3, 14, 8, 8, 11, 6, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[10];
    short8 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(0, 4, 3, 5, 6, 12, 10, 7, 0, 13, 8, 13, 4, 15, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[11];
    short8 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(6, 0, 7, 4, 6, 4, 1, 1, 2, 3, 7, 11, 6, 2, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[12];
    short8 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(12, 3, 9, 15, 8, 13, 0, 6, 10, 13, 9, 6, 8, 14, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[13];
    short8 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(12, 3, 3, 0, 2, 4, 10, 12, 5, 11, 7, 10, 0, 15, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[14];
    short8 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(15, 14, 11, 9, 13, 3, 10, 6, 9, 7, 15, 3, 7, 1, 12, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[15];
    short8 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(3, 6, 1, 13, 2, 14, 5, 13, 7, 3, 14, 7, 9, 5, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[16];
    short8 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(6, 7, 10, 12, 6, 1, 9, 1, 8, 7, 4, 8, 1, 13, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[17];
    short8 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(9, 9, 1, 12, 7, 1, 14, 5, 9, 12, 15, 6, 4, 15, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[18];
    short8 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(14, 5, 5, 15, 8, 12, 13, 9, 5, 9, 0, 6, 15, 4, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[19];
    short8 src2 = secondSource[19];
    ushort16 mask =
        (ushort16)(1, 6, 11, 6, 5, 15, 2, 11, 1, 14, 11, 11, 15, 12, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[20];
    short8 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(12, 12, 10, 5, 6, 5, 0, 5, 6, 0, 0, 9, 15, 15, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[21];
    short8 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(9, 14, 15, 4, 9, 1, 2, 2, 15, 7, 3, 6, 2, 3, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[22];
    short8 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(6, 3, 15, 2, 8, 10, 12, 10, 12, 3, 6, 1, 1, 14, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[23];
    short8 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(15, 10, 13, 6, 5, 6, 13, 9, 14, 0, 14, 10, 14, 12, 2, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[24];
    short8 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(12, 12, 0, 7, 12, 11, 9, 11, 11, 6, 8, 8, 9, 10, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[25];
    short8 src2 = secondSource[25];
    ushort16 mask =
        (ushort16)(0, 4, 12, 7, 4, 5, 12, 12, 11, 0, 9, 15, 1, 2, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[26];
    short8 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(6, 1, 14, 3, 3, 1, 6, 13, 10, 0, 7, 0, 0, 14, 11, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[27];
    short8 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(14, 7, 9, 3, 9, 10, 13, 3, 13, 5, 2, 13, 6, 1, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[28];
    short8 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(11, 7, 13, 8, 2, 13, 7, 7, 11, 1, 11, 10, 1, 14, 11, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[29];
    short8 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(10, 0, 5, 11, 4, 3, 0, 0, 6, 5, 4, 13, 6, 10, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[30];
    short8 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(2, 2, 7, 2, 12, 15, 3, 13, 13, 14, 14, 9, 1, 15, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[31];
    short8 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(10, 0, 8, 3, 14, 0, 12, 11, 8, 5, 1, 0, 1, 15, 7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
