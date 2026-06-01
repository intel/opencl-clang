// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *source, __global long16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 /*, src2*/;
  long16 tmp;
  tmp = (long16)((long)0);
  {
    long16 src1 = source[0];
    ulong16 mask =
        (ulong16)(5, 3, 10, 13, 2, 14, 13, 1, 11, 10, 15, 10, 1, 12, 10, 10);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[1];
    ulong16 mask =
        (ulong16)(7, 12, 5, 9, 9, 1, 3, 9, 2, 5, 14, 7, 11, 6, 2, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[2];
    ulong16 mask =
        (ulong16)(15, 7, 0, 5, 2, 7, 14, 0, 0, 14, 11, 15, 10, 2, 11, 9);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[3];
    ulong16 mask =
        (ulong16)(0, 1, 3, 12, 8, 9, 11, 2, 12, 0, 11, 6, 12, 4, 2, 8);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[4];
    ulong16 mask =
        (ulong16)(9, 1, 9, 6, 10, 6, 11, 3, 1, 10, 1, 11, 4, 12, 5, 11);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[5];
    ulong16 mask =
        (ulong16)(1, 2, 5, 5, 13, 3, 2, 1, 15, 12, 5, 15, 8, 8, 1, 11);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[6];
    ulong16 mask =
        (ulong16)(0, 2, 12, 10, 14, 7, 6, 9, 0, 7, 9, 8, 13, 14, 5, 15);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[7];
    ulong16 mask =
        (ulong16)(8, 9, 5, 1, 14, 8, 9, 9, 2, 1, 7, 9, 14, 13, 11, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[8];
    ulong16 mask =
        (ulong16)(11, 11, 1, 8, 15, 6, 11, 13, 13, 13, 12, 7, 11, 12, 9, 10);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[9];
    ulong16 mask = (ulong16)(3, 4, 1, 2, 10, 2, 3, 3, 4, 1, 6, 5, 3, 0, 12, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[10];
    ulong16 mask =
        (ulong16)(1, 15, 9, 15, 5, 9, 11, 0, 7, 11, 3, 15, 4, 10, 1, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[11];
    ulong16 mask =
        (ulong16)(0, 1, 3, 10, 1, 14, 5, 9, 10, 3, 10, 11, 8, 4, 7, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[12];
    ulong16 mask =
        (ulong16)(4, 7, 5, 9, 13, 11, 10, 3, 11, 3, 0, 7, 14, 10, 4, 3);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[13];
    ulong16 mask =
        (ulong16)(4, 0, 12, 9, 9, 12, 13, 7, 5, 6, 12, 11, 1, 14, 0, 2);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[14];
    ulong16 mask =
        (ulong16)(11, 7, 4, 5, 7, 5, 12, 0, 15, 14, 8, 14, 1, 4, 15, 10);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[15];
    ulong16 mask =
        (ulong16)(12, 6, 0, 13, 1, 2, 15, 7, 14, 7, 11, 10, 0, 6, 7, 3);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[16];
    ulong16 mask =
        (ulong16)(12, 14, 9, 5, 2, 6, 10, 1, 6, 8, 1, 2, 2, 12, 10, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[17];
    ulong16 mask =
        (ulong16)(15, 1, 9, 5, 1, 7, 0, 9, 2, 15, 13, 9, 14, 15, 11, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[18];
    ulong16 mask = (ulong16)(9, 0, 1, 1, 4, 13, 3, 8, 2, 7, 0, 6, 8, 12, 15, 4);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[19];
    ulong16 mask =
        (ulong16)(13, 6, 12, 15, 11, 8, 6, 10, 1, 12, 4, 11, 10, 0, 10, 13);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[20];
    ulong16 mask =
        (ulong16)(14, 5, 5, 1, 8, 13, 6, 15, 4, 1, 9, 14, 10, 9, 12, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[21];
    ulong16 mask =
        (ulong16)(2, 2, 3, 5, 12, 2, 11, 9, 11, 4, 6, 6, 7, 13, 6, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[22];
    ulong16 mask =
        (ulong16)(1, 12, 3, 13, 9, 11, 6, 11, 9, 7, 13, 5, 1, 0, 12, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[23];
    ulong16 mask =
        (ulong16)(8, 11, 15, 12, 10, 9, 9, 15, 1, 2, 15, 9, 14, 1, 13, 8);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[24];
    ulong16 mask =
        (ulong16)(13, 9, 8, 9, 4, 4, 2, 10, 12, 11, 15, 7, 10, 4, 11, 8);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[25];
    ulong16 mask =
        (ulong16)(11, 12, 5, 15, 14, 12, 5, 6, 3, 14, 8, 8, 2, 13, 5, 13);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[26];
    ulong16 mask =
        (ulong16)(6, 0, 6, 13, 3, 7, 15, 11, 5, 5, 12, 5, 8, 14, 0, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[27];
    ulong16 mask =
        (ulong16)(5, 15, 5, 1, 9, 0, 11, 2, 11, 12, 13, 6, 12, 7, 8, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[28];
    ulong16 mask =
        (ulong16)(15, 5, 12, 5, 5, 9, 6, 11, 10, 0, 9, 1, 15, 8, 9, 2);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[29];
    ulong16 mask =
        (ulong16)(0, 11, 15, 6, 8, 5, 12, 13, 0, 10, 2, 7, 9, 10, 3, 15);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[30];
    ulong16 mask =
        (ulong16)(0, 9, 12, 15, 11, 6, 4, 11, 2, 5, 0, 13, 0, 3, 4, 9);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[31];
    ulong16 mask =
        (ulong16)(11, 13, 5, 4, 9, 12, 6, 2, 14, 15, 6, 5, 14, 10, 10, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
