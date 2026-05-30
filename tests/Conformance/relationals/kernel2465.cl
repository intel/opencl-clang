// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short4 *source, __global short2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short4 src1 /*, src2*/;
  short2 tmp;
  tmp = (short2)((short)0);
  {
    short4 src1 = source[0];
    ushort2 mask = (ushort2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[1];
    ushort2 mask = (ushort2)(1, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[2];
    ushort2 mask = (ushort2)(3, 3);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[3];
    ushort2 mask = (ushort2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[4];
    ushort2 mask = (ushort2)(1, 2);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[5];
    ushort2 mask = (ushort2)(3, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[6];
    ushort2 mask = (ushort2)(2, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[7];
    ushort2 mask = (ushort2)(2, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[8];
    ushort2 mask = (ushort2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[9];
    ushort2 mask = (ushort2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[10];
    ushort2 mask = (ushort2)(3, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[11];
    ushort2 mask = (ushort2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[12];
    ushort2 mask = (ushort2)(2, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[13];
    ushort2 mask = (ushort2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[14];
    ushort2 mask = (ushort2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[15];
    ushort2 mask = (ushort2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[16];
    ushort2 mask = (ushort2)(3, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[17];
    ushort2 mask = (ushort2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[18];
    ushort2 mask = (ushort2)(2, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[19];
    ushort2 mask = (ushort2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[20];
    ushort2 mask = (ushort2)(1, 2);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[21];
    ushort2 mask = (ushort2)(2, 1);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[22];
    ushort2 mask = (ushort2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[23];
    ushort2 mask = (ushort2)(1, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[24];
    ushort2 mask = (ushort2)(3, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[25];
    ushort2 mask = (ushort2)(2, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[26];
    ushort2 mask = (ushort2)(0, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[27];
    ushort2 mask = (ushort2)(3, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[28];
    ushort2 mask = (ushort2)(3, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[29];
    ushort2 mask = (ushort2)(3, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[30];
    ushort2 mask = (ushort2)(3, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short4 src1 = source[31];
    ushort2 mask = (ushort2)(2, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
