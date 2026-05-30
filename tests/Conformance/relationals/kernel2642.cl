// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *source, __global ulong4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 /*, src2*/;
  ulong4 tmp;
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong4 mask = (ulong4)(7, 6, 12, 15);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong4 mask = (ulong4)(2, 8, 7, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong4 mask = (ulong4)(6, 12, 8, 10);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong4 mask = (ulong4)(12, 10, 2, 7);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong4 mask = (ulong4)(13, 7, 13, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong4 mask = (ulong4)(6, 0, 13, 14);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong4 mask = (ulong4)(4, 13, 14, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong4 mask = (ulong4)(8, 3, 11, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong4 mask = (ulong4)(3, 12, 1, 2);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong4 mask = (ulong4)(2, 3, 6, 7);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong4 mask = (ulong4)(7, 1, 5, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong4 mask = (ulong4)(0, 6, 10, 10);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong4 mask = (ulong4)(8, 10, 10, 15);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong4 mask = (ulong4)(11, 2, 15, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong4 mask = (ulong4)(11, 8, 5, 5);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong4 mask = (ulong4)(12, 1, 1, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong4 mask = (ulong4)(2, 5, 0, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong4 mask = (ulong4)(7, 13, 11, 15);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong4 mask = (ulong4)(4, 13, 6, 7);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong4 mask = (ulong4)(11, 14, 5, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong4 mask = (ulong4)(9, 2, 5, 15);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong4 mask = (ulong4)(0, 12, 13, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong4 mask = (ulong4)(2, 15, 4, 9);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong4 mask = (ulong4)(3, 14, 14, 15);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong4 mask = (ulong4)(13, 11, 3, 8);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong4 mask = (ulong4)(2, 13, 8, 15);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong4 mask = (ulong4)(11, 8, 1, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong4 mask = (ulong4)(9, 15, 8, 14);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong4 mask = (ulong4)(13, 1, 11, 11);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong4 mask = (ulong4)(14, 6, 14, 10);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong4 mask = (ulong4)(5, 6, 14, 11);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong4 mask = (ulong4)(8, 2, 4, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
