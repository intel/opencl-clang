// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *source, __global ushort8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 /*, src2*/;
  ushort8 tmp;
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort8 mask = (ushort8)(5, 4, 5, 14, 14, 13, 5, 8);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort8 mask = (ushort8)(12, 1, 14, 12, 14, 15, 6, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort8 mask = (ushort8)(15, 7, 15, 10, 13, 10, 14, 12);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort8 mask = (ushort8)(1, 8, 6, 0, 6, 13, 3, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort8 mask = (ushort8)(5, 7, 4, 14, 10, 6, 4, 9);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort8 mask = (ushort8)(4, 3, 2, 5, 3, 5, 9, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort8 mask = (ushort8)(10, 2, 6, 10, 11, 11, 2, 12);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort8 mask = (ushort8)(8, 9, 10, 3, 10, 2, 8, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort8 mask = (ushort8)(1, 8, 1, 11, 5, 14, 6, 1);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort8 mask = (ushort8)(3, 3, 3, 10, 0, 2, 2, 3);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort8 mask = (ushort8)(0, 8, 7, 7, 11, 15, 12, 5);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort8 mask = (ushort8)(10, 7, 4, 15, 6, 5, 7, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort8 mask = (ushort8)(4, 12, 9, 1, 7, 11, 12, 15);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort8 mask = (ushort8)(14, 11, 6, 6, 14, 5, 8, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort8 mask = (ushort8)(4, 3, 14, 2, 14, 1, 14, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort8 mask = (ushort8)(7, 4, 8, 6, 2, 13, 15, 9);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort8 mask = (ushort8)(0, 8, 13, 0, 3, 12, 5, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort8 mask = (ushort8)(11, 12, 1, 1, 12, 10, 0, 3);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort8 mask = (ushort8)(13, 11, 8, 11, 14, 9, 8, 10);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort8 mask = (ushort8)(3, 11, 3, 1, 7, 1, 15, 12);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort8 mask = (ushort8)(5, 4, 12, 9, 9, 5, 15, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort8 mask = (ushort8)(12, 7, 0, 1, 1, 12, 2, 11);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort8 mask = (ushort8)(7, 5, 13, 5, 13, 10, 8, 11);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort8 mask = (ushort8)(9, 13, 3, 6, 1, 12, 1, 14);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort8 mask = (ushort8)(1, 6, 4, 3, 5, 6, 13, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort8 mask = (ushort8)(14, 3, 2, 5, 11, 15, 9, 10);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort8 mask = (ushort8)(9, 9, 8, 5, 1, 3, 2, 13);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort8 mask = (ushort8)(5, 12, 6, 8, 0, 1, 0, 11);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort8 mask = (ushort8)(1, 11, 1, 3, 14, 14, 3, 6);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort8 mask = (ushort8)(15, 6, 1, 2, 13, 14, 9, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort8 mask = (ushort8)(6, 15, 8, 4, 15, 5, 2, 5);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort8 mask = (ushort8)(7, 5, 15, 11, 10, 13, 15, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
