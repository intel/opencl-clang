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
    uchar8 mask = (uchar8)(3, 8, 2, 10, 12, 4, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[1];
    char8 src2 = secondSource[1];
    uchar8 mask = (uchar8)(10, 15, 13, 2, 3, 1, 5, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[2];
    char8 src2 = secondSource[2];
    uchar8 mask = (uchar8)(11, 10, 6, 5, 0, 1, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[3];
    char8 src2 = secondSource[3];
    uchar8 mask = (uchar8)(14, 0, 6, 15, 5, 11, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[4];
    char8 src2 = secondSource[4];
    uchar8 mask = (uchar8)(10, 14, 5, 9, 1, 11, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[5];
    char8 src2 = secondSource[5];
    uchar8 mask = (uchar8)(11, 13, 14, 15, 3, 6, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[6];
    char8 src2 = secondSource[6];
    uchar8 mask = (uchar8)(11, 6, 3, 12, 2, 0, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[7];
    char8 src2 = secondSource[7];
    uchar8 mask = (uchar8)(13, 10, 8, 4, 0, 7, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[8];
    char8 src2 = secondSource[8];
    uchar8 mask = (uchar8)(10, 6, 8, 10, 9, 10, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[9];
    char8 src2 = secondSource[9];
    uchar8 mask = (uchar8)(13, 0, 8, 6, 11, 6, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[10];
    char8 src2 = secondSource[10];
    uchar8 mask = (uchar8)(6, 15, 14, 15, 0, 2, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[11];
    char8 src2 = secondSource[11];
    uchar8 mask = (uchar8)(9, 15, 4, 4, 3, 11, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[12];
    char8 src2 = secondSource[12];
    uchar8 mask = (uchar8)(5, 7, 11, 9, 9, 2, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[13];
    char8 src2 = secondSource[13];
    uchar8 mask = (uchar8)(13, 11, 13, 10, 6, 10, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[14];
    char8 src2 = secondSource[14];
    uchar8 mask = (uchar8)(14, 15, 10, 2, 1, 9, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[15];
    char8 src2 = secondSource[15];
    uchar8 mask = (uchar8)(5, 8, 15, 13, 0, 10, 9, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[16];
    char8 src2 = secondSource[16];
    uchar8 mask = (uchar8)(11, 10, 4, 7, 15, 7, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[17];
    char8 src2 = secondSource[17];
    uchar8 mask = (uchar8)(14, 15, 0, 4, 9, 6, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[18];
    char8 src2 = secondSource[18];
    uchar8 mask = (uchar8)(13, 6, 10, 1, 8, 3, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[19];
    char8 src2 = secondSource[19];
    uchar8 mask = (uchar8)(8, 7, 10, 13, 15, 5, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[20];
    char8 src2 = secondSource[20];
    uchar8 mask = (uchar8)(15, 13, 15, 1, 10, 13, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[21];
    char8 src2 = secondSource[21];
    uchar8 mask = (uchar8)(7, 10, 14, 8, 0, 12, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[22];
    char8 src2 = secondSource[22];
    uchar8 mask = (uchar8)(1, 9, 12, 9, 5, 11, 10, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[23];
    char8 src2 = secondSource[23];
    uchar8 mask = (uchar8)(9, 8, 6, 7, 8, 15, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[24];
    char8 src2 = secondSource[24];
    uchar8 mask = (uchar8)(15, 6, 9, 6, 9, 9, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[25];
    char8 src2 = secondSource[25];
    uchar8 mask = (uchar8)(15, 3, 8, 8, 12, 14, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[26];
    char8 src2 = secondSource[26];
    uchar8 mask = (uchar8)(6, 1, 4, 4, 4, 8, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[27];
    char8 src2 = secondSource[27];
    uchar8 mask = (uchar8)(9, 7, 7, 10, 0, 14, 15, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[28];
    char8 src2 = secondSource[28];
    uchar8 mask = (uchar8)(15, 5, 3, 6, 0, 2, 8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[29];
    char8 src2 = secondSource[29];
    uchar8 mask = (uchar8)(15, 14, 14, 15, 9, 3, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[30];
    char8 src2 = secondSource[30];
    uchar8 mask = (uchar8)(5, 2, 14, 13, 7, 14, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[31];
    char8 src2 = secondSource[31];
    uchar8 mask = (uchar8)(3, 15, 4, 12, 1, 5, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
