// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *source, __global uchar8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar16 src1 /*, src2*/;
  uchar8 tmp;
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[0];
    uchar8 mask = (uchar8)(10, 5, 10, 0, 3, 4, 11, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar8 mask = (uchar8)(1, 4, 9, 9, 2, 4, 3, 10);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar8 mask = (uchar8)(15, 10, 6, 9, 8, 7, 10, 4);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar8 mask = (uchar8)(7, 2, 11, 7, 0, 9, 10, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar8 mask = (uchar8)(5, 3, 14, 2, 2, 3, 0, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar8 mask = (uchar8)(0, 6, 8, 5, 3, 9, 12, 14);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar8 mask = (uchar8)(0, 9, 3, 2, 13, 1, 0, 10);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar8 mask = (uchar8)(12, 13, 1, 5, 13, 8, 12, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar8 mask = (uchar8)(3, 0, 6, 11, 7, 8, 6, 11);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar8 mask = (uchar8)(3, 13, 3, 7, 11, 13, 2, 0);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar8 mask = (uchar8)(4, 10, 1, 15, 3, 4, 0, 11);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar8 mask = (uchar8)(11, 3, 6, 15, 6, 7, 7, 10);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar8 mask = (uchar8)(4, 8, 5, 1, 9, 12, 3, 3);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar8 mask = (uchar8)(7, 4, 9, 0, 2, 8, 4, 8);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar8 mask = (uchar8)(8, 2, 6, 11, 11, 0, 3, 12);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar8 mask = (uchar8)(7, 15, 13, 2, 2, 5, 14, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar8 mask = (uchar8)(7, 8, 7, 1, 10, 8, 8, 14);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar8 mask = (uchar8)(13, 7, 2, 10, 2, 13, 4, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar8 mask = (uchar8)(15, 4, 1, 5, 8, 10, 12, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar8 mask = (uchar8)(13, 0, 15, 0, 15, 5, 8, 12);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar8 mask = (uchar8)(3, 11, 8, 7, 11, 4, 7, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar8 mask = (uchar8)(4, 0, 13, 0, 13, 9, 8, 14);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar8 mask = (uchar8)(9, 13, 8, 2, 12, 5, 14, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar8 mask = (uchar8)(0, 6, 15, 5, 5, 7, 6, 15);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar8 mask = (uchar8)(5, 12, 13, 14, 11, 0, 2, 8);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar8 mask = (uchar8)(6, 13, 0, 11, 12, 4, 3, 11);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar8 mask = (uchar8)(1, 8, 10, 11, 3, 7, 8, 15);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar8 mask = (uchar8)(2, 15, 12, 15, 15, 8, 1, 13);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar8 mask = (uchar8)(13, 15, 7, 14, 0, 8, 8, 15);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar8 mask = (uchar8)(7, 4, 14, 15, 5, 4, 12, 9);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar8 mask = (uchar8)(2, 1, 6, 14, 8, 9, 2, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar8 mask = (uchar8)(3, 1, 3, 11, 11, 6, 15, 12);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
