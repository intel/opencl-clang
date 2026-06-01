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
        (uchar16)(2, 10, 12, 2, 9, 9, 10, 6, 14, 5, 14, 7, 10, 14, 15, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 mask =
        (uchar16)(3, 4, 0, 2, 14, 9, 4, 5, 15, 5, 3, 7, 4, 3, 14, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 mask =
        (uchar16)(13, 14, 1, 1, 9, 8, 2, 2, 1, 15, 9, 11, 1, 15, 7, 13);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 mask =
        (uchar16)(9, 10, 15, 15, 14, 6, 9, 6, 8, 2, 10, 12, 14, 14, 15, 11);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 mask =
        (uchar16)(0, 4, 15, 8, 12, 5, 1, 2, 12, 10, 10, 11, 14, 10, 7, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 mask =
        (uchar16)(8, 14, 13, 5, 7, 9, 8, 13, 3, 8, 5, 13, 4, 6, 0, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 mask = (uchar16)(9, 9, 13, 5, 12, 3, 3, 4, 9, 5, 7, 6, 13, 5, 5, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 mask =
        (uchar16)(0, 9, 14, 9, 10, 2, 2, 5, 3, 11, 6, 13, 7, 6, 5, 8);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 mask =
        (uchar16)(8, 6, 14, 14, 10, 14, 5, 15, 13, 4, 11, 3, 9, 15, 8, 10);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 mask = (uchar16)(1, 4, 9, 0, 6, 7, 8, 15, 1, 3, 12, 6, 8, 6, 13, 8);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 mask =
        (uchar16)(3, 9, 15, 12, 9, 14, 1, 7, 5, 15, 15, 10, 9, 0, 6, 10);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 mask =
        (uchar16)(14, 5, 5, 9, 11, 7, 2, 14, 11, 6, 7, 4, 6, 0, 3, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 mask =
        (uchar16)(15, 14, 1, 8, 3, 7, 6, 12, 2, 11, 14, 13, 14, 14, 7, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 mask =
        (uchar16)(7, 9, 0, 14, 13, 0, 12, 1, 6, 10, 7, 11, 10, 4, 7, 8);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 mask = (uchar16)(4, 0, 4, 4, 8, 9, 15, 6, 7, 7, 0, 14, 15, 0, 4, 8);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 mask =
        (uchar16)(0, 9, 1, 10, 2, 11, 10, 2, 5, 14, 14, 6, 12, 7, 5, 10);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 mask =
        (uchar16)(15, 8, 10, 6, 0, 10, 7, 10, 14, 3, 4, 6, 14, 0, 9, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 mask =
        (uchar16)(9, 14, 5, 10, 15, 14, 6, 0, 10, 12, 10, 12, 10, 6, 4, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 mask =
        (uchar16)(13, 14, 9, 8, 6, 7, 5, 5, 1, 10, 9, 12, 12, 14, 6, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 mask =
        (uchar16)(14, 12, 2, 12, 7, 9, 10, 3, 9, 10, 14, 5, 10, 4, 13, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 mask =
        (uchar16)(10, 6, 5, 11, 4, 13, 5, 5, 6, 2, 13, 9, 11, 7, 13, 9);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 mask =
        (uchar16)(14, 2, 13, 6, 15, 12, 15, 5, 5, 7, 6, 2, 9, 13, 11, 8);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 mask =
        (uchar16)(7, 5, 12, 3, 10, 8, 9, 0, 2, 8, 2, 10, 5, 1, 15, 4);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 mask =
        (uchar16)(1, 12, 15, 6, 7, 9, 6, 14, 13, 3, 13, 7, 2, 4, 12, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 mask =
        (uchar16)(8, 15, 5, 8, 1, 14, 9, 8, 12, 12, 14, 3, 15, 7, 1, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 mask =
        (uchar16)(6, 0, 0, 13, 10, 0, 14, 3, 10, 10, 6, 1, 12, 6, 15, 14);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 mask =
        (uchar16)(0, 9, 13, 8, 5, 2, 11, 5, 3, 11, 3, 2, 12, 8, 12, 7);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 mask =
        (uchar16)(12, 3, 12, 7, 1, 0, 14, 1, 6, 7, 3, 13, 9, 0, 5, 12);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 mask =
        (uchar16)(11, 4, 11, 14, 13, 14, 15, 3, 12, 1, 2, 7, 12, 3, 9, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 mask =
        (uchar16)(9, 9, 5, 5, 2, 8, 2, 5, 0, 13, 12, 11, 11, 12, 13, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 mask =
        (uchar16)(11, 1, 2, 1, 11, 8, 8, 12, 1, 14, 14, 5, 14, 7, 10, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 mask =
        (uchar16)(6, 1, 3, 9, 1, 12, 12, 8, 15, 10, 0, 11, 7, 13, 1, 7);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
