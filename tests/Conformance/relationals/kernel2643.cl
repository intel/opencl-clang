// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *source, __global ulong4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 /*, src2*/;
  ulong4 tmp;
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong4 mask = (ulong4)(11, 5, 15, 7);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong4 mask = (ulong4)(10, 15, 12, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong4 mask = (ulong4)(9, 1, 2, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong4 mask = (ulong4)(8, 5, 10, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong4 mask = (ulong4)(12, 3, 2, 10);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong4 mask = (ulong4)(11, 1, 9, 10);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong4 mask = (ulong4)(2, 10, 12, 7);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong4 mask = (ulong4)(4, 10, 7, 5);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong4 mask = (ulong4)(0, 14, 13, 13);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong4 mask = (ulong4)(2, 13, 14, 14);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong4 mask = (ulong4)(5, 6, 0, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong4 mask = (ulong4)(11, 9, 4, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong4 mask = (ulong4)(10, 15, 0, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong4 mask = (ulong4)(12, 5, 15, 10);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong4 mask = (ulong4)(8, 5, 14, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong4 mask = (ulong4)(12, 11, 13, 12);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong4 mask = (ulong4)(10, 8, 5, 14);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong4 mask = (ulong4)(11, 9, 5, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong4 mask = (ulong4)(12, 4, 15, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong4 mask = (ulong4)(9, 15, 14, 4);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong4 mask = (ulong4)(7, 11, 5, 5);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong4 mask = (ulong4)(9, 4, 4, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong4 mask = (ulong4)(2, 0, 1, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong4 mask = (ulong4)(5, 10, 12, 5);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong4 mask = (ulong4)(12, 1, 2, 9);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong4 mask = (ulong4)(4, 10, 12, 4);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong4 mask = (ulong4)(1, 6, 13, 13);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong4 mask = (ulong4)(11, 9, 0, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong4 mask = (ulong4)(7, 13, 1, 9);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong4 mask = (ulong4)(5, 11, 11, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong4 mask = (ulong4)(1, 11, 4, 15);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong4 mask = (ulong4)(8, 14, 1, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
