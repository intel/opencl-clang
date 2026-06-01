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
    uchar16 mask = (uchar16)(5, 7, 4, 7, 5, 0, 1, 3, 5, 7, 14, 4, 4, 15, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[1];
    char8 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(15, 8, 11, 0, 8, 4, 12, 3, 1, 9, 7, 14, 1, 9, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[2];
    char8 src2 = secondSource[2];
    uchar16 mask = (uchar16)(2, 4, 5, 4, 6, 7, 15, 9, 4, 8, 7, 4, 12, 2, 13, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[3];
    char8 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(12, 12, 4, 9, 7, 2, 2, 3, 3, 14, 6, 6, 11, 13, 8, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[4];
    char8 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(14, 5, 13, 0, 0, 11, 9, 7, 9, 14, 15, 2, 0, 3, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[5];
    char8 src2 = secondSource[5];
    uchar16 mask = (uchar16)(3, 2, 0, 5, 9, 0, 12, 12, 12, 1, 0, 9, 6, 4, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[6];
    char8 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(3, 1, 3, 11, 3, 14, 5, 0, 4, 4, 15, 6, 5, 15, 14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[7];
    char8 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(2, 13, 12, 4, 0, 7, 7, 13, 0, 12, 12, 3, 15, 4, 0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[8];
    char8 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(14, 15, 12, 1, 5, 12, 14, 11, 4, 13, 6, 14, 1, 14, 10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[9];
    char8 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(0, 15, 7, 5, 10, 14, 13, 15, 2, 10, 12, 10, 11, 5, 8, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[10];
    char8 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(9, 9, 1, 12, 9, 2, 6, 13, 13, 11, 5, 8, 9, 4, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[11];
    char8 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(14, 7, 4, 2, 1, 12, 11, 14, 6, 13, 9, 5, 0, 2, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[12];
    char8 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(14, 10, 9, 3, 0, 11, 6, 9, 15, 7, 10, 12, 2, 15, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[13];
    char8 src2 = secondSource[13];
    uchar16 mask = (uchar16)(15, 8, 8, 5, 0, 0, 9, 0, 4, 9, 1, 1, 6, 0, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[14];
    char8 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(0, 7, 8, 8, 8, 14, 12, 6, 6, 1, 8, 3, 11, 15, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[15];
    char8 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(6, 5, 9, 14, 11, 4, 0, 14, 12, 1, 6, 15, 10, 15, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[16];
    char8 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(11, 0, 11, 5, 3, 2, 10, 4, 13, 10, 3, 7, 12, 11, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[17];
    char8 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(15, 4, 4, 5, 2, 12, 4, 8, 4, 2, 12, 9, 11, 2, 10, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[18];
    char8 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(3, 2, 13, 10, 15, 14, 8, 1, 10, 8, 8, 15, 4, 4, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[19];
    char8 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(5, 7, 3, 15, 14, 12, 13, 4, 7, 3, 5, 3, 15, 6, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[20];
    char8 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(8, 2, 0, 9, 3, 7, 9, 10, 10, 6, 9, 12, 13, 5, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[21];
    char8 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(12, 15, 7, 9, 13, 10, 1, 8, 10, 7, 8, 2, 2, 11, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[22];
    char8 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(5, 8, 9, 4, 14, 6, 8, 6, 1, 10, 13, 11, 5, 5, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[23];
    char8 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(14, 5, 13, 7, 5, 1, 12, 9, 15, 14, 8, 15, 7, 5, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[24];
    char8 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(11, 15, 13, 12, 3, 4, 5, 0, 8, 4, 1, 15, 1, 7, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[25];
    char8 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(4, 5, 6, 3, 7, 9, 15, 3, 15, 11, 2, 7, 14, 2, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[26];
    char8 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(8, 6, 2, 6, 5, 7, 11, 3, 6, 15, 12, 6, 11, 9, 15, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[27];
    char8 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(8, 7, 12, 14, 5, 2, 5, 12, 6, 7, 6, 4, 1, 10, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[28];
    char8 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(1, 2, 14, 5, 0, 4, 7, 11, 4, 12, 2, 1, 12, 12, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[29];
    char8 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(2, 3, 10, 11, 12, 13, 12, 9, 1, 15, 10, 10, 11, 13, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[30];
    char8 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(8, 14, 7, 1, 15, 6, 12, 4, 8, 2, 5, 2, 13, 7, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[31];
    char8 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(1, 14, 7, 15, 13, 0, 7, 4, 0, 0, 9, 14, 15, 8, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
