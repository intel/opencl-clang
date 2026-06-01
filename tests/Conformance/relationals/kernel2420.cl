// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *source, __global char8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 /*, src2*/;
  char8 tmp;
  tmp = (char8)((char)0);
  {
    char16 src1 = source[0];
    uchar8 mask = (uchar8)(7, 6, 4, 14, 14, 15, 6, 13);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[1];
    uchar8 mask = (uchar8)(0, 12, 6, 13, 6, 14, 13, 9);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[2];
    uchar8 mask = (uchar8)(12, 7, 3, 13, 13, 6, 3, 4);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[3];
    uchar8 mask = (uchar8)(5, 7, 1, 5, 0, 9, 10, 8);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[4];
    uchar8 mask = (uchar8)(14, 8, 7, 0, 13, 3, 12, 5);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[5];
    uchar8 mask = (uchar8)(10, 1, 15, 9, 12, 2, 4, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[6];
    uchar8 mask = (uchar8)(12, 7, 11, 6, 6, 10, 1, 15);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[7];
    uchar8 mask = (uchar8)(3, 0, 12, 7, 3, 13, 15, 5);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[8];
    uchar8 mask = (uchar8)(11, 6, 7, 1, 9, 8, 9, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[9];
    uchar8 mask = (uchar8)(15, 4, 2, 10, 4, 11, 11, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[10];
    uchar8 mask = (uchar8)(3, 8, 13, 8, 5, 11, 2, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[11];
    uchar8 mask = (uchar8)(0, 5, 9, 1, 13, 7, 4, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[12];
    uchar8 mask = (uchar8)(14, 3, 12, 2, 0, 5, 9, 12);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[13];
    uchar8 mask = (uchar8)(9, 12, 3, 15, 5, 6, 7, 14);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[14];
    uchar8 mask = (uchar8)(0, 14, 2, 5, 2, 7, 6, 5);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[15];
    uchar8 mask = (uchar8)(11, 1, 13, 6, 2, 15, 12, 13);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[16];
    uchar8 mask = (uchar8)(10, 12, 14, 1, 15, 0, 1, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[17];
    uchar8 mask = (uchar8)(1, 6, 12, 14, 2, 2, 3, 9);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[18];
    uchar8 mask = (uchar8)(14, 8, 15, 2, 5, 12, 13, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[19];
    uchar8 mask = (uchar8)(13, 1, 9, 13, 9, 5, 9, 15);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[20];
    uchar8 mask = (uchar8)(4, 3, 9, 14, 3, 9, 2, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[21];
    uchar8 mask = (uchar8)(6, 12, 11, 13, 9, 5, 15, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[22];
    uchar8 mask = (uchar8)(10, 10, 2, 11, 2, 4, 1, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[23];
    uchar8 mask = (uchar8)(3, 6, 9, 5, 13, 1, 14, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[24];
    uchar8 mask = (uchar8)(6, 9, 8, 15, 12, 12, 4, 5);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[25];
    uchar8 mask = (uchar8)(9, 6, 2, 1, 7, 12, 2, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[26];
    uchar8 mask = (uchar8)(7, 7, 6, 7, 6, 3, 3, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[27];
    uchar8 mask = (uchar8)(2, 5, 4, 0, 3, 8, 11, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[28];
    uchar8 mask = (uchar8)(11, 5, 9, 7, 1, 14, 9, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[29];
    uchar8 mask = (uchar8)(1, 9, 0, 5, 5, 7, 3, 8);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[30];
    uchar8 mask = (uchar8)(9, 12, 14, 13, 11, 10, 12, 7);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[31];
    uchar8 mask = (uchar8)(15, 13, 10, 3, 9, 5, 9, 4);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
