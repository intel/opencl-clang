// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *source, __global short16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 /*, src2*/;
  short16 tmp;
  tmp = (short16)((short)0);
  {
    short8 src1 = source[0];
    ushort16 mask = (ushort16)(1, 0, 3, 4, 2, 4, 3, 1, 7, 5, 3, 6, 7, 7, 6, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[1];
    ushort16 mask = (ushort16)(2, 4, 2, 3, 2, 4, 4, 0, 5, 4, 7, 5, 7, 7, 4, 2);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[2];
    ushort16 mask = (ushort16)(0, 7, 4, 6, 3, 3, 4, 6, 0, 4, 7, 0, 0, 0, 2, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[3];
    ushort16 mask = (ushort16)(0, 2, 4, 3, 2, 3, 3, 1, 6, 5, 7, 7, 1, 4, 2, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[4];
    ushort16 mask = (ushort16)(3, 2, 0, 2, 3, 1, 2, 1, 7, 1, 1, 4, 5, 2, 1, 7);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[5];
    ushort16 mask = (ushort16)(5, 0, 4, 1, 3, 2, 6, 0, 1, 6, 3, 2, 7, 3, 1, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[6];
    ushort16 mask = (ushort16)(4, 6, 2, 2, 0, 0, 6, 0, 4, 5, 4, 5, 4, 3, 1, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[7];
    ushort16 mask = (ushort16)(4, 4, 0, 7, 5, 7, 0, 1, 1, 1, 2, 2, 2, 2, 6, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[8];
    ushort16 mask = (ushort16)(2, 5, 0, 4, 0, 5, 1, 0, 3, 2, 1, 2, 1, 0, 1, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[9];
    ushort16 mask = (ushort16)(2, 2, 4, 4, 7, 0, 6, 5, 1, 6, 6, 4, 5, 1, 7, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[10];
    ushort16 mask = (ushort16)(3, 0, 6, 1, 5, 5, 2, 0, 3, 0, 6, 2, 6, 0, 1, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[11];
    ushort16 mask = (ushort16)(6, 4, 7, 3, 7, 3, 3, 6, 4, 5, 6, 3, 5, 5, 5, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[12];
    ushort16 mask = (ushort16)(2, 0, 4, 7, 0, 1, 2, 6, 1, 7, 3, 6, 5, 6, 2, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[13];
    ushort16 mask = (ushort16)(1, 0, 6, 1, 7, 4, 3, 6, 1, 3, 2, 7, 3, 7, 6, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[14];
    ushort16 mask = (ushort16)(4, 4, 4, 0, 7, 4, 0, 3, 3, 3, 3, 6, 4, 3, 1, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[15];
    ushort16 mask = (ushort16)(1, 7, 3, 7, 4, 6, 2, 7, 3, 1, 7, 3, 0, 0, 3, 5);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[16];
    ushort16 mask = (ushort16)(3, 6, 5, 5, 2, 1, 6, 0, 3, 6, 0, 1, 5, 5, 0, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[17];
    ushort16 mask = (ushort16)(5, 6, 0, 1, 4, 7, 6, 6, 5, 2, 4, 2, 3, 6, 2, 3);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[18];
    ushort16 mask = (ushort16)(2, 4, 3, 0, 4, 6, 1, 6, 7, 5, 5, 4, 2, 6, 7, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[19];
    ushort16 mask = (ushort16)(6, 4, 4, 2, 2, 6, 2, 6, 0, 2, 2, 3, 1, 7, 4, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[20];
    ushort16 mask = (ushort16)(5, 6, 2, 5, 4, 4, 6, 3, 5, 0, 5, 6, 1, 1, 5, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[21];
    ushort16 mask = (ushort16)(2, 3, 1, 5, 2, 0, 2, 3, 3, 5, 1, 7, 2, 1, 7, 2);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[22];
    ushort16 mask = (ushort16)(1, 5, 1, 1, 0, 2, 5, 5, 4, 1, 3, 3, 0, 5, 7, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[23];
    ushort16 mask = (ushort16)(6, 1, 6, 7, 7, 0, 6, 5, 1, 3, 7, 6, 7, 0, 5, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[24];
    ushort16 mask = (ushort16)(2, 4, 0, 3, 3, 6, 4, 5, 7, 6, 1, 2, 0, 5, 3, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[25];
    ushort16 mask = (ushort16)(6, 7, 2, 7, 5, 1, 7, 3, 6, 3, 0, 2, 3, 7, 0, 6);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[26];
    ushort16 mask = (ushort16)(1, 6, 6, 7, 1, 4, 4, 0, 4, 1, 1, 2, 7, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[27];
    ushort16 mask = (ushort16)(7, 2, 0, 1, 7, 3, 2, 2, 6, 2, 3, 5, 5, 3, 6, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[28];
    ushort16 mask = (ushort16)(4, 3, 3, 0, 3, 2, 0, 6, 0, 7, 5, 0, 3, 6, 1, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[29];
    ushort16 mask = (ushort16)(6, 4, 5, 7, 3, 7, 2, 5, 2, 5, 2, 1, 7, 5, 3, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[30];
    ushort16 mask = (ushort16)(0, 3, 1, 6, 2, 6, 1, 3, 6, 7, 7, 5, 2, 3, 3, 2);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short8 src1 = source[31];
    ushort16 mask = (ushort16)(0, 1, 1, 4, 1, 5, 3, 3, 6, 5, 3, 5, 5, 3, 4, 5);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
