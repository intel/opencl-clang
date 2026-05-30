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
    uchar8 mask = (uchar8)(27, 13, 12, 23, 25, 5, 20, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[1];
    char16 src2 = secondSource[1];
    uchar8 mask = (uchar8)(9, 17, 0, 13, 6, 4, 22, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[2];
    char16 src2 = secondSource[2];
    uchar8 mask = (uchar8)(18, 10, 8, 23, 13, 31, 21, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[3];
    char16 src2 = secondSource[3];
    uchar8 mask = (uchar8)(4, 1, 13, 6, 13, 18, 17, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[4];
    char16 src2 = secondSource[4];
    uchar8 mask = (uchar8)(16, 11, 11, 6, 24, 23, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[5];
    char16 src2 = secondSource[5];
    uchar8 mask = (uchar8)(1, 1, 13, 23, 28, 30, 8, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[6];
    char16 src2 = secondSource[6];
    uchar8 mask = (uchar8)(5, 2, 29, 25, 5, 0, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[7];
    char16 src2 = secondSource[7];
    uchar8 mask = (uchar8)(23, 15, 8, 19, 7, 12, 12, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[8];
    char16 src2 = secondSource[8];
    uchar8 mask = (uchar8)(25, 16, 29, 29, 1, 31, 5, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[9];
    char16 src2 = secondSource[9];
    uchar8 mask = (uchar8)(30, 2, 18, 10, 17, 16, 26, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[10];
    char16 src2 = secondSource[10];
    uchar8 mask = (uchar8)(1, 27, 0, 6, 30, 6, 26, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[11];
    char16 src2 = secondSource[11];
    uchar8 mask = (uchar8)(23, 21, 4, 19, 15, 22, 29, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[12];
    char16 src2 = secondSource[12];
    uchar8 mask = (uchar8)(29, 18, 0, 22, 24, 8, 0, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[13];
    char16 src2 = secondSource[13];
    uchar8 mask = (uchar8)(31, 17, 13, 16, 31, 27, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[14];
    char16 src2 = secondSource[14];
    uchar8 mask = (uchar8)(9, 0, 10, 24, 23, 7, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[15];
    char16 src2 = secondSource[15];
    uchar8 mask = (uchar8)(27, 8, 18, 5, 31, 8, 31, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[16];
    char16 src2 = secondSource[16];
    uchar8 mask = (uchar8)(5, 15, 30, 22, 1, 29, 0, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[17];
    char16 src2 = secondSource[17];
    uchar8 mask = (uchar8)(30, 3, 30, 17, 4, 2, 14, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[18];
    char16 src2 = secondSource[18];
    uchar8 mask = (uchar8)(15, 16, 27, 0, 20, 24, 24, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[19];
    char16 src2 = secondSource[19];
    uchar8 mask = (uchar8)(15, 14, 20, 29, 23, 14, 23, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[20];
    char16 src2 = secondSource[20];
    uchar8 mask = (uchar8)(0, 5, 3, 21, 11, 5, 1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[21];
    char16 src2 = secondSource[21];
    uchar8 mask = (uchar8)(12, 22, 12, 9, 29, 19, 18, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[22];
    char16 src2 = secondSource[22];
    uchar8 mask = (uchar8)(22, 1, 28, 12, 14, 28, 0, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[23];
    char16 src2 = secondSource[23];
    uchar8 mask = (uchar8)(9, 30, 26, 30, 28, 26, 11, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[24];
    char16 src2 = secondSource[24];
    uchar8 mask = (uchar8)(9, 0, 29, 30, 11, 6, 20, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[25];
    char16 src2 = secondSource[25];
    uchar8 mask = (uchar8)(8, 21, 3, 22, 16, 30, 29, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[26];
    char16 src2 = secondSource[26];
    uchar8 mask = (uchar8)(19, 14, 6, 3, 21, 27, 24, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[27];
    char16 src2 = secondSource[27];
    uchar8 mask = (uchar8)(10, 27, 17, 10, 21, 29, 5, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[28];
    char16 src2 = secondSource[28];
    uchar8 mask = (uchar8)(30, 22, 14, 0, 31, 22, 6, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[29];
    char16 src2 = secondSource[29];
    uchar8 mask = (uchar8)(15, 8, 5, 18, 0, 27, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[30];
    char16 src2 = secondSource[30];
    uchar8 mask = (uchar8)(12, 10, 13, 2, 28, 24, 20, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char16 src1 = source[31];
    char16 src2 = secondSource[31];
    uchar8 mask = (uchar8)(13, 29, 31, 16, 19, 8, 10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
