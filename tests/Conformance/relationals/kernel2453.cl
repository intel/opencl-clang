// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *source, __global uchar8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar16 src1 /*, src2*/;
  uchar8 tmp;
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[0];
    uchar8 mask = (uchar8)(2, 12, 8, 13, 2, 7, 0, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar8 mask = (uchar8)(0, 9, 6, 11, 6, 6, 10, 13);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar8 mask = (uchar8)(6, 14, 3, 14, 1, 13, 9, 13);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar8 mask = (uchar8)(3, 11, 6, 6, 0, 3, 3, 4);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar8 mask = (uchar8)(10, 1, 1, 10, 10, 1, 13, 5);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar8 mask = (uchar8)(13, 2, 2, 4, 7, 13, 14, 9);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar8 mask = (uchar8)(11, 3, 13, 4, 6, 1, 7, 0);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar8 mask = (uchar8)(14, 7, 6, 8, 10, 9, 6, 11);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar8 mask = (uchar8)(11, 3, 9, 8, 7, 8, 8, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar8 mask = (uchar8)(9, 8, 14, 11, 10, 1, 11, 11);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar8 mask = (uchar8)(15, 7, 1, 4, 3, 3, 5, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar8 mask = (uchar8)(15, 6, 3, 4, 9, 10, 1, 6);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar8 mask = (uchar8)(4, 2, 4, 9, 11, 2, 1, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar8 mask = (uchar8)(12, 14, 4, 6, 11, 9, 5, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar8 mask = (uchar8)(6, 5, 2, 11, 1, 5, 8, 12);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar8 mask = (uchar8)(10, 9, 1, 4, 2, 15, 0, 5);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar8 mask = (uchar8)(2, 6, 3, 2, 11, 3, 1, 12);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar8 mask = (uchar8)(10, 13, 6, 9, 2, 15, 15, 12);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar8 mask = (uchar8)(8, 7, 4, 5, 0, 0, 5, 14);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar8 mask = (uchar8)(9, 13, 3, 13, 9, 3, 4, 14);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar8 mask = (uchar8)(0, 3, 6, 15, 5, 12, 3, 8);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar8 mask = (uchar8)(8, 6, 6, 4, 15, 6, 9, 8);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar8 mask = (uchar8)(5, 5, 3, 0, 10, 2, 14, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar8 mask = (uchar8)(10, 14, 13, 6, 10, 10, 15, 8);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar8 mask = (uchar8)(6, 3, 12, 2, 8, 13, 0, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar8 mask = (uchar8)(0, 12, 6, 9, 10, 3, 13, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar8 mask = (uchar8)(0, 6, 15, 6, 14, 11, 13, 5);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar8 mask = (uchar8)(10, 13, 7, 14, 12, 7, 3, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar8 mask = (uchar8)(4, 15, 2, 5, 15, 6, 3, 4);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar8 mask = (uchar8)(11, 3, 7, 3, 0, 7, 1, 4);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar8 mask = (uchar8)(14, 6, 11, 14, 8, 12, 3, 14);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar8 mask = (uchar8)(0, 9, 12, 6, 4, 13, 3, 4);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
