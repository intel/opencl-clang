// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char8 *secondSource, __global char8 *source,
                          __global char16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char8 src1 , src2;
  char16 tmp;
  tmp = (char16)((char)0);
  {
    char8 src1 = source[0];
    char8 src2 = secondSource[0];
    uchar16 mask =
        (uchar16)(9, 13, 14, 1, 13, 13, 7, 0, 9, 7, 11, 5, 13, 10, 0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[1];
    char8 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(12, 5, 7, 15, 10, 6, 12, 7, 8, 10, 2, 1, 6, 14, 1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[2];
    char8 src2 = secondSource[2];
    uchar16 mask =
        (uchar16)(11, 10, 15, 14, 12, 10, 6, 1, 9, 1, 4, 9, 8, 1, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[3];
    char8 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(11, 6, 4, 15, 15, 8, 10, 14, 1, 7, 0, 14, 15, 0, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[4];
    char8 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(5, 15, 3, 7, 14, 4, 10, 10, 8, 6, 8, 5, 5, 5, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[5];
    char8 src2 = secondSource[5];
    uchar16 mask =
        (uchar16)(6, 7, 3, 2, 10, 10, 5, 13, 12, 11, 6, 6, 8, 2, 12, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[6];
    char8 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(7, 0, 15, 8, 12, 15, 13, 5, 15, 11, 6, 14, 9, 1, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[7];
    char8 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(10, 9, 15, 7, 4, 8, 4, 6, 14, 2, 12, 3, 3, 0, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[8];
    char8 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(11, 0, 5, 3, 6, 13, 9, 14, 7, 5, 12, 10, 0, 0, 6, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[9];
    char8 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(5, 3, 9, 2, 12, 1, 1, 10, 2, 5, 10, 8, 11, 15, 9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[10];
    char8 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(15, 9, 7, 4, 2, 8, 10, 13, 9, 10, 9, 15, 8, 11, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[11];
    char8 src2 = secondSource[11];
    uchar16 mask = (uchar16)(2, 2, 1, 1, 2, 5, 3, 5, 9, 13, 9, 8, 3, 8, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[12];
    char8 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(7, 10, 7, 9, 12, 13, 7, 2, 12, 13, 2, 4, 8, 4, 13, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[13];
    char8 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(2, 1, 7, 2, 9, 15, 2, 10, 12, 4, 1, 14, 15, 5, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[14];
    char8 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(5, 15, 1, 1, 6, 9, 10, 12, 1, 14, 4, 1, 13, 8, 10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[15];
    char8 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(3, 12, 2, 3, 14, 3, 4, 15, 2, 13, 15, 10, 4, 10, 1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[16];
    char8 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(7, 15, 6, 13, 14, 9, 2, 2, 1, 5, 1, 15, 14, 1, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[17];
    char8 src2 = secondSource[17];
    uchar16 mask = (uchar16)(2, 0, 9, 9, 8, 5, 3, 14, 9, 15, 5, 4, 3, 13, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[18];
    char8 src2 = secondSource[18];
    uchar16 mask = (uchar16)(4, 4, 3, 9, 14, 14, 2, 2, 4, 4, 6, 0, 4, 4, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[19];
    char8 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(12, 1, 5, 4, 1, 8, 8, 12, 2, 15, 5, 6, 14, 8, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[20];
    char8 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(10, 7, 8, 3, 2, 14, 10, 11, 13, 6, 1, 7, 12, 3, 11, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[21];
    char8 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(13, 5, 1, 10, 4, 4, 11, 15, 0, 1, 11, 10, 13, 8, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[22];
    char8 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(6, 13, 4, 6, 0, 8, 2, 11, 15, 11, 13, 12, 4, 1, 15, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[23];
    char8 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(5, 13, 4, 14, 2, 10, 14, 4, 15, 11, 5, 12, 11, 3, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[24];
    char8 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(1, 7, 6, 3, 8, 15, 1, 14, 13, 11, 7, 8, 3, 5, 9, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[25];
    char8 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(12, 12, 5, 12, 11, 8, 6, 0, 15, 8, 12, 13, 5, 8, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[26];
    char8 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(10, 7, 3, 8, 1, 0, 14, 4, 15, 14, 4, 4, 4, 7, 2, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[27];
    char8 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(7, 12, 13, 3, 11, 1, 13, 13, 3, 11, 11, 12, 14, 2, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[28];
    char8 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(11, 7, 6, 8, 4, 14, 15, 15, 5, 0, 1, 2, 6, 13, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[29];
    char8 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(12, 15, 15, 11, 13, 0, 14, 11, 7, 4, 11, 8, 4, 2, 1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[30];
    char8 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(5, 3, 11, 4, 4, 11, 13, 3, 12, 4, 3, 1, 5, 9, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[31];
    char8 src2 = secondSource[31];
    uchar16 mask = (uchar16)(3, 14, 5, 9, 5, 3, 12, 0, 0, 1, 1, 3, 9, 8, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
