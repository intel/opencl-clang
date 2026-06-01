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
        (uchar16)(4, 2, 12, 1, 10, 10, 0, 1, 0, 14, 9, 10, 10, 12, 2, 14);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[1];
    uchar16 mask =
        (uchar16)(9, 1, 3, 5, 5, 8, 6, 13, 1, 8, 15, 9, 15, 9, 7, 10);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[2];
    uchar16 mask =
        (uchar16)(4, 11, 15, 10, 13, 2, 11, 15, 7, 13, 6, 7, 12, 10, 8, 4);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[3];
    uchar16 mask =
        (uchar16)(10, 13, 9, 9, 11, 4, 1, 13, 6, 1, 2, 4, 3, 5, 3, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[4];
    uchar16 mask =
        (uchar16)(8, 7, 0, 12, 15, 6, 8, 11, 0, 3, 10, 13, 4, 2, 1, 11);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[5];
    uchar16 mask =
        (uchar16)(13, 4, 3, 13, 1, 15, 0, 12, 11, 0, 10, 0, 0, 0, 3, 14);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[6];
    uchar16 mask =
        (uchar16)(11, 2, 2, 13, 9, 11, 3, 10, 7, 0, 13, 9, 4, 15, 10, 10);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[7];
    uchar16 mask =
        (uchar16)(7, 4, 1, 12, 5, 7, 13, 1, 15, 14, 13, 12, 2, 0, 5, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[8];
    uchar16 mask =
        (uchar16)(13, 3, 8, 13, 12, 3, 12, 14, 1, 8, 5, 4, 7, 2, 15, 9);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[9];
    uchar16 mask =
        (uchar16)(14, 14, 6, 9, 1, 6, 6, 10, 8, 11, 14, 3, 4, 4, 4, 14);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[10];
    uchar16 mask =
        (uchar16)(10, 12, 8, 11, 3, 10, 2, 8, 7, 5, 12, 6, 12, 1, 15, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[11];
    uchar16 mask =
        (uchar16)(6, 0, 6, 13, 0, 7, 13, 2, 10, 9, 12, 8, 7, 10, 14, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[12];
    uchar16 mask =
        (uchar16)(0, 12, 1, 6, 6, 6, 1, 10, 1, 13, 9, 1, 3, 6, 10, 7);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[13];
    uchar16 mask =
        (uchar16)(14, 8, 13, 5, 3, 2, 1, 3, 15, 3, 15, 6, 5, 8, 7, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[14];
    uchar16 mask =
        (uchar16)(2, 13, 11, 7, 6, 4, 12, 5, 9, 15, 0, 10, 5, 6, 12, 14);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[15];
    uchar16 mask =
        (uchar16)(11, 12, 10, 13, 10, 2, 9, 12, 10, 7, 9, 1, 8, 1, 12, 9);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[16];
    uchar16 mask = (uchar16)(5, 6, 7, 1, 6, 6, 3, 12, 5, 3, 0, 11, 5, 6, 6, 5);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[17];
    uchar16 mask = (uchar16)(1, 6, 3, 10, 3, 6, 3, 8, 5, 1, 2, 10, 11, 2, 5, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[18];
    uchar16 mask =
        (uchar16)(1, 11, 9, 15, 2, 14, 0, 7, 2, 4, 6, 7, 11, 8, 10, 4);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[19];
    uchar16 mask =
        (uchar16)(0, 11, 12, 0, 5, 15, 10, 11, 0, 13, 6, 5, 0, 14, 13, 15);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[20];
    uchar16 mask =
        (uchar16)(2, 2, 10, 9, 4, 13, 2, 0, 14, 12, 9, 0, 14, 10, 4, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[21];
    uchar16 mask =
        (uchar16)(13, 1, 15, 4, 6, 5, 14, 8, 5, 1, 5, 6, 15, 15, 15, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[22];
    uchar16 mask =
        (uchar16)(3, 15, 13, 15, 5, 4, 15, 13, 13, 5, 14, 10, 9, 5, 4, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[23];
    uchar16 mask =
        (uchar16)(3, 9, 8, 13, 10, 15, 11, 4, 2, 10, 8, 13, 6, 3, 3, 8);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[24];
    uchar16 mask =
        (uchar16)(8, 14, 4, 13, 8, 0, 3, 9, 14, 10, 5, 15, 9, 11, 1, 8);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[25];
    uchar16 mask =
        (uchar16)(10, 2, 4, 4, 15, 13, 6, 1, 9, 0, 3, 9, 13, 10, 12, 13);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[26];
    uchar16 mask =
        (uchar16)(3, 8, 14, 13, 0, 13, 12, 6, 7, 1, 13, 12, 7, 15, 1, 14);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[27];
    uchar16 mask =
        (uchar16)(3, 10, 15, 1, 5, 9, 2, 0, 12, 9, 0, 13, 1, 11, 4, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[28];
    uchar16 mask =
        (uchar16)(0, 1, 15, 2, 11, 13, 8, 9, 12, 8, 10, 3, 2, 6, 3, 9);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[29];
    uchar16 mask =
        (uchar16)(13, 10, 5, 11, 7, 11, 6, 9, 0, 2, 11, 8, 8, 1, 10, 9);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[30];
    uchar16 mask =
        (uchar16)(4, 15, 6, 4, 3, 6, 6, 4, 10, 8, 15, 0, 10, 15, 8, 12);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[31];
    uchar16 mask =
        (uchar16)(6, 9, 1, 13, 7, 3, 2, 13, 9, 15, 11, 10, 15, 9, 4, 7);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
