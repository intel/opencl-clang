// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *secondSource,
                          __global uchar16 *source, __global uchar8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar16 src1 , src2;
  uchar8 tmp;
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[0];
    uchar16 src2 = secondSource[0];
    uchar8 mask = (uchar8)(21, 11, 20, 1, 7, 9, 23, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 src2 = secondSource[1];
    uchar8 mask = (uchar8)(2, 9, 18, 18, 5, 8, 6, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 src2 = secondSource[2];
    uchar8 mask = (uchar8)(31, 20, 12, 18, 16, 14, 21, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 src2 = secondSource[3];
    uchar8 mask = (uchar8)(15, 4, 23, 14, 0, 19, 21, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 src2 = secondSource[4];
    uchar8 mask = (uchar8)(10, 6, 28, 5, 4, 7, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 src2 = secondSource[5];
    uchar8 mask = (uchar8)(1, 13, 16, 10, 6, 19, 24, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 src2 = secondSource[6];
    uchar8 mask = (uchar8)(1, 19, 7, 5, 26, 3, 1, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 src2 = secondSource[7];
    uchar8 mask = (uchar8)(25, 26, 3, 10, 26, 16, 25, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 src2 = secondSource[8];
    uchar8 mask = (uchar8)(7, 0, 12, 22, 14, 16, 12, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 src2 = secondSource[9];
    uchar8 mask = (uchar8)(6, 27, 7, 15, 22, 27, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 src2 = secondSource[10];
    uchar8 mask = (uchar8)(9, 20, 2, 31, 6, 9, 1, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 src2 = secondSource[11];
    uchar8 mask = (uchar8)(22, 7, 12, 31, 12, 14, 15, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 src2 = secondSource[12];
    uchar8 mask = (uchar8)(8, 16, 11, 2, 18, 25, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 src2 = secondSource[13];
    uchar8 mask = (uchar8)(14, 8, 18, 0, 4, 17, 9, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 src2 = secondSource[14];
    uchar8 mask = (uchar8)(17, 5, 12, 23, 22, 1, 7, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 src2 = secondSource[15];
    uchar8 mask = (uchar8)(15, 31, 26, 5, 4, 10, 28, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 src2 = secondSource[16];
    uchar8 mask = (uchar8)(14, 17, 15, 3, 20, 16, 17, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 src2 = secondSource[17];
    uchar8 mask = (uchar8)(26, 14, 5, 21, 4, 26, 8, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 src2 = secondSource[18];
    uchar8 mask = (uchar8)(31, 9, 3, 10, 16, 21, 24, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 src2 = secondSource[19];
    uchar8 mask = (uchar8)(26, 1, 30, 0, 31, 11, 17, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 src2 = secondSource[20];
    uchar8 mask = (uchar8)(7, 23, 16, 14, 23, 9, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 src2 = secondSource[21];
    uchar8 mask = (uchar8)(8, 0, 26, 0, 26, 18, 17, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 src2 = secondSource[22];
    uchar8 mask = (uchar8)(19, 27, 16, 5, 25, 10, 28, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 src2 = secondSource[23];
    uchar8 mask = (uchar8)(0, 12, 31, 11, 11, 15, 12, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 src2 = secondSource[24];
    uchar8 mask = (uchar8)(11, 25, 27, 29, 23, 0, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 src2 = secondSource[25];
    uchar8 mask = (uchar8)(13, 27, 0, 22, 25, 9, 7, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 src2 = secondSource[26];
    uchar8 mask = (uchar8)(2, 17, 21, 22, 7, 15, 17, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 src2 = secondSource[27];
    uchar8 mask = (uchar8)(5, 31, 25, 31, 31, 16, 3, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 src2 = secondSource[28];
    uchar8 mask = (uchar8)(26, 30, 15, 28, 1, 17, 16, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 src2 = secondSource[29];
    uchar8 mask = (uchar8)(15, 9, 28, 30, 10, 9, 24, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 src2 = secondSource[30];
    uchar8 mask = (uchar8)(4, 2, 12, 28, 17, 19, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 src2 = secondSource[31];
    uchar8 mask = (uchar8)(6, 2, 7, 23, 23, 13, 30, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
