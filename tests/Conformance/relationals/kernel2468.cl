// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short4 *source, __global short8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short4 src1 /*, src2*/;
  short8 tmp;
  tmp = (short8)((short)0);
  {
    short4 src1 = source[0];
    ushort8 mask = (ushort8)(0, 3, 3, 2, 2, 3, 0, 3);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[1];
    ushort8 mask = (ushort8)(1, 2, 0, 3, 2, 3, 2, 2);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[2];
    ushort8 mask = (ushort8)(1, 0, 3, 0, 0, 1, 3, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[3];
    ushort8 mask = (ushort8)(3, 0, 0, 0, 3, 0, 2, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[4];
    ushort8 mask = (ushort8)(3, 3, 3, 1, 0, 2, 0, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[5];
    ushort8 mask = (ushort8)(3, 1, 0, 1, 2, 0, 2, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[6];
    ushort8 mask = (ushort8)(1, 0, 2, 0, 1, 3, 2, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[7];
    ushort8 mask = (ushort8)(2, 2, 1, 2, 0, 2, 3, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[8];
    ushort8 mask = (ushort8)(3, 1, 0, 2, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[9];
    ushort8 mask = (ushort8)(3, 3, 1, 1, 0, 1, 3, 2);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[10];
    ushort8 mask = (ushort8)(0, 0, 2, 1, 0, 1, 2, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[11];
    ushort8 mask = (ushort8)(0, 2, 1, 3, 1, 1, 3, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[12];
    ushort8 mask = (ushort8)(2, 2, 0, 3, 3, 0, 2, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[13];
    ushort8 mask = (ushort8)(0, 1, 0, 1, 0, 2, 0, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[14];
    ushort8 mask = (ushort8)(1, 2, 2, 0, 2, 1, 3, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[15];
    ushort8 mask = (ushort8)(3, 3, 3, 0, 2, 2, 0, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[16];
    ushort8 mask = (ushort8)(2, 2, 1, 1, 3, 2, 1, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[17];
    ushort8 mask = (ushort8)(0, 2, 2, 2, 3, 1, 0, 3);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[18];
    ushort8 mask = (ushort8)(1, 2, 1, 1, 3, 2, 0, 3);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[19];
    ushort8 mask = (ushort8)(1, 0, 1, 1, 3, 3, 1, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[20];
    ushort8 mask = (ushort8)(0, 2, 0, 0, 1, 0, 0, 2);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[21];
    ushort8 mask = (ushort8)(2, 0, 0, 3, 2, 0, 2, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[22];
    ushort8 mask = (ushort8)(3, 0, 3, 1, 2, 2, 0, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[23];
    ushort8 mask = (ushort8)(0, 1, 3, 0, 1, 3, 0, 0);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[24];
    ushort8 mask = (ushort8)(3, 2, 2, 2, 3, 1, 2, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[25];
    ushort8 mask = (ushort8)(3, 2, 2, 0, 0, 2, 3, 2);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[26];
    ushort8 mask = (ushort8)(0, 2, 0, 0, 3, 1, 3, 2);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[27];
    ushort8 mask = (ushort8)(3, 0, 1, 2, 1, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[28];
    ushort8 mask = (ushort8)(0, 0, 0, 2, 1, 2, 0, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[29];
    ushort8 mask = (ushort8)(2, 0, 0, 0, 3, 0, 3, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[30];
    ushort8 mask = (ushort8)(1, 1, 0, 2, 0, 2, 1, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short8)((short)0);
  {
    short4 src1 = source[31];
    ushort8 mask = (ushort8)(3, 1, 3, 3, 3, 1, 1, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
