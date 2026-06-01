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
    uchar8 mask = (uchar8)(4, 24, 17, 27, 4, 14, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 src2 = secondSource[1];
    uchar8 mask = (uchar8)(1, 19, 13, 22, 13, 13, 21, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 src2 = secondSource[2];
    uchar8 mask = (uchar8)(12, 28, 7, 29, 3, 27, 18, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 src2 = secondSource[3];
    uchar8 mask = (uchar8)(6, 23, 12, 12, 0, 6, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 src2 = secondSource[4];
    uchar8 mask = (uchar8)(20, 3, 3, 21, 21, 2, 27, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 src2 = secondSource[5];
    uchar8 mask = (uchar8)(27, 5, 5, 8, 14, 26, 28, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 src2 = secondSource[6];
    uchar8 mask = (uchar8)(23, 6, 27, 9, 12, 2, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 src2 = secondSource[7];
    uchar8 mask = (uchar8)(28, 15, 13, 17, 21, 19, 13, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 src2 = secondSource[8];
    uchar8 mask = (uchar8)(22, 6, 19, 16, 14, 17, 17, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 src2 = secondSource[9];
    uchar8 mask = (uchar8)(19, 16, 28, 23, 21, 3, 22, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 src2 = secondSource[10];
    uchar8 mask = (uchar8)(31, 15, 2, 9, 6, 7, 10, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 src2 = secondSource[11];
    uchar8 mask = (uchar8)(30, 12, 7, 8, 18, 21, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 src2 = secondSource[12];
    uchar8 mask = (uchar8)(8, 4, 8, 18, 22, 5, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 src2 = secondSource[13];
    uchar8 mask = (uchar8)(24, 29, 9, 12, 23, 19, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 src2 = secondSource[14];
    uchar8 mask = (uchar8)(13, 10, 4, 22, 3, 11, 17, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 src2 = secondSource[15];
    uchar8 mask = (uchar8)(20, 18, 2, 8, 4, 31, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 src2 = secondSource[16];
    uchar8 mask = (uchar8)(5, 13, 7, 4, 22, 6, 2, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 src2 = secondSource[17];
    uchar8 mask = (uchar8)(21, 27, 12, 19, 4, 30, 31, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 src2 = secondSource[18];
    uchar8 mask = (uchar8)(16, 14, 9, 10, 1, 0, 10, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 src2 = secondSource[19];
    uchar8 mask = (uchar8)(19, 27, 7, 26, 18, 7, 8, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 src2 = secondSource[20];
    uchar8 mask = (uchar8)(1, 7, 13, 30, 11, 24, 7, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 src2 = secondSource[21];
    uchar8 mask = (uchar8)(16, 13, 12, 8, 30, 13, 19, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 src2 = secondSource[22];
    uchar8 mask = (uchar8)(11, 10, 6, 0, 21, 4, 29, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 src2 = secondSource[23];
    uchar8 mask = (uchar8)(20, 29, 26, 13, 21, 21, 30, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 src2 = secondSource[24];
    uchar8 mask = (uchar8)(13, 6, 24, 5, 16, 27, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 src2 = secondSource[25];
    uchar8 mask = (uchar8)(0, 24, 13, 19, 21, 7, 27, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 src2 = secondSource[26];
    uchar8 mask = (uchar8)(1, 12, 30, 13, 28, 23, 27, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 src2 = secondSource[27];
    uchar8 mask = (uchar8)(20, 27, 14, 28, 25, 15, 6, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 src2 = secondSource[28];
    uchar8 mask = (uchar8)(9, 30, 5, 11, 31, 12, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 src2 = secondSource[29];
    uchar8 mask = (uchar8)(22, 6, 14, 6, 1, 15, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 src2 = secondSource[30];
    uchar8 mask = (uchar8)(29, 13, 23, 29, 17, 25, 6, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 src2 = secondSource[31];
    uchar8 mask = (uchar8)(0, 19, 24, 13, 9, 26, 6, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
