// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *secondSource,
                          __global char16 *source, __global char16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 , src2;
  char16 tmp;
  tmp = (char16)((char)0);
  {
    char16 src1 = source[0];
    char16 src2 = secondSource[0];
    uchar16 mask =
        (uchar16)(8, 4, 25, 3, 20, 21, 0, 2, 0, 29, 18, 21, 20, 24, 4, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[1];
    char16 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(19, 2, 7, 10, 10, 17, 13, 27, 3, 17, 30, 18, 31, 18, 14, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[2];
    char16 src2 = secondSource[2];
    uchar16 mask =
        (uchar16)(8, 23, 30, 21, 26, 4, 23, 31, 14, 27, 13, 15, 24, 20, 16, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[3];
    char16 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(21, 26, 18, 19, 22, 8, 3, 26, 12, 3, 5, 8, 7, 10, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[4];
    char16 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(16, 14, 0, 24, 30, 13, 16, 22, 1, 6, 21, 26, 8, 5, 3, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[5];
    char16 src2 = secondSource[5];
    uchar16 mask =
        (uchar16)(26, 9, 6, 26, 3, 30, 1, 24, 23, 1, 20, 1, 0, 0, 7, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[6];
    char16 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(22, 5, 4, 27, 18, 23, 6, 21, 14, 1, 27, 18, 9, 31, 21, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[7];
    char16 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(14, 9, 3, 24, 11, 15, 26, 3, 31, 28, 27, 25, 5, 0, 11, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[8];
    char16 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(26, 6, 17, 27, 24, 6, 24, 29, 2, 16, 10, 9, 15, 4, 30, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[9];
    char16 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(28, 28, 13, 19, 3, 13, 12, 20, 17, 23, 28, 7, 9, 8, 9, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[10];
    char16 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(20, 24, 16, 23, 6, 21, 4, 16, 15, 11, 24, 12, 24, 2, 31, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[11];
    char16 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(12, 0, 12, 27, 0, 14, 26, 5, 20, 19, 24, 16, 15, 20, 29, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[12];
    char16 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(0, 25, 3, 13, 12, 12, 2, 20, 2, 26, 18, 2, 6, 13, 20, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[13];
    char16 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(29, 17, 26, 10, 7, 5, 2, 7, 30, 7, 31, 13, 11, 17, 14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[14];
    char16 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(4, 26, 22, 15, 13, 9, 25, 11, 18, 31, 1, 21, 10, 13, 25, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[15];
    char16 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(22, 24, 20, 27, 21, 5, 19, 25, 20, 15, 19, 2, 17, 2, 24, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[16];
    char16 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(11, 12, 15, 2, 12, 13, 6, 25, 10, 6, 1, 23, 10, 13, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[17];
    char16 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(2, 13, 7, 20, 7, 12, 7, 17, 11, 2, 4, 21, 23, 4, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[18];
    char16 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(3, 22, 18, 31, 5, 28, 1, 14, 5, 9, 13, 14, 22, 17, 20, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[19];
    char16 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(0, 23, 25, 0, 10, 30, 21, 23, 1, 27, 12, 10, 0, 29, 26, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[20];
    char16 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(5, 5, 21, 18, 8, 27, 4, 1, 29, 24, 19, 1, 28, 20, 9, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[21];
    char16 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(26, 3, 30, 9, 12, 11, 28, 16, 10, 2, 10, 12, 31, 30, 30, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[22];
    char16 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(7, 31, 26, 30, 10, 8, 31, 26, 27, 11, 28, 20, 18, 10, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[23];
    char16 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(6, 18, 16, 27, 21, 30, 23, 8, 5, 21, 17, 26, 13, 6, 6, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[24];
    char16 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(17, 28, 8, 27, 17, 0, 6, 19, 28, 20, 10, 31, 19, 22, 3, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[25];
    char16 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(20, 5, 8, 8, 30, 26, 12, 2, 19, 0, 6, 19, 27, 21, 25, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[26];
    char16 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(7, 16, 29, 26, 1, 26, 24, 12, 14, 2, 26, 24, 14, 30, 2, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[27];
    char16 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(7, 20, 31, 3, 10, 18, 5, 0, 25, 18, 1, 26, 2, 23, 9, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[28];
    char16 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(1, 3, 31, 5, 22, 27, 16, 18, 25, 16, 21, 6, 5, 13, 7, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[29];
    char16 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(27, 20, 10, 22, 14, 23, 12, 19, 1, 4, 22, 17, 17, 2, 21, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[30];
    char16 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(8, 31, 13, 8, 6, 12, 13, 8, 20, 17, 30, 1, 21, 31, 16, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[31];
    char16 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(13, 19, 3, 26, 15, 7, 4, 27, 18, 31, 23, 20, 30, 18, 9, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
