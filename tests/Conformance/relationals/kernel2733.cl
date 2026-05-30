// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char8 *secondSource, __global char8 *source,
                          __global char8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char8 src1 , src2;
  char8 tmp;
  tmp = (char8)((char)0);
  {
    char8 src1 = source[0];
    char8 src2 = secondSource[0];
    uchar8 mask = (uchar8)(14, 10, 10, 7, 1, 7, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[1];
    char8 src2 = secondSource[1];
    uchar8 mask = (uchar8)(4, 4, 5, 10, 12, 12, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[2];
    char8 src2 = secondSource[2];
    uchar8 mask = (uchar8)(6, 7, 10, 10, 15, 9, 11, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[3];
    char8 src2 = secondSource[3];
    uchar8 mask = (uchar8)(10, 13, 1, 8, 5, 15, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[4];
    char8 src2 = secondSource[4];
    uchar8 mask = (uchar8)(3, 1, 13, 6, 11, 15, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[5];
    char8 src2 = secondSource[5];
    uchar8 mask = (uchar8)(8, 3, 8, 15, 11, 11, 8, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[6];
    char8 src2 = secondSource[6];
    uchar8 mask = (uchar8)(2, 0, 12, 11, 6, 7, 15, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[7];
    char8 src2 = secondSource[7];
    uchar8 mask = (uchar8)(4, 11, 4, 2, 5, 14, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[8];
    char8 src2 = secondSource[8];
    uchar8 mask = (uchar8)(14, 6, 2, 3, 4, 12, 9, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[9];
    char8 src2 = secondSource[9];
    uchar8 mask = (uchar8)(7, 11, 7, 9, 13, 15, 14, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[10];
    char8 src2 = secondSource[10];
    uchar8 mask = (uchar8)(7, 7, 10, 5, 12, 3, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[11];
    char8 src2 = secondSource[11];
    uchar8 mask = (uchar8)(4, 11, 10, 15, 9, 1, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[12];
    char8 src2 = secondSource[12];
    uchar8 mask = (uchar8)(0, 6, 14, 15, 8, 9, 0, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[13];
    char8 src2 = secondSource[13];
    uchar8 mask = (uchar8)(5, 4, 11, 4, 7, 5, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[14];
    char8 src2 = secondSource[14];
    uchar8 mask = (uchar8)(6, 15, 5, 6, 13, 3, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[15];
    char8 src2 = secondSource[15];
    uchar8 mask = (uchar8)(10, 3, 12, 4, 10, 12, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[16];
    char8 src2 = secondSource[16];
    uchar8 mask = (uchar8)(1, 11, 9, 9, 14, 2, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[17];
    char8 src2 = secondSource[17];
    uchar8 mask = (uchar8)(14, 13, 8, 15, 9, 15, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[18];
    char8 src2 = secondSource[18];
    uchar8 mask = (uchar8)(9, 4, 1, 0, 15, 6, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[19];
    char8 src2 = secondSource[19];
    uchar8 mask = (uchar8)(11, 15, 8, 1, 7, 8, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[20];
    char8 src2 = secondSource[20];
    uchar8 mask = (uchar8)(11, 0, 1, 10, 15, 13, 13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[21];
    char8 src2 = secondSource[21];
    uchar8 mask = (uchar8)(8, 8, 6, 2, 4, 1, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[22];
    char8 src2 = secondSource[22];
    uchar8 mask = (uchar8)(14, 11, 4, 4, 8, 7, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[23];
    char8 src2 = secondSource[23];
    uchar8 mask = (uchar8)(5, 0, 3, 3, 15, 1, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[24];
    char8 src2 = secondSource[24];
    uchar8 mask = (uchar8)(11, 15, 1, 2, 5, 12, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[25];
    char8 src2 = secondSource[25];
    uchar8 mask = (uchar8)(1, 5, 2, 14, 10, 11, 9, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[26];
    char8 src2 = secondSource[26];
    uchar8 mask = (uchar8)(13, 7, 14, 5, 2, 2, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[27];
    char8 src2 = secondSource[27];
    uchar8 mask = (uchar8)(6, 10, 0, 14, 1, 2, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[28];
    char8 src2 = secondSource[28];
    uchar8 mask = (uchar8)(7, 8, 4, 7, 14, 12, 5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[29];
    char8 src2 = secondSource[29];
    uchar8 mask = (uchar8)(14, 1, 15, 6, 7, 15, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[30];
    char8 src2 = secondSource[30];
    uchar8 mask = (uchar8)(4, 12, 12, 14, 4, 11, 6, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[31];
    char8 src2 = secondSource[31];
    uchar8 mask = (uchar8)(7, 6, 9, 6, 15, 15, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
