// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *source, __global ulong8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 /*, src2*/;
  ulong8 tmp;
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong8 mask = (ulong8)(11, 13, 3, 3, 6, 14, 15, 14);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong8 mask = (ulong8)(15, 14, 10, 1, 10, 13, 3, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong8 mask = (ulong8)(2, 0, 1, 9, 5, 8, 5, 13);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong8 mask = (ulong8)(7, 13, 4, 6, 8, 2, 3, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong8 mask = (ulong8)(2, 1, 6, 4, 15, 1, 3, 14);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong8 mask = (ulong8)(13, 2, 7, 2, 13, 1, 11, 11);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong8 mask = (ulong8)(0, 5, 15, 4, 0, 4, 11, 10);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong8 mask = (ulong8)(13, 12, 4, 0, 2, 8, 10, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong8 mask = (ulong8)(15, 13, 13, 15, 1, 0, 13, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong8 mask = (ulong8)(5, 7, 13, 1, 0, 3, 9, 6);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong8 mask = (ulong8)(8, 1, 0, 15, 8, 10, 3, 11);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong8 mask = (ulong8)(0, 11, 8, 5, 5, 3, 12, 14);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong8 mask = (ulong8)(13, 15, 1, 1, 6, 0, 6, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong8 mask = (ulong8)(3, 10, 9, 3, 11, 9, 1, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong8 mask = (ulong8)(8, 12, 7, 3, 4, 11, 4, 6);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong8 mask = (ulong8)(5, 9, 7, 2, 4, 10, 8, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong8 mask = (ulong8)(12, 7, 6, 11, 1, 2, 10, 8);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong8 mask = (ulong8)(11, 7, 4, 8, 13, 9, 4, 11);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong8 mask = (ulong8)(11, 11, 3, 4, 6, 11, 12, 9);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong8 mask = (ulong8)(4, 9, 11, 0, 5, 12, 15, 13);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong8 mask = (ulong8)(4, 11, 1, 15, 6, 1, 11, 10);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong8 mask = (ulong8)(15, 2, 10, 10, 8, 5, 12, 13);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong8 mask = (ulong8)(9, 5, 10, 1, 8, 14, 4, 9);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong8 mask = (ulong8)(12, 13, 7, 8, 6, 11, 0, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong8 mask = (ulong8)(5, 9, 14, 3, 0, 5, 2, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong8 mask = (ulong8)(11, 5, 10, 14, 9, 5, 8, 8);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong8 mask = (ulong8)(9, 2, 10, 7, 8, 6, 10, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong8 mask = (ulong8)(0, 13, 7, 6, 6, 3, 12, 7);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong8 mask = (ulong8)(3, 14, 12, 9, 8, 1, 10, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong8 mask = (ulong8)(0, 11, 13, 9, 8, 11, 9, 7);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong8 mask = (ulong8)(3, 10, 13, 7, 4, 14, 13, 10);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong8 mask = (ulong8)(14, 14, 12, 0, 15, 15, 2, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
