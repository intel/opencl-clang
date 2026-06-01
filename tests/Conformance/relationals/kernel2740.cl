// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *secondSource,
                          __global char16 *source, __global char8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 , src2;
  char8 tmp;
  tmp = (char8)((char)0);
  {
    char16 src1 = source[0];
    char16 src2 = secondSource[0];
    uchar8 mask = (uchar8)(14, 13, 8, 29, 28, 30, 12, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[1];
    char16 src2 = secondSource[1];
    uchar8 mask = (uchar8)(1, 25, 12, 26, 13, 29, 27, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[2];
    char16 src2 = secondSource[2];
    uchar8 mask = (uchar8)(25, 14, 6, 26, 26, 13, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[3];
    char16 src2 = secondSource[3];
    uchar8 mask = (uchar8)(10, 15, 2, 11, 1, 18, 21, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[4];
    char16 src2 = secondSource[4];
    uchar8 mask = (uchar8)(29, 17, 15, 1, 27, 7, 25, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[5];
    char16 src2 = secondSource[5];
    uchar8 mask = (uchar8)(21, 3, 31, 19, 25, 5, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[6];
    char16 src2 = secondSource[6];
    uchar8 mask = (uchar8)(25, 15, 22, 13, 12, 20, 2, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[7];
    char16 src2 = secondSource[7];
    uchar8 mask = (uchar8)(6, 1, 25, 15, 7, 26, 31, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[8];
    char16 src2 = secondSource[8];
    uchar8 mask = (uchar8)(22, 13, 15, 3, 18, 16, 19, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[9];
    char16 src2 = secondSource[9];
    uchar8 mask = (uchar8)(31, 9, 5, 21, 8, 23, 22, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[10];
    char16 src2 = secondSource[10];
    uchar8 mask = (uchar8)(7, 17, 27, 16, 11, 23, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[11];
    char16 src2 = secondSource[11];
    uchar8 mask = (uchar8)(1, 10, 19, 3, 26, 14, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[12];
    char16 src2 = secondSource[12];
    uchar8 mask = (uchar8)(29, 6, 24, 5, 1, 10, 18, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[13];
    char16 src2 = secondSource[13];
    uchar8 mask = (uchar8)(18, 25, 6, 31, 10, 13, 14, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[14];
    char16 src2 = secondSource[14];
    uchar8 mask = (uchar8)(1, 29, 4, 11, 5, 15, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[15];
    char16 src2 = secondSource[15];
    uchar8 mask = (uchar8)(23, 3, 26, 12, 5, 30, 24, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[16];
    char16 src2 = secondSource[16];
    uchar8 mask = (uchar8)(21, 24, 28, 3, 31, 0, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[17];
    char16 src2 = secondSource[17];
    uchar8 mask = (uchar8)(2, 12, 25, 29, 5, 4, 6, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[18];
    char16 src2 = secondSource[18];
    uchar8 mask = (uchar8)(28, 17, 30, 5, 10, 25, 26, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[19];
    char16 src2 = secondSource[19];
    uchar8 mask = (uchar8)(27, 2, 19, 27, 18, 11, 18, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[20];
    char16 src2 = secondSource[20];
    uchar8 mask = (uchar8)(9, 7, 19, 28, 7, 18, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[21];
    char16 src2 = secondSource[21];
    uchar8 mask = (uchar8)(13, 24, 22, 26, 19, 10, 30, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[22];
    char16 src2 = secondSource[22];
    uchar8 mask = (uchar8)(20, 21, 4, 22, 5, 9, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[23];
    char16 src2 = secondSource[23];
    uchar8 mask = (uchar8)(6, 12, 19, 11, 26, 2, 28, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[24];
    char16 src2 = secondSource[24];
    uchar8 mask = (uchar8)(12, 18, 17, 31, 25, 24, 9, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[25];
    char16 src2 = secondSource[25];
    uchar8 mask = (uchar8)(19, 13, 5, 3, 15, 25, 5, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[26];
    char16 src2 = secondSource[26];
    uchar8 mask = (uchar8)(14, 15, 12, 14, 13, 7, 7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[27];
    char16 src2 = secondSource[27];
    uchar8 mask = (uchar8)(4, 10, 8, 0, 7, 17, 23, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[28];
    char16 src2 = secondSource[28];
    uchar8 mask = (uchar8)(22, 10, 18, 15, 2, 28, 18, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[29];
    char16 src2 = secondSource[29];
    uchar8 mask = (uchar8)(2, 19, 0, 11, 11, 15, 7, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[30];
    char16 src2 = secondSource[30];
    uchar8 mask = (uchar8)(19, 24, 29, 27, 23, 21, 24, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[31];
    char16 src2 = secondSource[31];
    uchar8 mask = (uchar8)(30, 27, 20, 7, 18, 11, 19, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
