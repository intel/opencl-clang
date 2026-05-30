// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *secondSource,
                          __global uchar8 *source, __global uchar8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar8 src1 , src2;
  uchar8 tmp;
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[0];
    uchar8 src2 = secondSource[0];
    uchar8 mask = (uchar8)(3, 5, 5, 8, 2, 12, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar8 src2 = secondSource[1];
    uchar8 mask = (uchar8)(8, 5, 5, 14, 8, 8, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar8 src2 = secondSource[2];
    uchar8 mask = (uchar8)(9, 14, 15, 9, 3, 2, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar8 src2 = secondSource[3];
    uchar8 mask = (uchar8)(0, 0, 0, 10, 1, 3, 10, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar8 src2 = secondSource[4];
    uchar8 mask = (uchar8)(8, 1, 2, 4, 2, 0, 8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar8 src2 = secondSource[5];
    uchar8 mask = (uchar8)(15, 13, 2, 3, 4, 1, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar8 src2 = secondSource[6];
    uchar8 mask = (uchar8)(9, 8, 14, 7, 3, 8, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar8 src2 = secondSource[7];
    uchar8 mask = (uchar8)(14, 15, 11, 14, 8, 11, 10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar8 src2 = secondSource[8];
    uchar8 mask = (uchar8)(11, 10, 11, 11, 7, 9, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar8 src2 = secondSource[9];
    uchar8 mask = (uchar8)(3, 6, 14, 9, 0, 3, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar8 src2 = secondSource[10];
    uchar8 mask = (uchar8)(11, 11, 9, 7, 6, 3, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar8 src2 = secondSource[11];
    uchar8 mask = (uchar8)(2, 0, 11, 7, 7, 10, 5, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar8 src2 = secondSource[12];
    uchar8 mask = (uchar8)(5, 3, 6, 5, 10, 7, 9, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar8 src2 = secondSource[13];
    uchar8 mask = (uchar8)(1, 5, 2, 7, 1, 15, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar8 src2 = secondSource[14];
    uchar8 mask = (uchar8)(12, 0, 13, 3, 6, 1, 15, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar8 src2 = secondSource[15];
    uchar8 mask = (uchar8)(13, 8, 13, 12, 5, 14, 15, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar8 src2 = secondSource[16];
    uchar8 mask = (uchar8)(11, 4, 5, 3, 14, 9, 0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar8 src2 = secondSource[17];
    uchar8 mask = (uchar8)(9, 14, 8, 7, 1, 15, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar8 src2 = secondSource[18];
    uchar8 mask = (uchar8)(4, 13, 6, 9, 7, 11, 13, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar8 src2 = secondSource[19];
    uchar8 mask = (uchar8)(9, 12, 9, 8, 5, 14, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar8 src2 = secondSource[20];
    uchar8 mask = (uchar8)(7, 3, 4, 10, 5, 13, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar8 src2 = secondSource[21];
    uchar8 mask = (uchar8)(13, 9, 14, 13, 13, 7, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar8 src2 = secondSource[22];
    uchar8 mask = (uchar8)(11, 14, 5, 14, 7, 10, 15, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar8 src2 = secondSource[23];
    uchar8 mask = (uchar8)(5, 5, 2, 9, 7, 11, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar8 src2 = secondSource[24];
    uchar8 mask = (uchar8)(2, 8, 1, 15, 4, 4, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar8 src2 = secondSource[25];
    uchar8 mask = (uchar8)(10, 2, 3, 3, 9, 4, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar8 src2 = secondSource[26];
    uchar8 mask = (uchar8)(8, 12, 12, 8, 0, 13, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar8 src2 = secondSource[27];
    uchar8 mask = (uchar8)(15, 15, 7, 2, 1, 6, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar8 src2 = secondSource[28];
    uchar8 mask = (uchar8)(0, 10, 9, 1, 15, 14, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar8 src2 = secondSource[29];
    uchar8 mask = (uchar8)(9, 6, 5, 5, 3, 11, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar8 src2 = secondSource[30];
    uchar8 mask = (uchar8)(14, 0, 0, 0, 9, 12, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar8 src2 = secondSource[31];
    uchar8 mask = (uchar8)(9, 2, 13, 14, 7, 11, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
