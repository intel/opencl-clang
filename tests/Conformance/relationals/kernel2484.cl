// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *source, __global short8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 /*, src2*/;
  short8 tmp;
  tmp = (short8)((short)0);
  {
    short16 src1 = source[0];
    ushort8 mask = (ushort8)(6, 0, 5, 5, 0, 4, 11, 14);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[1];
    ushort8 mask = (ushort8)(7, 5, 5, 13, 2, 0, 7, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[2];
    ushort8 mask = (ushort8)(4, 4, 8, 5, 4, 8, 4, 8);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[3];
    ushort8 mask = (ushort8)(6, 0, 9, 5, 13, 1, 4, 4);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[4];
    ushort8 mask = (ushort8)(5, 2, 10, 0, 15, 12, 3, 10);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[5];
    ushort8 mask = (ushort8)(3, 11, 13, 13, 12, 13, 5, 11);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[6];
    ushort8 mask = (ushort8)(0, 0, 6, 8, 8, 12, 12, 9);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[7];
    ushort8 mask = (ushort8)(10, 5, 10, 2, 12, 14, 12, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[8];
    ushort8 mask = (ushort8)(7, 3, 1, 14, 13, 1, 9, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[9];
    ushort8 mask = (ushort8)(0, 13, 12, 9, 6, 3, 5, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[10];
    ushort8 mask = (ushort8)(8, 13, 10, 14, 14, 9, 0, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[11];
    ushort8 mask = (ushort8)(4, 10, 0, 11, 13, 14, 11, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[12];
    ushort8 mask = (ushort8)(4, 15, 12, 0, 10, 10, 10, 8);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[13];
    ushort8 mask = (ushort8)(12, 2, 2, 11, 9, 0, 8, 2);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[14];
    ushort8 mask = (ushort8)(5, 6, 11, 1, 6, 14, 7, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[15];
    ushort8 mask = (ushort8)(3, 14, 11, 6, 0, 6, 7, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[16];
    ushort8 mask = (ushort8)(8, 14, 4, 5, 2, 7, 5, 15);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[17];
    ushort8 mask = (ushort8)(1, 0, 11, 11, 9, 6, 0, 14);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[18];
    ushort8 mask = (ushort8)(15, 15, 12, 14, 15, 1, 10, 8);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[19];
    ushort8 mask = (ushort8)(15, 1, 12, 0, 4, 6, 12, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[20];
    ushort8 mask = (ushort8)(1, 6, 8, 2, 14, 12, 8, 13);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[21];
    ushort8 mask = (ushort8)(15, 3, 6, 4, 8, 0, 9, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[22];
    ushort8 mask = (ushort8)(15, 13, 11, 13, 9, 5, 1, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[23];
    ushort8 mask = (ushort8)(3, 5, 1, 13, 8, 2, 15, 11);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[24];
    ushort8 mask = (ushort8)(13, 3, 7, 14, 8, 5, 0, 14);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[25];
    ushort8 mask = (ushort8)(13, 8, 6, 11, 0, 13, 14, 15);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[26];
    ushort8 mask = (ushort8)(7, 4, 10, 0, 8, 5, 12, 14);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[27];
    ushort8 mask = (ushort8)(15, 15, 9, 13, 1, 0, 9, 12);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[28];
    ushort8 mask = (ushort8)(0, 10, 5, 10, 1, 7, 4, 2);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[29];
    ushort8 mask = (ushort8)(14, 3, 3, 12, 12, 10, 6, 9);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[30];
    ushort8 mask = (ushort8)(5, 15, 13, 5, 6, 0, 15, 9);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short16 src1 = source[31];
    ushort8 mask = (ushort8)(3, 7, 14, 2, 4, 13, 8, 7);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
