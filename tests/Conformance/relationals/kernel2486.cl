// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *source, __global short16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 /*, src2*/;
  short16 tmp;
  tmp = (short16)((short)0);
  {
    short16 src1 = source[0];
    ushort16 mask =
        (ushort16)(3, 12, 2, 3, 14, 5, 13, 13, 0, 14, 0, 4, 7, 1, 13, 15);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[1];
    ushort16 mask =
        (ushort16)(14, 2, 3, 8, 12, 14, 6, 9, 10, 1, 5, 13, 2, 6, 11, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[2];
    ushort16 mask =
        (ushort16)(4, 10, 0, 2, 15, 15, 6, 3, 1, 15, 12, 8, 13, 11, 4, 8);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[3];
    ushort16 mask =
        (ushort16)(10, 13, 1, 1, 6, 10, 3, 15, 3, 7, 15, 7, 0, 0, 8, 10);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[4];
    ushort16 mask =
        (ushort16)(10, 15, 5, 2, 3, 0, 12, 4, 2, 7, 10, 3, 15, 12, 13, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[5];
    ushort16 mask =
        (ushort16)(6, 2, 10, 13, 9, 4, 10, 15, 4, 4, 8, 1, 1, 8, 3, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[6];
    ushort16 mask =
        (ushort16)(6, 5, 2, 6, 2, 12, 2, 13, 8, 1, 7, 5, 9, 10, 15, 0);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[7];
    ushort16 mask =
        (ushort16)(9, 9, 3, 3, 4, 7, 3, 12, 12, 11, 7, 9, 1, 1, 13, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[8];
    ushort16 mask =
        (ushort16)(6, 6, 9, 15, 15, 10, 9, 12, 8, 15, 14, 1, 14, 7, 7, 11);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[9];
    ushort16 mask =
        (ushort16)(10, 12, 10, 8, 4, 5, 2, 4, 9, 14, 0, 8, 13, 2, 12, 12);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[10];
    ushort16 mask =
        (ushort16)(11, 4, 14, 5, 15, 0, 7, 4, 10, 11, 15, 13, 13, 14, 10, 11);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[11];
    ushort16 mask =
        (ushort16)(7, 15, 11, 2, 0, 0, 0, 11, 12, 7, 2, 4, 12, 7, 6, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[12];
    ushort16 mask =
        (ushort16)(15, 10, 1, 4, 8, 0, 4, 12, 1, 0, 8, 1, 0, 7, 3, 9);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[13];
    ushort16 mask =
        (ushort16)(7, 9, 5, 11, 13, 4, 4, 6, 5, 13, 14, 3, 2, 6, 9, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[14];
    ushort16 mask =
        (ushort16)(6, 12, 1, 5, 12, 14, 15, 15, 6, 3, 9, 5, 13, 2, 12, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[15];
    ushort16 mask =
        (ushort16)(8, 9, 4, 9, 4, 5, 13, 8, 1, 4, 9, 10, 7, 11, 7, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[16];
    ushort16 mask =
        (ushort16)(12, 14, 2, 1, 15, 4, 5, 4, 13, 2, 2, 12, 12, 4, 10, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[17];
    ushort16 mask =
        (ushort16)(12, 10, 15, 7, 10, 13, 8, 3, 11, 9, 12, 10, 7, 4, 3, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[18];
    ushort16 mask =
        (ushort16)(3, 8, 0, 9, 12, 9, 5, 9, 12, 7, 2, 3, 10, 10, 0, 8);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[19];
    ushort16 mask =
        (ushort16)(9, 13, 0, 12, 11, 8, 12, 6, 6, 8, 5, 14, 3, 8, 13, 8);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[20];
    ushort16 mask =
        (ushort16)(7, 8, 12, 15, 9, 14, 2, 6, 2, 7, 4, 4, 13, 0, 5, 15);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[21];
    ushort16 mask =
        (ushort16)(14, 3, 10, 9, 11, 13, 4, 4, 0, 13, 7, 5, 10, 11, 5, 1);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[22];
    ushort16 mask =
        (ushort16)(15, 5, 10, 9, 15, 8, 12, 14, 8, 11, 2, 7, 10, 3, 2, 10);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[23];
    ushort16 mask =
        (ushort16)(6, 3, 7, 7, 7, 12, 3, 14, 0, 3, 8, 10, 7, 5, 1, 13);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[24];
    ushort16 mask =
        (ushort16)(8, 5, 1, 13, 15, 5, 11, 7, 5, 0, 13, 15, 1, 14, 14, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[25];
    ushort16 mask =
        (ushort16)(10, 9, 1, 14, 6, 15, 9, 5, 9, 11, 11, 5, 10, 13, 10, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[26];
    ushort16 mask =
        (ushort16)(13, 10, 0, 9, 15, 9, 6, 11, 4, 1, 7, 2, 15, 9, 14, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[27];
    ushort16 mask =
        (ushort16)(13, 8, 3, 10, 4, 6, 13, 13, 10, 2, 3, 15, 13, 13, 14, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[28];
    ushort16 mask =
        (ushort16)(10, 0, 15, 3, 8, 13, 13, 13, 4, 12, 15, 8, 5, 12, 1, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[29];
    ushort16 mask =
        (ushort16)(2, 9, 10, 13, 12, 11, 0, 6, 7, 2, 12, 1, 8, 1, 6, 5);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[30];
    ushort16 mask =
        (ushort16)(2, 13, 1, 1, 5, 5, 4, 13, 5, 9, 1, 0, 3, 10, 8, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[31];
    ushort16 mask =
        (ushort16)(15, 11, 6, 13, 6, 11, 4, 4, 8, 2, 13, 11, 10, 13, 15, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
