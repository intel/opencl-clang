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
        (ulong16)(13, 11, 1, 9, 12, 8, 12, 13, 3, 1, 0, 2, 9, 2, 0, 6);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[1];
    ulong16 mask =
        (ulong16)(6, 12, 10, 8, 0, 7, 5, 8, 14, 12, 13, 6, 7, 4, 1, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[2];
    ulong16 mask =
        (ulong16)(9, 12, 5, 13, 10, 12, 8, 0, 7, 13, 11, 11, 6, 12, 10, 14);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[3];
    ulong16 mask =
        (ulong16)(3, 1, 4, 6, 1, 14, 13, 2, 7, 8, 12, 4, 14, 15, 15, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[4];
    ulong16 mask =
        (ulong16)(7, 14, 12, 6, 9, 9, 12, 14, 14, 6, 8, 14, 5, 10, 1, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[5];
    ulong16 mask =
        (ulong16)(15, 2, 6, 9, 7, 12, 12, 1, 14, 6, 12, 10, 1, 1, 14, 14);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[6];
    ulong16 mask =
        (ulong16)(12, 7, 9, 8, 8, 2, 6, 7, 15, 5, 12, 0, 15, 9, 13, 4);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[7];
    ulong16 mask =
        (ulong16)(8, 9, 6, 14, 12, 5, 11, 12, 14, 12, 5, 1, 12, 13, 10, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[8];
    ulong16 mask =
        (ulong16)(0, 13, 4, 9, 11, 1, 10, 3, 11, 1, 6, 12, 10, 12, 13, 1);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[9];
    ulong16 mask =
        (ulong16)(11, 14, 14, 9, 1, 6, 14, 12, 7, 8, 0, 14, 15, 10, 5, 12);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[10];
    ulong16 mask = (ulong16)(1, 7, 5, 11, 10, 0, 8, 0, 9, 3, 9, 10, 7, 6, 3, 1);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[11];
    ulong16 mask =
        (ulong16)(12, 6, 4, 11, 11, 10, 4, 3, 2, 10, 15, 8, 8, 15, 12, 15);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[12];
    ulong16 mask =
        (ulong16)(2, 1, 12, 14, 10, 1, 14, 0, 1, 4, 9, 10, 14, 10, 15, 7);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[13];
    ulong16 mask =
        (ulong16)(1, 2, 10, 15, 6, 7, 10, 7, 12, 12, 13, 3, 12, 7, 12, 8);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[14];
    ulong16 mask =
        (ulong16)(1, 9, 14, 2, 6, 0, 6, 11, 11, 0, 3, 15, 1, 5, 3, 10);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[15];
    ulong16 mask =
        (ulong16)(3, 11, 7, 8, 13, 5, 7, 1, 6, 15, 6, 10, 7, 6, 13, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[16];
    ulong16 mask =
        (ulong16)(0, 15, 3, 5, 13, 0, 7, 13, 11, 13, 10, 7, 10, 4, 7, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[17];
    ulong16 mask =
        (ulong16)(15, 2, 5, 7, 10, 13, 2, 15, 2, 7, 13, 8, 12, 13, 15, 11);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[18];
    ulong16 mask =
        (ulong16)(4, 0, 8, 12, 4, 10, 15, 12, 6, 1, 3, 12, 11, 5, 2, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[19];
    ulong16 mask =
        (ulong16)(7, 1, 13, 11, 9, 15, 13, 7, 8, 13, 1, 13, 13, 3, 5, 4);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[20];
    ulong16 mask =
        (ulong16)(11, 10, 10, 8, 8, 8, 13, 12, 14, 1, 11, 10, 7, 7, 1, 9);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[21];
    ulong16 mask =
        (ulong16)(7, 2, 9, 3, 2, 15, 7, 5, 6, 3, 1, 10, 6, 6, 15, 13);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[22];
    ulong16 mask =
        (ulong16)(6, 11, 2, 5, 14, 12, 1, 4, 11, 9, 5, 14, 4, 11, 14, 13);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[23];
    ulong16 mask =
        (ulong16)(4, 9, 2, 15, 10, 3, 1, 2, 2, 9, 7, 6, 6, 4, 10, 12);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[24];
    ulong16 mask =
        (ulong16)(15, 2, 8, 11, 3, 6, 6, 15, 2, 10, 4, 13, 15, 1, 11, 12);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[25];
    ulong16 mask =
        (ulong16)(9, 3, 11, 3, 13, 3, 1, 2, 14, 4, 14, 0, 9, 4, 4, 10);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[26];
    ulong16 mask = (ulong16)(0, 3, 9, 0, 8, 9, 5, 6, 0, 14, 4, 2, 2, 0, 4, 15);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[27];
    ulong16 mask =
        (ulong16)(9, 9, 0, 4, 9, 7, 5, 4, 1, 1, 6, 12, 12, 12, 15, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[28];
    ulong16 mask =
        (ulong16)(10, 11, 15, 14, 7, 2, 7, 12, 3, 11, 7, 11, 14, 13, 2, 15);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[29];
    ulong16 mask = (ulong16)(5, 2, 6, 1, 9, 14, 1, 4, 7, 3, 11, 0, 4, 6, 6, 11);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[30];
    ulong16 mask = (ulong16)(1, 9, 8, 1, 0, 1, 5, 9, 3, 15, 4, 2, 9, 6, 15, 8);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long16 src1 = source[31];
    ulong16 mask =
        (ulong16)(5, 10, 10, 1, 0, 0, 7, 12, 1, 9, 15, 0, 11, 0, 6, 10);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
