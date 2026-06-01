// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *source, __global long8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 /*, src2*/;
  long8 tmp;
  tmp = (long8)((long)0);
  {
    long16 src1 = source[0];
    ulong8 mask = (ulong8)(15, 12, 0, 15, 5, 3, 8, 10);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[1];
    ulong8 mask = (ulong8)(3, 6, 14, 5, 11, 8, 9, 7);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[2];
    ulong8 mask = (ulong8)(6, 8, 7, 13, 6, 0, 11, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[3];
    ulong8 mask = (ulong8)(0, 15, 6, 8, 9, 6, 3, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[4];
    ulong8 mask = (ulong8)(13, 7, 10, 12, 7, 0, 15, 7);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[5];
    ulong8 mask = (ulong8)(13, 2, 9, 14, 10, 3, 0, 9);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[6];
    ulong8 mask = (ulong8)(15, 15, 7, 6, 11, 0, 2, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[7];
    ulong8 mask = (ulong8)(0, 1, 12, 8, 9, 12, 10, 13);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[8];
    ulong8 mask = (ulong8)(11, 14, 9, 13, 14, 8, 1, 11);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[9];
    ulong8 mask = (ulong8)(1, 13, 8, 1, 0, 15, 7, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[10];
    ulong8 mask = (ulong8)(8, 11, 13, 11, 9, 6, 15, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[11];
    ulong8 mask = (ulong8)(0, 7, 6, 1, 3, 0, 2, 8);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[12];
    ulong8 mask = (ulong8)(2, 3, 8, 11, 15, 3, 2, 11);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[13];
    ulong8 mask = (ulong8)(12, 3, 4, 10, 11, 15, 2, 10);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[14];
    ulong8 mask = (ulong8)(1, 3, 0, 1, 4, 0, 1, 14);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[15];
    ulong8 mask = (ulong8)(5, 10, 3, 14, 12, 8, 10, 5);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[16];
    ulong8 mask = (ulong8)(10, 7, 0, 1, 8, 3, 0, 5);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[17];
    ulong8 mask = (ulong8)(11, 4, 0, 1, 7, 10, 7, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[18];
    ulong8 mask = (ulong8)(6, 2, 9, 8, 8, 3, 3, 7);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[19];
    ulong8 mask = (ulong8)(1, 7, 1, 0, 5, 4, 12, 11);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[20];
    ulong8 mask = (ulong8)(7, 3, 8, 15, 11, 15, 8, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[21];
    ulong8 mask = (ulong8)(1, 1, 12, 9, 5, 4, 10, 10);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[22];
    ulong8 mask = (ulong8)(8, 2, 9, 3, 6, 13, 6, 14);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[23];
    ulong8 mask = (ulong8)(14, 13, 2, 2, 5, 0, 12, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[24];
    ulong8 mask = (ulong8)(13, 6, 10, 15, 5, 13, 14, 13);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[25];
    ulong8 mask = (ulong8)(12, 4, 11, 3, 9, 5, 7, 11);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[26];
    ulong8 mask = (ulong8)(12, 14, 7, 0, 9, 7, 7, 6);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[27];
    ulong8 mask = (ulong8)(5, 13, 8, 13, 2, 11, 13, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[28];
    ulong8 mask = (ulong8)(14, 1, 4, 5, 9, 4, 1, 6);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[29];
    ulong8 mask = (ulong8)(12, 12, 15, 9, 15, 14, 15, 5);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[30];
    ulong8 mask = (ulong8)(12, 2, 8, 12, 7, 3, 7, 10);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[31];
    ulong8 mask = (ulong8)(0, 14, 11, 9, 11, 13, 0, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
