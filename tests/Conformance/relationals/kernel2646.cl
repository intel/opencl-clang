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
        (ulong16)(3, 0, 13, 2, 7, 1, 2, 12, 1, 9, 8, 11, 10, 15, 13, 9);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 mask =
        (ulong16)(9, 6, 0, 9, 15, 2, 8, 15, 3, 11, 6, 1, 5, 11, 8, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 mask =
        (ulong16)(13, 2, 15, 14, 2, 13, 7, 15, 5, 6, 4, 0, 11, 1, 7, 15);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 mask =
        (ulong16)(10, 13, 15, 8, 7, 10, 15, 12, 2, 8, 12, 12, 0, 8, 3, 13);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 mask = (ulong16)(5, 9, 2, 5, 7, 3, 5, 10, 9, 10, 4, 12, 1, 9, 3, 5);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 mask =
        (ulong16)(7, 14, 1, 14, 5, 13, 8, 14, 10, 5, 11, 9, 11, 2, 15, 4);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 mask =
        (ulong16)(1, 15, 10, 8, 2, 13, 13, 13, 7, 9, 9, 0, 15, 13, 5, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 mask =
        (ulong16)(9, 0, 3, 10, 7, 5, 3, 7, 5, 0, 15, 14, 4, 14, 0, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 mask =
        (ulong16)(10, 7, 11, 2, 0, 14, 8, 11, 4, 6, 6, 9, 10, 4, 13, 6);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 mask =
        (ulong16)(5, 10, 14, 4, 7, 9, 12, 2, 0, 3, 12, 4, 13, 2, 4, 9);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 mask =
        (ulong16)(2, 15, 13, 6, 0, 5, 0, 10, 15, 2, 8, 3, 12, 12, 2, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 mask = (ulong16)(9, 6, 6, 5, 2, 0, 8, 8, 3, 9, 0, 6, 14, 13, 1, 8);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 mask = (ulong16)(7, 1, 15, 12, 0, 9, 9, 7, 0, 2, 8, 7, 4, 0, 4, 3);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 mask =
        (ulong16)(7, 11, 11, 13, 9, 8, 9, 9, 4, 11, 12, 1, 0, 1, 14, 12);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 mask =
        (ulong16)(14, 7, 0, 0, 3, 12, 5, 0, 5, 10, 7, 13, 14, 7, 14, 11);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 mask =
        (ulong16)(15, 13, 2, 7, 0, 5, 14, 4, 12, 15, 9, 5, 1, 14, 6, 8);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 mask =
        (ulong16)(1, 2, 11, 1, 9, 14, 13, 6, 10, 0, 3, 1, 12, 8, 14, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 mask =
        (ulong16)(4, 0, 1, 10, 10, 2, 11, 4, 0, 3, 6, 8, 8, 5, 13, 3);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 mask =
        (ulong16)(5, 7, 10, 14, 8, 6, 10, 6, 0, 12, 5, 5, 5, 3, 0, 11);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 mask =
        (ulong16)(7, 12, 3, 7, 9, 14, 3, 12, 14, 2, 2, 10, 7, 6, 3, 9);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 mask =
        (ulong16)(4, 11, 15, 15, 14, 13, 2, 3, 6, 14, 5, 6, 2, 1, 1, 10);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 mask = (ulong16)(3, 7, 7, 6, 9, 0, 3, 0, 1, 9, 3, 9, 6, 6, 7, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 mask =
        (ulong16)(6, 2, 3, 4, 8, 9, 5, 0, 1, 12, 10, 8, 9, 12, 13, 7);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 mask =
        (ulong16)(1, 10, 8, 8, 15, 12, 0, 4, 6, 5, 11, 3, 14, 5, 9, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 mask = (ulong16)(1, 7, 6, 13, 3, 8, 11, 2, 2, 5, 5, 1, 9, 4, 15, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 mask = (ulong16)(8, 7, 3, 3, 8, 9, 12, 9, 3, 6, 3, 8, 1, 13, 12, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 mask =
        (ulong16)(9, 1, 13, 12, 14, 12, 1, 1, 1, 0, 10, 10, 6, 9, 4, 5);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 mask = (ulong16)(6, 4, 6, 6, 14, 7, 2, 3, 0, 1, 6, 2, 0, 9, 9, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 mask =
        (ulong16)(9, 9, 8, 3, 1, 14, 9, 10, 3, 8, 3, 11, 11, 4, 15, 5);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 mask =
        (ulong16)(13, 6, 11, 14, 13, 13, 14, 10, 7, 14, 8, 14, 10, 0, 14, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 mask =
        (ulong16)(1, 13, 6, 13, 0, 5, 3, 4, 14, 12, 14, 7, 7, 14, 7, 9);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 mask =
        (ulong16)(14, 14, 3, 14, 4, 8, 7, 10, 3, 7, 0, 11, 5, 6, 11, 8);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
