// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *source, __global ulong8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 /*, src2*/;
  ulong8 tmp;
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong8 mask = (ulong8)(7, 12, 14, 14, 12, 2, 8, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong8 mask = (ulong8)(6, 9, 10, 15, 2, 0, 0, 8);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong8 mask = (ulong8)(13, 4, 11, 7, 14, 13, 9, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong8 mask = (ulong8)(13, 14, 9, 6, 3, 8, 11, 9);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong8 mask = (ulong8)(14, 1, 15, 8, 3, 8, 13, 13);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong8 mask = (ulong8)(10, 1, 10, 8, 13, 0, 3, 13);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong8 mask = (ulong8)(7, 9, 12, 3, 6, 12, 4, 7);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong8 mask = (ulong8)(0, 1, 9, 6, 5, 8, 6, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong8 mask = (ulong8)(7, 5, 11, 0, 13, 1, 2, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong8 mask = (ulong8)(7, 13, 9, 4, 6, 2, 12, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong8 mask = (ulong8)(14, 2, 8, 4, 13, 3, 9, 15);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong8 mask = (ulong8)(8, 15, 13, 5, 11, 10, 10, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong8 mask = (ulong8)(12, 14, 8, 0, 2, 5, 13, 3);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong8 mask = (ulong8)(8, 13, 14, 4, 15, 3, 10, 6);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong8 mask = (ulong8)(4, 6, 9, 12, 5, 4, 4, 14);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong8 mask = (ulong8)(7, 8, 6, 9, 9, 12, 13, 13);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong8 mask = (ulong8)(5, 4, 7, 13, 13, 2, 3, 13);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong8 mask = (ulong8)(2, 10, 8, 2, 13, 14, 5, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong8 mask = (ulong8)(10, 12, 0, 9, 14, 11, 9, 5);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong8 mask = (ulong8)(4, 11, 1, 11, 3, 4, 10, 9);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong8 mask = (ulong8)(10, 3, 11, 4, 13, 1, 8, 9);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong8 mask = (ulong8)(3, 5, 15, 7, 1, 2, 4, 15);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong8 mask = (ulong8)(11, 2, 9, 15, 8, 11, 1, 8);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong8 mask = (ulong8)(15, 13, 2, 2, 5, 5, 6, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong8 mask = (ulong8)(3, 8, 4, 13, 11, 12, 12, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong8 mask = (ulong8)(9, 4, 13, 6, 11, 15, 7, 15);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong8 mask = (ulong8)(9, 10, 7, 1, 15, 13, 7, 7);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong8 mask = (ulong8)(0, 1, 0, 8, 6, 9, 1, 2);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong8 mask = (ulong8)(14, 10, 15, 4, 1, 7, 8, 13);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong8 mask = (ulong8)(5, 10, 14, 15, 0, 11, 15, 8);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong8 mask = (ulong8)(13, 9, 1, 0, 13, 12, 10, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong8 mask = (ulong8)(4, 7, 9, 4, 3, 15, 3, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
