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
        (ushort16)(15, 15, 13, 10, 0, 3, 12, 3, 9, 9, 11, 2, 15, 12, 3, 10);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[1];
    ushort16 mask =
        (ushort16)(5, 5, 8, 6, 5, 3, 13, 0, 8, 12, 0, 6, 14, 10, 8, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[2];
    ushort16 mask =
        (ushort16)(10, 11, 8, 0, 9, 11, 15, 12, 7, 0, 11, 3, 13, 14, 1, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[3];
    ushort16 mask =
        (ushort16)(9, 1, 7, 0, 15, 14, 14, 4, 2, 2, 1, 8, 7, 13, 0, 15);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[4];
    ushort16 mask =
        (ushort16)(7, 2, 11, 1, 14, 11, 15, 2, 14, 4, 14, 7, 5, 4, 6, 9);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[5];
    ushort16 mask =
        (ushort16)(13, 5, 7, 12, 2, 2, 7, 0, 5, 10, 1, 7, 5, 8, 15, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[6];
    ushort16 mask =
        (ushort16)(14, 12, 15, 3, 9, 13, 1, 3, 3, 11, 2, 11, 3, 8, 14, 14);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[7];
    ushort16 mask =
        (ushort16)(3, 14, 6, 2, 1, 5, 0, 4, 15, 9, 12, 13, 6, 5, 2, 8);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[8];
    ushort16 mask =
        (ushort16)(15, 0, 6, 0, 8, 5, 1, 12, 4, 3, 4, 5, 2, 2, 14, 1);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[9];
    ushort16 mask =
        (ushort16)(3, 10, 0, 11, 15, 1, 15, 15, 11, 2, 13, 8, 2, 7, 1, 2);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[10];
    ushort16 mask =
        (ushort16)(13, 11, 5, 10, 5, 15, 11, 1, 12, 10, 9, 14, 1, 13, 5, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[11];
    ushort16 mask =
        (ushort16)(0, 0, 1, 1, 11, 13, 4, 13, 2, 15, 15, 15, 13, 1, 10, 6);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[12];
    ushort16 mask =
        (ushort16)(5, 5, 2, 4, 13, 13, 14, 10, 13, 15, 4, 11, 1, 10, 8, 14);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[13];
    ushort16 mask =
        (ushort16)(12, 2, 15, 13, 14, 3, 0, 3, 0, 6, 10, 6, 2, 10, 9, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[14];
    ushort16 mask =
        (ushort16)(0, 13, 11, 3, 6, 5, 12, 13, 11, 12, 7, 7, 8, 8, 1, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[15];
    ushort16 mask =
        (ushort16)(10, 2, 10, 6, 13, 12, 0, 5, 3, 10, 10, 6, 8, 4, 6, 7);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[16];
    ushort16 mask =
        (ushort16)(0, 12, 13, 1, 4, 12, 5, 9, 7, 14, 8, 1, 3, 7, 7, 15);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[17];
    ushort16 mask =
        (ushort16)(14, 3, 3, 8, 8, 1, 15, 12, 7, 13, 14, 2, 0, 9, 8, 4);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[18];
    ushort16 mask =
        (ushort16)(0, 8, 4, 9, 14, 4, 6, 6, 7, 12, 6, 7, 11, 3, 6, 5);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[19];
    ushort16 mask =
        (ushort16)(8, 4, 1, 2, 11, 12, 8, 6, 15, 9, 13, 13, 5, 6, 5, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[20];
    ushort16 mask =
        (ushort16)(10, 9, 7, 7, 8, 1, 15, 8, 1, 15, 9, 0, 10, 4, 3, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[21];
    ushort16 mask =
        (ushort16)(9, 9, 12, 11, 4, 9, 15, 12, 2, 5, 7, 14, 11, 11, 7, 13);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[22];
    ushort16 mask =
        (ushort16)(8, 15, 7, 2, 0, 14, 5, 4, 1, 12, 12, 12, 7, 13, 6, 12);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[23];
    ushort16 mask =
        (ushort16)(12, 15, 10, 6, 6, 15, 2, 2, 7, 7, 3, 1, 6, 13, 14, 15);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[24];
    ushort16 mask =
        (ushort16)(4, 1, 6, 10, 0, 4, 14, 8, 1, 8, 10, 8, 15, 3, 14, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[25];
    ushort16 mask =
        (ushort16)(0, 11, 4, 6, 1, 10, 6, 8, 7, 10, 2, 7, 12, 15, 5, 11);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[26];
    ushort16 mask =
        (ushort16)(6, 11, 4, 1, 4, 11, 6, 0, 6, 14, 8, 7, 11, 15, 1, 13);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[27];
    ushort16 mask =
        (ushort16)(1, 12, 2, 7, 1, 8, 2, 15, 0, 7, 13, 3, 12, 5, 0, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[28];
    ushort16 mask =
        (ushort16)(5, 10, 10, 8, 2, 0, 2, 8, 1, 6, 2, 4, 10, 14, 10, 12);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[29];
    ushort16 mask =
        (ushort16)(4, 4, 4, 0, 6, 13, 7, 11, 14, 9, 10, 12, 5, 12, 12, 10);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[30];
    ushort16 mask =
        (ushort16)(7, 11, 9, 10, 10, 6, 5, 7, 8, 11, 1, 11, 13, 13, 15, 7);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short16 src1 = source[31];
    ushort16 mask =
        (ushort16)(14, 1, 0, 13, 13, 15, 13, 7, 2, 8, 11, 14, 0, 15, 12, 4);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
