// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *source, __global ulong16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 /*, src2*/;
  ulong16 tmp;
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong16 mask =
        (ulong16)(4, 11, 0, 12, 15, 0, 15, 8, 9, 0, 15, 13, 13, 8, 0, 15);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 mask =
        (ulong16)(10, 0, 9, 3, 3, 14, 13, 15, 3, 14, 5, 11, 6, 14, 12, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 mask =
        (ulong16)(0, 11, 11, 2, 0, 8, 2, 4, 13, 4, 1, 13, 5, 6, 2, 6);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 mask =
        (ulong16)(10, 8, 0, 14, 2, 8, 15, 12, 7, 13, 10, 3, 0, 11, 9, 10);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 mask = (ulong16)(15, 3, 9, 4, 6, 14, 0, 4, 4, 2, 5, 4, 4, 9, 4, 7);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 mask =
        (ulong16)(8, 4, 2, 2, 1, 12, 2, 0, 1, 10, 14, 12, 8, 2, 12, 9);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 mask =
        (ulong16)(6, 13, 6, 4, 5, 7, 6, 13, 8, 3, 3, 14, 9, 11, 3, 11);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 mask =
        (ulong16)(7, 14, 13, 12, 7, 6, 7, 6, 10, 15, 13, 7, 12, 7, 9, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 mask =
        (ulong16)(12, 7, 2, 5, 9, 8, 0, 6, 11, 14, 2, 7, 6, 10, 10, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 mask =
        (ulong16)(1, 4, 2, 12, 15, 15, 10, 9, 8, 14, 6, 4, 9, 10, 6, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 mask = (ulong16)(1, 7, 1, 9, 3, 6, 12, 15, 1, 2, 4, 14, 3, 3, 9, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 mask =
        (ulong16)(10, 6, 5, 6, 10, 13, 7, 8, 15, 13, 8, 13, 8, 9, 0, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 mask =
        (ulong16)(11, 0, 3, 2, 9, 14, 11, 12, 10, 2, 1, 11, 10, 5, 15, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 mask =
        (ulong16)(7, 4, 1, 6, 14, 12, 6, 0, 0, 4, 14, 5, 0, 2, 7, 12);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 mask =
        (ulong16)(5, 0, 3, 5, 3, 10, 3, 1, 3, 10, 14, 9, 13, 8, 6, 15);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 mask =
        (ulong16)(8, 0, 9, 12, 1, 13, 6, 4, 15, 4, 1, 13, 10, 6, 1, 15);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 mask =
        (ulong16)(15, 8, 9, 15, 1, 2, 3, 8, 11, 7, 11, 15, 2, 2, 3, 6);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 mask =
        (ulong16)(0, 10, 3, 8, 8, 2, 9, 13, 0, 10, 9, 13, 9, 7, 1, 14);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 mask =
        (ulong16)(3, 5, 12, 9, 3, 8, 9, 8, 15, 6, 5, 2, 2, 11, 10, 9);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 mask = (ulong16)(0, 7, 4, 7, 15, 13, 3, 2, 9, 8, 6, 2, 11, 1, 7, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 mask =
        (ulong16)(14, 15, 3, 2, 12, 7, 4, 14, 11, 13, 0, 6, 4, 3, 12, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 mask =
        (ulong16)(9, 9, 0, 6, 3, 12, 0, 15, 14, 7, 12, 7, 3, 13, 6, 2);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 mask =
        (ulong16)(4, 15, 8, 12, 2, 12, 13, 4, 12, 0, 0, 13, 15, 14, 14, 6);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 mask =
        (ulong16)(0, 5, 13, 2, 13, 1, 4, 6, 6, 2, 15, 7, 5, 13, 13, 9);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 mask =
        (ulong16)(12, 3, 7, 7, 3, 6, 5, 11, 4, 12, 15, 4, 6, 1, 14, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 mask =
        (ulong16)(11, 3, 9, 13, 10, 8, 15, 4, 3, 13, 11, 2, 10, 12, 1, 5);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 mask =
        (ulong16)(3, 5, 6, 13, 3, 7, 8, 3, 6, 14, 3, 13, 2, 0, 13, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 mask =
        (ulong16)(6, 8, 10, 12, 12, 6, 11, 12, 11, 2, 15, 3, 8, 5, 14, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 mask =
        (ulong16)(1, 0, 5, 15, 10, 10, 15, 14, 13, 13, 5, 10, 7, 1, 2, 2);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 mask =
        (ulong16)(13, 4, 12, 10, 6, 13, 6, 2, 2, 12, 14, 9, 3, 9, 9, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 mask =
        (ulong16)(3, 3, 1, 7, 11, 11, 7, 15, 15, 2, 9, 2, 14, 14, 10, 9);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 mask =
        (ulong16)(2, 11, 1, 5, 12, 0, 14, 2, 11, 13, 7, 5, 3, 5, 7, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
