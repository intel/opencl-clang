// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *source, __global long8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 /*, src2*/;
  long8 tmp;
  tmp = (long8)((long)0);
  {
    long8 src1 = source[0];
    ulong8 mask = (ulong8)(6, 7, 0, 3, 2, 2, 5, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[1];
    ulong8 mask = (ulong8)(5, 7, 6, 5, 5, 7, 7, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[2];
    ulong8 mask = (ulong8)(0, 0, 2, 4, 2, 2, 5, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[3];
    ulong8 mask = (ulong8)(3, 6, 1, 7, 7, 4, 0, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[4];
    ulong8 mask = (ulong8)(1, 0, 7, 4, 6, 6, 5, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[5];
    ulong8 mask = (ulong8)(6, 0, 0, 1, 7, 5, 3, 6);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[6];
    ulong8 mask = (ulong8)(0, 6, 5, 3, 4, 1, 1, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[7];
    ulong8 mask = (ulong8)(3, 4, 6, 5, 1, 6, 6, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[8];
    ulong8 mask = (ulong8)(4, 6, 5, 0, 0, 7, 6, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[9];
    ulong8 mask = (ulong8)(7, 7, 4, 2, 1, 5, 5, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[10];
    ulong8 mask = (ulong8)(2, 0, 6, 2, 1, 3, 1, 4);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[11];
    ulong8 mask = (ulong8)(2, 3, 3, 5, 3, 1, 7, 3);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[12];
    ulong8 mask = (ulong8)(3, 3, 3, 1, 1, 6, 7, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[13];
    ulong8 mask = (ulong8)(6, 1, 2, 5, 0, 2, 0, 2);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[14];
    ulong8 mask = (ulong8)(6, 2, 0, 5, 5, 2, 5, 4);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[15];
    ulong8 mask = (ulong8)(4, 3, 7, 2, 1, 2, 4, 0);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[16];
    ulong8 mask = (ulong8)(3, 7, 2, 3, 3, 0, 7, 4);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[17];
    ulong8 mask = (ulong8)(1, 7, 7, 7, 4, 3, 3, 7);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[18];
    ulong8 mask = (ulong8)(0, 1, 3, 6, 4, 0, 2, 7);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[19];
    ulong8 mask = (ulong8)(4, 7, 5, 4, 0, 3, 0, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[20];
    ulong8 mask = (ulong8)(1, 0, 0, 4, 1, 4, 2, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[21];
    ulong8 mask = (ulong8)(3, 3, 4, 5, 0, 7, 4, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[22];
    ulong8 mask = (ulong8)(1, 4, 6, 1, 6, 7, 3, 4);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[23];
    ulong8 mask = (ulong8)(0, 6, 2, 3, 5, 0, 5, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[24];
    ulong8 mask = (ulong8)(6, 0, 5, 7, 7, 6, 1, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[25];
    ulong8 mask = (ulong8)(0, 7, 5, 1, 6, 7, 2, 7);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[26];
    ulong8 mask = (ulong8)(7, 7, 4, 6, 3, 0, 0, 6);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[27];
    ulong8 mask = (ulong8)(2, 2, 2, 2, 6, 7, 1, 2);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[28];
    ulong8 mask = (ulong8)(4, 0, 2, 7, 6, 7, 0, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[29];
    ulong8 mask = (ulong8)(4, 6, 5, 3, 1, 4, 7, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[30];
    ulong8 mask = (ulong8)(2, 6, 1, 7, 6, 4, 5, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[31];
    ulong8 mask = (ulong8)(0, 3, 4, 5, 4, 6, 2, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
