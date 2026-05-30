// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *source, __global short4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 /*, src2*/;
  short4 tmp;
  tmp = (short4)((short)0);
  {
    short16 src1 = source[0];
    ushort4 mask = (ushort4)(15, 8, 7, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[1];
    ushort4 mask = (ushort4)(1, 11, 4, 10);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[2];
    ushort4 mask = (ushort4)(2, 13, 8, 12);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[3];
    ushort4 mask = (ushort4)(2, 14, 15, 12);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[4];
    ushort4 mask = (ushort4)(6, 15, 6, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[5];
    ushort4 mask = (ushort4)(1, 14, 9, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[6];
    ushort4 mask = (ushort4)(1, 8, 4, 12);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[7];
    ushort4 mask = (ushort4)(4, 4, 1, 8);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[8];
    ushort4 mask = (ushort4)(13, 10, 1, 10);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[9];
    ushort4 mask = (ushort4)(7, 14, 4, 11);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[10];
    ushort4 mask = (ushort4)(3, 2, 3, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[11];
    ushort4 mask = (ushort4)(10, 9, 12, 9);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[12];
    ushort4 mask = (ushort4)(6, 14, 5, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[13];
    ushort4 mask = (ushort4)(11, 13, 4, 9);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[14];
    ushort4 mask = (ushort4)(13, 11, 4, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[15];
    ushort4 mask = (ushort4)(0, 10, 7, 9);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[16];
    ushort4 mask = (ushort4)(4, 10, 7, 6);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[17];
    ushort4 mask = (ushort4)(4, 4, 15, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[18];
    ushort4 mask = (ushort4)(15, 2, 9, 4);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[19];
    ushort4 mask = (ushort4)(14, 3, 5, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[20];
    ushort4 mask = (ushort4)(12, 0, 12, 9);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[21];
    ushort4 mask = (ushort4)(5, 11, 11, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[22];
    ushort4 mask = (ushort4)(1, 6, 3, 6);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[23];
    ushort4 mask = (ushort4)(3, 11, 10, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[24];
    ushort4 mask = (ushort4)(3, 6, 4, 2);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[25];
    ushort4 mask = (ushort4)(4, 9, 15, 4);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[26];
    ushort4 mask = (ushort4)(15, 6, 13, 9);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[27];
    ushort4 mask = (ushort4)(7, 14, 7, 11);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[28];
    ushort4 mask = (ushort4)(5, 10, 7, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[29];
    ushort4 mask = (ushort4)(2, 2, 4, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[30];
    ushort4 mask = (ushort4)(2, 12, 14, 12);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[31];
    ushort4 mask = (ushort4)(11, 7, 2, 4);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
