// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *source, __global ushort8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 /*, src2*/;
  ushort8 tmp;
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort8 mask = (ushort8)(0, 1, 7, 4, 9, 15, 2, 12);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort8 mask = (ushort8)(5, 4, 6, 5, 5, 4, 9, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort8 mask = (ushort8)(8, 3, 8, 15, 4, 3, 12, 3);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort8 mask = (ushort8)(15, 3, 12, 13, 1, 8, 15, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort8 mask = (ushort8)(10, 1, 1, 0, 15, 8, 9, 5);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort8 mask = (ushort8)(0, 12, 3, 4, 8, 0, 15, 15);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort8 mask = (ushort8)(0, 11, 7, 1, 1, 15, 6, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort8 mask = (ushort8)(2, 3, 13, 11, 4, 7, 12, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort8 mask = (ushort8)(1, 10, 15, 5, 8, 11, 3, 9);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort8 mask = (ushort8)(12, 8, 9, 5, 3, 7, 10, 9);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort8 mask = (ushort8)(10, 7, 15, 11, 11, 12, 10, 10);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort8 mask = (ushort8)(4, 4, 12, 7, 1, 1, 1, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort8 mask = (ushort8)(2, 10, 9, 13, 3, 1, 0, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort8 mask = (ushort8)(9, 5, 4, 6, 10, 12, 7, 6);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort8 mask = (ushort8)(13, 8, 0, 11, 9, 6, 7, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort8 mask = (ushort8)(10, 4, 9, 4, 15, 1, 4, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort8 mask = (ushort8)(10, 6, 12, 13, 8, 2, 4, 10);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort8 mask = (ushort8)(5, 8, 7, 10, 1, 4, 5, 13);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort8 mask = (ushort8)(1, 4, 7, 3, 3, 6, 9, 10);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort8 mask = (ushort8)(13, 6, 3, 12, 6, 8, 2, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort8 mask = (ushort8)(7, 11, 7, 10, 7, 11, 15, 2);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort8 mask = (ushort8)(0, 12, 5, 4, 10, 5, 3, 12);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort8 mask = (ushort8)(11, 1, 2, 5, 7, 13, 10, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort8 mask = (ushort8)(1, 15, 14, 5, 5, 9, 14, 11);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort8 mask = (ushort8)(11, 3, 2, 5, 14, 14, 5, 11);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort8 mask = (ushort8)(7, 0, 11, 0, 14, 10, 5, 15);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort8 mask = (ushort8)(14, 0, 2, 5, 14, 0, 12, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort8 mask = (ushort8)(5, 6, 4, 11, 12, 8, 5, 7);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort8 mask = (ushort8)(11, 14, 10, 14, 9, 5, 4, 13);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort8 mask = (ushort8)(10, 2, 8, 15, 0, 14, 14, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort8 mask = (ushort8)(7, 12, 14, 5, 0, 15, 12, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort8 mask = (ushort8)(15, 8, 5, 14, 9, 7, 0, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
