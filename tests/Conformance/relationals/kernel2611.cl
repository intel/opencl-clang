// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *source, __global long4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 /*, src2*/;
  long4 tmp;
  tmp = (long4)((long)0);
  {
    long16 src1 = source[0];
    ulong4 mask = (ulong4)(10, 11, 15, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[1];
    ulong4 mask = (ulong4)(15, 5, 15, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[2];
    ulong4 mask = (ulong4)(13, 11, 8, 11);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[3];
    ulong4 mask = (ulong4)(12, 1, 1, 11);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[4];
    ulong4 mask = (ulong4)(2, 5, 7, 5);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[5];
    ulong4 mask = (ulong4)(15, 12, 2, 8);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[6];
    ulong4 mask = (ulong4)(14, 13, 11, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[7];
    ulong4 mask = (ulong4)(1, 11, 12, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[8];
    ulong4 mask = (ulong4)(11, 8, 12, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[9];
    ulong4 mask = (ulong4)(6, 10, 6, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[10];
    ulong4 mask = (ulong4)(6, 11, 9, 15);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[11];
    ulong4 mask = (ulong4)(1, 2, 3, 6);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[12];
    ulong4 mask = (ulong4)(2, 12, 3, 4);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[13];
    ulong4 mask = (ulong4)(14, 14, 0, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[14];
    ulong4 mask = (ulong4)(14, 0, 15, 13);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[15];
    ulong4 mask = (ulong4)(10, 4, 15, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[16];
    ulong4 mask = (ulong4)(10, 12, 4, 8);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[17];
    ulong4 mask = (ulong4)(2, 3, 14, 8);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[18];
    ulong4 mask = (ulong4)(5, 13, 11, 6);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[19];
    ulong4 mask = (ulong4)(4, 6, 9, 6);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[20];
    ulong4 mask = (ulong4)(2, 4, 6, 9);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[21];
    ulong4 mask = (ulong4)(15, 5, 15, 9);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[22];
    ulong4 mask = (ulong4)(4, 9, 3, 10);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[23];
    ulong4 mask = (ulong4)(11, 9, 7, 4);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[24];
    ulong4 mask = (ulong4)(2, 15, 6, 8);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[25];
    ulong4 mask = (ulong4)(0, 9, 2, 7);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[26];
    ulong4 mask = (ulong4)(12, 3, 7, 8);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[27];
    ulong4 mask = (ulong4)(12, 9, 1, 3);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[28];
    ulong4 mask = (ulong4)(0, 11, 12, 12);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[29];
    ulong4 mask = (ulong4)(6, 5, 15, 10);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[30];
    ulong4 mask = (ulong4)(5, 10, 5, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[31];
    ulong4 mask = (ulong4)(12, 1, 3, 7);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
