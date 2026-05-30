// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *source, __global long8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 /*, src2*/;
  long8 tmp;
  tmp = (long8)((long)0);
  {
    long16 src1 = source[0];
    ulong8 mask = (ulong8)(9, 13, 4, 1, 0, 6, 14, 8);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[1];
    ulong8 mask = (ulong8)(5, 10, 12, 15, 13, 4, 10, 14);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[2];
    ulong8 mask = (ulong8)(10, 8, 2, 12, 6, 12, 8, 10);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[3];
    ulong8 mask = (ulong8)(14, 4, 8, 13, 7, 15, 6, 12);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[4];
    ulong8 mask = (ulong8)(13, 10, 14, 11, 1, 3, 6, 15);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[5];
    ulong8 mask = (ulong8)(15, 7, 6, 9, 3, 14, 12, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[6];
    ulong8 mask = (ulong8)(6, 12, 12, 2, 9, 12, 5, 14);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[7];
    ulong8 mask = (ulong8)(3, 14, 2, 6, 1, 3, 9, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[8];
    ulong8 mask = (ulong8)(4, 4, 11, 6, 2, 0, 0, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[9];
    ulong8 mask = (ulong8)(5, 3, 13, 11, 8, 2, 3, 2);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[10];
    ulong8 mask = (ulong8)(2, 9, 0, 1, 7, 13, 0, 7);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[11];
    ulong8 mask = (ulong8)(3, 9, 8, 0, 0, 0, 3, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[12];
    ulong8 mask = (ulong8)(0, 3, 8, 1, 2, 6, 0, 7);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[13];
    ulong8 mask = (ulong8)(5, 7, 11, 11, 13, 0, 12, 13);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[14];
    ulong8 mask = (ulong8)(2, 1, 11, 1, 5, 13, 3, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[15];
    ulong8 mask = (ulong8)(10, 3, 4, 0, 0, 3, 13, 10);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[16];
    ulong8 mask = (ulong8)(3, 4, 3, 1, 6, 10, 11, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[17];
    ulong8 mask = (ulong8)(5, 9, 15, 6, 9, 14, 1, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[18];
    ulong8 mask = (ulong8)(6, 8, 9, 7, 15, 8, 11, 9);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[19];
    ulong8 mask = (ulong8)(11, 10, 8, 6, 14, 8, 0, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[20];
    ulong8 mask = (ulong8)(8, 9, 3, 4, 1, 10, 14, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[21];
    ulong8 mask = (ulong8)(14, 15, 7, 6, 7, 7, 2, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[22];
    ulong8 mask = (ulong8)(5, 6, 8, 2, 0, 9, 8, 4);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[23];
    ulong8 mask = (ulong8)(8, 9, 11, 14, 3, 2, 12, 7);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[24];
    ulong8 mask = (ulong8)(15, 14, 1, 3, 13, 5, 3, 13);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[25];
    ulong8 mask = (ulong8)(4, 10, 7, 10, 3, 9, 13, 13);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[26];
    ulong8 mask = (ulong8)(10, 6, 6, 5, 9, 10, 9, 12);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[27];
    ulong8 mask = (ulong8)(11, 1, 14, 0, 12, 13, 12, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[28];
    ulong8 mask = (ulong8)(14, 12, 5, 15, 10, 15, 9, 11);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[29];
    ulong8 mask = (ulong8)(4, 10, 2, 5, 9, 3, 7, 15);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[30];
    ulong8 mask = (ulong8)(14, 1, 8, 14, 8, 10, 10, 2);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[31];
    ulong8 mask = (ulong8)(6, 5, 6, 0, 7, 12, 13, 10);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
