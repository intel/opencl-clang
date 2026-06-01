// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *source, __global short4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 /*, src2*/;
  short4 tmp;
  tmp = (short4)((short)0);
  {
    short16 src1 = source[0];
    ushort4 mask = (ushort4)(4, 8, 11, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[1];
    ushort4 mask = (ushort4)(2, 7, 13, 7);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[2];
    ushort4 mask = (ushort4)(13, 14, 9, 6);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[3];
    ushort4 mask = (ushort4)(3, 15, 15, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[4];
    ushort4 mask = (ushort4)(3, 14, 4, 9);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[5];
    ushort4 mask = (ushort4)(7, 13, 8, 9);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[6];
    ushort4 mask = (ushort4)(7, 0, 0, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[7];
    ushort4 mask = (ushort4)(13, 14, 0, 13);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[8];
    ushort4 mask = (ushort4)(14, 15, 13, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[9];
    ushort4 mask = (ushort4)(14, 1, 5, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[10];
    ushort4 mask = (ushort4)(2, 3, 0, 3);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[11];
    ushort4 mask = (ushort4)(11, 3, 2, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[12];
    ushort4 mask = (ushort4)(2, 9, 3, 8);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[13];
    ushort4 mask = (ushort4)(4, 1, 3, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[14];
    ushort4 mask = (ushort4)(9, 4, 8, 10);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[15];
    ushort4 mask = (ushort4)(10, 15, 10, 11);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[16];
    ushort4 mask = (ushort4)(13, 10, 0, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[17];
    ushort4 mask = (ushort4)(8, 14, 6, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[18];
    ushort4 mask = (ushort4)(12, 2, 3, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[19];
    ushort4 mask = (ushort4)(9, 2, 4, 13);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[20];
    ushort4 mask = (ushort4)(3, 4, 5, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[21];
    ushort4 mask = (ushort4)(1, 9, 11, 11);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[22];
    ushort4 mask = (ushort4)(14, 15, 0, 12);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[23];
    ushort4 mask = (ushort4)(10, 9, 9, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[24];
    ushort4 mask = (ushort4)(14, 3, 10, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[25];
    ushort4 mask = (ushort4)(6, 5, 9, 5);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[26];
    ushort4 mask = (ushort4)(2, 0, 2, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[27];
    ushort4 mask = (ushort4)(3, 6, 7, 13);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[28];
    ushort4 mask = (ushort4)(4, 14, 1, 6);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[29];
    ushort4 mask = (ushort4)(8, 9, 11, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[30];
    ushort4 mask = (ushort4)(1, 8, 11, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[31];
    ushort4 mask = (ushort4)(0, 11, 11, 7);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
