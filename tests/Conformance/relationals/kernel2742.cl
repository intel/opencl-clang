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
        (uchar16)(22, 26, 15, 12, 28, 28, 28, 23, 11, 2, 17, 24, 8, 26, 20, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[1];
    char16 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(31, 21, 26, 7, 11, 10, 3, 4, 30, 1, 12, 27, 9, 29, 10, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[2];
    char16 src2 = secondSource[2];
    uchar16 mask =
        (uchar16)(15, 5, 30, 0, 31, 11, 9, 17, 11, 13, 16, 21, 0, 8, 5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[3];
    char16 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(29, 0, 0, 20, 3, 27, 13, 29, 23, 18, 8, 6, 9, 13, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[4];
    char16 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(27, 1, 7, 0, 17, 9, 31, 22, 23, 20, 10, 24, 24, 28, 30, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[5];
    char16 src2 = secondSource[5];
    uchar16 mask =
        (uchar16)(11, 25, 22, 1, 2, 30, 28, 10, 3, 28, 11, 4, 17, 20, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[6];
    char16 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(20, 25, 17, 4, 22, 16, 11, 31, 17, 23, 25, 4, 25, 21, 22, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[7];
    char16 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(17, 26, 21, 9, 2, 4, 15, 27, 27, 11, 19, 14, 30, 30, 8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[8];
    char16 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(3, 2, 20, 21, 2, 22, 25, 14, 8, 22, 17, 12, 25, 28, 25, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[9];
    char16 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(15, 8, 31, 15, 15, 23, 8, 17, 9, 16, 23, 26, 13, 20, 13, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[10];
    char16 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(0, 8, 9, 3, 27, 5, 25, 6, 23, 17, 0, 16, 0, 19, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[11];
    char16 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(15, 7, 29, 1, 12, 0, 9, 11, 18, 23, 29, 22, 23, 21, 27, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[12];
    char16 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(5, 30, 4, 10, 17, 13, 22, 25, 30, 2, 11, 5, 11, 10, 16, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[13];
    char16 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(21, 21, 18, 11, 23, 29, 12, 25, 27, 0, 5, 14, 10, 13, 24, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[14];
    char16 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(10, 9, 21, 21, 9, 7, 5, 23, 9, 15, 28, 2, 14, 13, 7, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[15];
    char16 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(10, 4, 0, 16, 24, 5, 7, 29, 19, 17, 0, 5, 26, 17, 5, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[16];
    char16 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(0, 26, 9, 10, 29, 23, 8, 21, 16, 23, 13, 15, 9, 29, 29, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[17];
    char16 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(25, 30, 24, 3, 16, 29, 26, 24, 14, 30, 14, 17, 15, 29, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[18];
    char16 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(29, 0, 8, 22, 6, 27, 7, 28, 26, 1, 24, 11, 13, 14, 0, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[19];
    char16 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(31, 9, 4, 22, 27, 7, 25, 19, 30, 3, 24, 24, 10, 1, 7, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[20];
    char16 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(12, 25, 6, 19, 23, 24, 26, 0, 20, 13, 5, 18, 1, 31, 18, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[21];
    char16 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(14, 31, 6, 16, 11, 2, 17, 19, 20, 26, 15, 28, 31, 16, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[22];
    char16 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(21, 20, 29, 1, 7, 30, 6, 7, 24, 20, 15, 19, 31, 23, 18, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[23];
    char16 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(29, 8, 0, 6, 4, 23, 21, 5, 13, 30, 26, 6, 13, 16, 22, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[24];
    char16 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(18, 5, 3, 12, 22, 24, 22, 9, 3, 11, 17, 6, 10, 24, 14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[25];
    char16 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(13, 8, 3, 15, 5, 6, 2, 7, 6, 29, 27, 25, 0, 8, 13, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[26];
    char16 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(25, 11, 3, 13, 7, 22, 23, 25, 20, 8, 18, 5, 5, 14, 25, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[27];
    char16 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(4, 25, 4, 5, 25, 10, 11, 6, 10, 1, 8, 18, 10, 24, 10, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[28];
    char16 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(22, 22, 7, 24, 10, 14, 24, 3, 29, 8, 19, 17, 3, 29, 17, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[29];
    char16 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(20, 5, 10, 14, 26, 26, 25, 3, 18, 2, 4, 29, 22, 27, 28, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[30];
    char16 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(8, 23, 30, 25, 24, 10, 9, 13, 19, 27, 9, 0, 3, 10, 26, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char16 src1 = source[31];
    char16 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(21, 14, 19, 12, 4, 1, 12, 23, 28, 30, 5, 22, 1, 21, 6, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
