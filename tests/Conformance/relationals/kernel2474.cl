// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *source, __global short4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 /*, src2*/;
  short4 tmp;
  tmp = (short4)((short)0);
  {
    short8 src1 = source[0];
    ushort4 mask = (ushort4)(7, 2, 0, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[1];
    ushort4 mask = (ushort4)(5, 4, 6, 6);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[2];
    ushort4 mask = (ushort4)(2, 7, 4, 5);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[3];
    ushort4 mask = (ushort4)(0, 0, 2, 4);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[4];
    ushort4 mask = (ushort4)(1, 5, 5, 4);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[5];
    ushort4 mask = (ushort4)(0, 7, 3, 0);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[6];
    ushort4 mask = (ushort4)(4, 3, 7, 4);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[7];
    ushort4 mask = (ushort4)(7, 4, 0, 4);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[8];
    ushort4 mask = (ushort4)(4, 3, 3, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[9];
    ushort4 mask = (ushort4)(4, 4, 5, 3);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[10];
    ushort4 mask = (ushort4)(2, 6, 6, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[11];
    ushort4 mask = (ushort4)(7, 0, 7, 6);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[12];
    ushort4 mask = (ushort4)(6, 6, 4, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[13];
    ushort4 mask = (ushort4)(3, 0, 5, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[14];
    ushort4 mask = (ushort4)(6, 4, 0, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[15];
    ushort4 mask = (ushort4)(0, 3, 3, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[16];
    ushort4 mask = (ushort4)(6, 4, 1, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[17];
    ushort4 mask = (ushort4)(1, 0, 7, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[18];
    ushort4 mask = (ushort4)(7, 5, 2, 6);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[19];
    ushort4 mask = (ushort4)(6, 2, 6, 3);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[20];
    ushort4 mask = (ushort4)(7, 1, 1, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[21];
    ushort4 mask = (ushort4)(7, 1, 0, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[22];
    ushort4 mask = (ushort4)(5, 5, 5, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[23];
    ushort4 mask = (ushort4)(7, 3, 1, 0);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[24];
    ushort4 mask = (ushort4)(1, 3, 4, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[25];
    ushort4 mask = (ushort4)(7, 7, 2, 4);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[26];
    ushort4 mask = (ushort4)(6, 1, 2, 6);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[27];
    ushort4 mask = (ushort4)(2, 4, 5, 5);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[28];
    ushort4 mask = (ushort4)(6, 7, 0, 5);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[29];
    ushort4 mask = (ushort4)(4, 1, 4, 7);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[30];
    ushort4 mask = (ushort4)(3, 6, 6, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[31];
    ushort4 mask = (ushort4)(2, 5, 4, 5);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
