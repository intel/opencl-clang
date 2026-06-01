// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *source, __global short8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 /*, src2*/;
  short8 tmp;
  tmp = (short8)((short)0);
  {
    short8 src1 = source[0];
    ushort8 mask = (ushort8)(7, 0, 3, 5, 3, 3, 7, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[1];
    ushort8 mask = (ushort8)(3, 3, 4, 5, 5, 7, 1, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[2];
    ushort8 mask = (ushort8)(2, 1, 5, 6, 6, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[3];
    ushort8 mask = (ushort8)(2, 2, 0, 5, 3, 2, 7, 7);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[4];
    ushort8 mask = (ushort8)(3, 4, 6, 0, 0, 2, 4, 2);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[5];
    ushort8 mask = (ushort8)(7, 4, 7, 0, 4, 7, 0, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[6];
    ushort8 mask = (ushort8)(6, 7, 5, 7, 0, 2, 6, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[7];
    ushort8 mask = (ushort8)(5, 5, 0, 3, 4, 2, 4, 5);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[8];
    ushort8 mask = (ushort8)(7, 1, 3, 1, 4, 2, 4, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[9];
    ushort8 mask = (ushort8)(4, 1, 6, 0, 7, 4, 7, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[10];
    ushort8 mask = (ushort8)(1, 2, 6, 6, 2, 0, 0, 5);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[11];
    ushort8 mask = (ushort8)(4, 3, 0, 3, 3, 3, 5, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[12];
    ushort8 mask = (ushort8)(6, 6, 2, 1, 6, 1, 0, 5);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[13];
    ushort8 mask = (ushort8)(4, 2, 2, 6, 4, 4, 1, 4);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[14];
    ushort8 mask = (ushort8)(1, 1, 6, 2, 6, 2, 6, 6);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[15];
    ushort8 mask = (ushort8)(3, 2, 5, 6, 3, 7, 1, 3);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[16];
    ushort8 mask = (ushort8)(0, 6, 7, 7, 5, 2, 6, 5);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[17];
    ushort8 mask = (ushort8)(0, 6, 7, 3, 1, 4, 6, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[18];
    ushort8 mask = (ushort8)(6, 7, 5, 3, 5, 3, 1, 4);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[19];
    ushort8 mask = (ushort8)(5, 4, 0, 6, 6, 5, 1, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[20];
    ushort8 mask = (ushort8)(3, 6, 7, 0, 6, 1, 0, 5);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[21];
    ushort8 mask = (ushort8)(3, 6, 4, 3, 6, 5, 4, 4);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[22];
    ushort8 mask = (ushort8)(0, 3, 3, 2, 5, 0, 7, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[23];
    ushort8 mask = (ushort8)(3, 2, 7, 3, 4, 4, 3, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[24];
    ushort8 mask = (ushort8)(3, 5, 4, 1, 3, 5, 3, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[25];
    ushort8 mask = (ushort8)(7, 1, 3, 2, 6, 1, 4, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[26];
    ushort8 mask = (ushort8)(1, 2, 7, 4, 7, 2, 1, 6);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[27];
    ushort8 mask = (ushort8)(7, 0, 1, 4, 4, 1, 7, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[28];
    ushort8 mask = (ushort8)(4, 6, 1, 3, 2, 3, 5, 7);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[29];
    ushort8 mask = (ushort8)(5, 3, 4, 4, 2, 2, 1, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[30];
    ushort8 mask = (ushort8)(5, 3, 1, 6, 1, 4, 1, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short8 src1 = source[31];
    ushort8 mask = (ushort8)(5, 2, 5, 1, 7, 5, 2, 6);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
