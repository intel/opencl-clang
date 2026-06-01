// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *source, __global uchar16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar16 src1 /*, src2*/;
  uchar16 tmp;
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[0];
    uchar16 mask =
        (uchar16)(6, 4, 9, 2, 6, 11, 0, 12, 15, 5, 14, 6, 12, 11, 6, 14);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 mask =
        (uchar16)(11, 10, 11, 14, 5, 14, 0, 11, 9, 9, 15, 3, 11, 1, 3, 5);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 mask =
        (uchar16)(8, 13, 6, 10, 8, 7, 11, 11, 7, 10, 14, 12, 11, 14, 5, 6);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 mask =
        (uchar16)(9, 13, 7, 0, 12, 11, 0, 6, 9, 9, 0, 7, 15, 9, 8, 9);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 mask = (uchar16)(4, 4, 1, 4, 5, 2, 10, 9, 15, 0, 1, 15, 3, 4, 4, 2);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 mask =
        (uchar16)(12, 6, 1, 11, 14, 1, 3, 3, 11, 10, 12, 13, 14, 5, 3, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 mask =
        (uchar16)(11, 6, 5, 2, 6, 15, 8, 6, 2, 8, 5, 3, 15, 14, 2, 8);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 mask =
        (uchar16)(5, 9, 12, 14, 3, 2, 2, 2, 3, 1, 15, 14, 6, 6, 6, 4);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 mask =
        (uchar16)(12, 4, 1, 13, 2, 15, 11, 10, 5, 12, 11, 10, 0, 6, 9, 11);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 mask =
        (uchar16)(8, 13, 2, 9, 1, 11, 14, 11, 8, 1, 0, 10, 2, 10, 10, 8);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 mask =
        (uchar16)(7, 4, 9, 4, 7, 9, 14, 13, 13, 4, 15, 12, 15, 7, 11, 5);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 mask =
        (uchar16)(0, 12, 15, 8, 7, 15, 0, 8, 15, 3, 9, 2, 7, 1, 0, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 mask =
        (uchar16)(6, 10, 2, 4, 11, 4, 0, 12, 8, 15, 0, 8, 11, 15, 15, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 mask =
        (uchar16)(0, 8, 1, 14, 8, 8, 15, 8, 6, 9, 9, 6, 12, 8, 14, 2);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 mask =
        (uchar16)(2, 11, 14, 0, 10, 3, 12, 15, 4, 7, 8, 9, 3, 11, 13, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 mask = (uchar16)(3, 15, 8, 6, 6, 0, 0, 12, 6, 1, 12, 7, 8, 3, 4, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 mask =
        (uchar16)(7, 3, 12, 10, 10, 9, 1, 1, 8, 11, 3, 8, 15, 1, 11, 6);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 mask =
        (uchar16)(1, 10, 3, 3, 1, 10, 5, 4, 13, 12, 1, 0, 2, 9, 4, 15);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 mask =
        (uchar16)(9, 2, 15, 14, 13, 9, 3, 9, 11, 10, 8, 15, 7, 1, 14, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 mask =
        (uchar16)(9, 9, 2, 12, 2, 0, 14, 14, 1, 2, 2, 8, 10, 12, 3, 10);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 mask =
        (uchar16)(13, 12, 6, 4, 7, 13, 2, 4, 0, 11, 12, 1, 1, 14, 10, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 mask =
        (uchar16)(8, 2, 8, 2, 4, 12, 12, 12, 6, 10, 2, 15, 0, 15, 5, 11);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 mask =
        (uchar16)(9, 13, 3, 12, 11, 1, 1, 10, 7, 6, 8, 7, 13, 3, 1, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 mask =
        (uchar16)(0, 14, 8, 14, 2, 11, 9, 11, 0, 13, 7, 4, 6, 13, 2, 10);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 mask =
        (uchar16)(7, 12, 7, 13, 1, 14, 10, 0, 14, 7, 9, 15, 10, 9, 11, 11);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 mask =
        (uchar16)(14, 5, 15, 1, 7, 9, 15, 6, 5, 0, 11, 1, 14, 7, 0, 7);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 mask =
        (uchar16)(14, 7, 14, 4, 3, 9, 6, 7, 1, 3, 11, 10, 12, 12, 14, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 mask =
        (uchar16)(7, 2, 10, 11, 13, 6, 1, 9, 1, 8, 13, 2, 7, 9, 12, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 mask =
        (uchar16)(0, 12, 1, 8, 5, 1, 6, 15, 13, 7, 8, 11, 14, 2, 6, 2);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 mask = (uchar16)(1, 2, 7, 2, 6, 2, 8, 15, 10, 5, 0, 3, 9, 6, 2, 8);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 mask =
        (uchar16)(6, 7, 14, 7, 2, 11, 3, 10, 6, 5, 0, 2, 4, 11, 1, 5);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 mask =
        (uchar16)(7, 15, 9, 11, 11, 6, 14, 15, 7, 2, 10, 5, 0, 8, 7, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
