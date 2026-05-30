// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *source, __global char8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 /*, src2*/;
  char8 tmp;
  tmp = (char8)((char)0);
  {
    char16 src1 = source[0];
    uchar8 mask = (uchar8)(13, 6, 6, 11, 12, 2, 10, 14);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[1];
    uchar8 mask = (uchar8)(4, 8, 0, 6, 3, 2, 11, 9);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[2];
    uchar8 mask = (uchar8)(9, 5, 4, 11, 6, 15, 10, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[3];
    uchar8 mask = (uchar8)(2, 0, 6, 3, 6, 9, 8, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[4];
    uchar8 mask = (uchar8)(8, 5, 5, 3, 12, 11, 1, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[5];
    uchar8 mask = (uchar8)(0, 0, 6, 11, 14, 15, 4, 9);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[6];
    uchar8 mask = (uchar8)(2, 1, 14, 12, 2, 0, 5, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[7];
    uchar8 mask = (uchar8)(11, 7, 4, 9, 3, 6, 6, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[8];
    uchar8 mask = (uchar8)(12, 8, 14, 14, 0, 15, 2, 11);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[9];
    uchar8 mask = (uchar8)(15, 1, 9, 5, 8, 8, 13, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[10];
    uchar8 mask = (uchar8)(0, 13, 0, 3, 15, 3, 13, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[11];
    uchar8 mask = (uchar8)(11, 10, 2, 9, 7, 11, 14, 3);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[12];
    uchar8 mask = (uchar8)(14, 9, 0, 11, 12, 4, 0, 13);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[13];
    uchar8 mask = (uchar8)(15, 8, 6, 8, 15, 13, 5, 2);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[14];
    uchar8 mask = (uchar8)(4, 0, 5, 12, 11, 3, 3, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[15];
    uchar8 mask = (uchar8)(13, 4, 9, 2, 15, 4, 15, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[16];
    uchar8 mask = (uchar8)(2, 7, 15, 11, 0, 14, 0, 11);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[17];
    uchar8 mask = (uchar8)(15, 1, 15, 8, 2, 1, 7, 9);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[18];
    uchar8 mask = (uchar8)(7, 8, 13, 0, 10, 12, 12, 10);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[19];
    uchar8 mask = (uchar8)(7, 7, 10, 14, 11, 7, 11, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[20];
    uchar8 mask = (uchar8)(0, 2, 1, 10, 5, 2, 0, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[21];
    uchar8 mask = (uchar8)(6, 11, 6, 4, 14, 9, 9, 15);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[22];
    uchar8 mask = (uchar8)(11, 0, 14, 6, 7, 14, 0, 9);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[23];
    uchar8 mask = (uchar8)(4, 15, 13, 15, 14, 13, 5, 5);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[24];
    uchar8 mask = (uchar8)(4, 0, 14, 15, 5, 3, 10, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[25];
    uchar8 mask = (uchar8)(4, 10, 1, 11, 8, 15, 14, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[26];
    uchar8 mask = (uchar8)(9, 7, 3, 1, 10, 13, 12, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[27];
    uchar8 mask = (uchar8)(5, 13, 8, 5, 10, 14, 2, 13);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[28];
    uchar8 mask = (uchar8)(15, 11, 7, 0, 15, 11, 3, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[29];
    uchar8 mask = (uchar8)(7, 4, 2, 9, 0, 13, 3, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[30];
    uchar8 mask = (uchar8)(6, 5, 6, 1, 14, 12, 10, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[31];
    uchar8 mask = (uchar8)(6, 14, 15, 8, 9, 4, 5, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
