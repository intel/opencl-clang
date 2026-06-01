// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *source, __global char16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 /*, src2*/;
  char16 tmp;
  tmp = (char16)((char)0);
  {
    char16 src1 = source[0];
    uchar16 mask =
        (uchar16)(11, 13, 7, 6, 14, 14, 14, 11, 5, 1, 8, 12, 4, 13, 10, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[1];
    uchar16 mask =
        (uchar16)(15, 10, 13, 3, 5, 5, 1, 2, 15, 0, 6, 13, 4, 14, 5, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[2];
    uchar16 mask = (uchar16)(7, 2, 15, 0, 15, 5, 4, 8, 5, 6, 8, 10, 0, 4, 2, 4);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[3];
    uchar16 mask =
        (uchar16)(14, 0, 0, 10, 1, 13, 6, 14, 11, 9, 4, 3, 4, 6, 4, 5);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[4];
    uchar16 mask =
        (uchar16)(13, 0, 3, 0, 8, 4, 15, 11, 11, 10, 5, 12, 12, 14, 15, 15);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[5];
    uchar16 mask =
        (uchar16)(5, 12, 11, 0, 1, 15, 14, 5, 1, 14, 5, 2, 8, 10, 4, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[6];
    uchar16 mask =
        (uchar16)(10, 12, 8, 2, 11, 8, 5, 15, 8, 11, 12, 2, 12, 10, 11, 10);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[7];
    uchar16 mask =
        (uchar16)(8, 13, 10, 4, 1, 2, 7, 13, 13, 5, 9, 7, 15, 15, 4, 7);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[8];
    uchar16 mask =
        (uchar16)(1, 1, 10, 10, 1, 11, 12, 7, 4, 11, 8, 6, 12, 14, 12, 12);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[9];
    uchar16 mask =
        (uchar16)(7, 4, 15, 7, 7, 11, 4, 8, 4, 8, 11, 13, 6, 10, 6, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[10];
    uchar16 mask = (uchar16)(0, 4, 4, 1, 13, 2, 12, 3, 11, 8, 0, 8, 0, 9, 4, 3);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[11];
    uchar16 mask =
        (uchar16)(7, 3, 14, 0, 6, 0, 4, 5, 9, 11, 14, 11, 11, 10, 13, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[12];
    uchar16 mask =
        (uchar16)(2, 15, 2, 5, 8, 6, 11, 12, 15, 1, 5, 2, 5, 5, 8, 13);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[13];
    uchar16 mask =
        (uchar16)(10, 10, 9, 5, 11, 14, 6, 12, 13, 0, 2, 7, 5, 6, 12, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[14];
    uchar16 mask =
        (uchar16)(5, 4, 10, 10, 4, 3, 2, 11, 4, 7, 14, 1, 7, 6, 3, 12);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[15];
    uchar16 mask =
        (uchar16)(5, 2, 0, 8, 12, 2, 3, 14, 9, 8, 0, 2, 13, 8, 2, 15);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[16];
    uchar16 mask =
        (uchar16)(0, 13, 4, 5, 14, 11, 4, 10, 8, 11, 6, 7, 4, 14, 14, 5);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[17];
    uchar16 mask =
        (uchar16)(12, 15, 12, 1, 8, 14, 13, 12, 7, 15, 7, 8, 7, 14, 3, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[18];
    uchar16 mask =
        (uchar16)(14, 0, 4, 11, 3, 13, 3, 14, 13, 0, 12, 5, 6, 7, 0, 14);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[19];
    uchar16 mask =
        (uchar16)(15, 4, 2, 11, 13, 3, 12, 9, 15, 1, 12, 12, 5, 0, 3, 15);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[20];
    uchar16 mask =
        (uchar16)(6, 12, 3, 9, 11, 12, 13, 0, 10, 6, 2, 9, 0, 15, 9, 5);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[21];
    uchar16 mask =
        (uchar16)(7, 15, 3, 8, 5, 1, 8, 9, 10, 13, 7, 14, 15, 8, 0, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[22];
    uchar16 mask =
        (uchar16)(10, 10, 14, 0, 3, 15, 3, 3, 12, 10, 7, 9, 15, 11, 9, 13);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[23];
    uchar16 mask =
        (uchar16)(14, 4, 0, 3, 2, 11, 10, 2, 6, 15, 13, 3, 6, 8, 11, 10);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[24];
    uchar16 mask =
        (uchar16)(9, 2, 1, 6, 11, 12, 11, 4, 1, 5, 8, 3, 5, 12, 7, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[25];
    uchar16 mask =
        (uchar16)(6, 4, 1, 7, 2, 3, 1, 3, 3, 14, 13, 12, 0, 4, 6, 11);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[26];
    uchar16 mask =
        (uchar16)(12, 5, 1, 6, 3, 11, 11, 12, 10, 4, 9, 2, 2, 7, 12, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[27];
    uchar16 mask =
        (uchar16)(2, 12, 2, 2, 12, 5, 5, 3, 5, 0, 4, 9, 5, 12, 5, 13);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[28];
    uchar16 mask =
        (uchar16)(11, 11, 3, 12, 5, 7, 12, 1, 14, 4, 9, 8, 1, 14, 8, 10);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[29];
    uchar16 mask =
        (uchar16)(10, 2, 5, 7, 13, 13, 12, 1, 9, 1, 2, 14, 11, 13, 14, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[30];
    uchar16 mask =
        (uchar16)(4, 11, 15, 12, 12, 5, 4, 6, 9, 13, 4, 0, 1, 5, 13, 15);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[31];
    uchar16 mask =
        (uchar16)(10, 7, 9, 6, 2, 0, 6, 11, 14, 15, 2, 11, 0, 10, 3, 14);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
