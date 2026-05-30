// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *source, __global short8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 /*, src2*/;
  short8 tmp;
  tmp = (short8)((short)0);
  {
    short16 src1 = source[0];
    ushort8 mask = (ushort8)(1, 3, 0, 4, 5, 13, 2, 15);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[1];
    ushort8 mask = (ushort8)(7, 1, 3, 14, 0, 5, 11, 5);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[2];
    ushort8 mask = (ushort8)(5, 9, 2, 11, 15, 12, 7, 3);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[3];
    ushort8 mask = (ushort8)(9, 5, 15, 7, 1, 2, 2, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[4];
    ushort8 mask = (ushort8)(11, 5, 8, 4, 6, 10, 1, 11);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[5];
    ushort8 mask = (ushort8)(9, 12, 7, 6, 10, 1, 4, 14);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[6];
    ushort8 mask = (ushort8)(6, 5, 4, 0, 3, 6, 8, 14);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[7];
    ushort8 mask = (ushort8)(13, 3, 0, 15, 7, 10, 12, 14);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[8];
    ushort8 mask = (ushort8)(10, 11, 15, 8, 0, 1, 2, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[9];
    ushort8 mask = (ushort8)(5, 9, 0, 4, 8, 15, 10, 6);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[10];
    ushort8 mask = (ushort8)(6, 7, 6, 7, 14, 2, 9, 13);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[11];
    ushort8 mask = (ushort8)(4, 14, 5, 4, 3, 12, 4, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[12];
    ushort8 mask = (ushort8)(10, 5, 10, 14, 4, 14, 8, 11);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[13];
    ushort8 mask = (ushort8)(13, 12, 4, 7, 0, 8, 4, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[14];
    ushort8 mask = (ushort8)(15, 14, 0, 8, 1, 10, 2, 15);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[15];
    ushort8 mask = (ushort8)(11, 15, 15, 14, 9, 3, 1, 10);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[16];
    ushort8 mask = (ushort8)(7, 8, 12, 4, 2, 6, 4, 12);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[17];
    ushort8 mask = (ushort8)(10, 11, 5, 1, 11, 2, 12, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[18];
    ushort8 mask = (ushort8)(13, 0, 8, 12, 6, 11, 9, 3);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[19];
    ushort8 mask = (ushort8)(2, 0, 3, 12, 13, 4, 13, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[20];
    ushort8 mask = (ushort8)(6, 2, 7, 1, 6, 7, 7, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[21];
    ushort8 mask = (ushort8)(3, 8, 3, 7, 13, 1, 10, 10);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[22];
    ushort8 mask = (ushort8)(15, 15, 2, 11, 14, 12, 12, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[23];
    ushort8 mask = (ushort8)(8, 11, 10, 15, 13, 4, 8, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[24];
    ushort8 mask = (ushort8)(10, 11, 15, 12, 11, 6, 1, 12);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[25];
    ushort8 mask = (ushort8)(11, 2, 15, 7, 6, 9, 0, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[26];
    ushort8 mask = (ushort8)(11, 9, 4, 3, 14, 15, 2, 10);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[27];
    ushort8 mask = (ushort8)(6, 2, 0, 11, 7, 12, 3, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[28];
    ushort8 mask = (ushort8)(9, 0, 11, 1, 4, 4, 2, 4);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[29];
    ushort8 mask = (ushort8)(1, 11, 4, 7, 13, 0, 6, 7);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[30];
    ushort8 mask = (ushort8)(3, 11, 4, 1, 5, 8, 3, 5);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[31];
    ushort8 mask = (ushort8)(8, 4, 9, 2, 12, 4, 11, 5);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
