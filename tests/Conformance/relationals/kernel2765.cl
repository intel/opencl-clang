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
    uchar8 mask = (uchar8)(6, 2, 2, 0, 1, 10, 6, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar8 src2 = secondSource[1];
    uchar8 mask = (uchar8)(10, 11, 4, 10, 14, 7, 11, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar8 src2 = secondSource[2];
    uchar8 mask = (uchar8)(10, 5, 11, 9, 0, 8, 13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar8 src2 = secondSource[3];
    uchar8 mask = (uchar8)(14, 3, 0, 4, 9, 1, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar8 src2 = secondSource[4];
    uchar8 mask = (uchar8)(3, 5, 13, 4, 10, 8, 3, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar8 src2 = secondSource[5];
    uchar8 mask = (uchar8)(15, 0, 3, 11, 10, 11, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar8 src2 = secondSource[6];
    uchar8 mask = (uchar8)(11, 9, 1, 8, 15, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar8 src2 = secondSource[7];
    uchar8 mask = (uchar8)(3, 9, 8, 4, 5, 0, 7, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar8 src2 = secondSource[8];
    uchar8 mask = (uchar8)(0, 14, 3, 9, 12, 7, 14, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar8 src2 = secondSource[9];
    uchar8 mask = (uchar8)(3, 14, 12, 11, 0, 6, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar8 src2 = secondSource[10];
    uchar8 mask = (uchar8)(6, 5, 2, 14, 2, 3, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar8 src2 = secondSource[11];
    uchar8 mask = (uchar8)(13, 6, 12, 6, 5, 7, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar8 src2 = secondSource[12];
    uchar8 mask = (uchar8)(13, 14, 8, 15, 7, 15, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar8 src2 = secondSource[13];
    uchar8 mask = (uchar8)(2, 13, 1, 9, 8, 6, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar8 src2 = secondSource[14];
    uchar8 mask = (uchar8)(9, 9, 13, 3, 10, 1, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar8 src2 = secondSource[15];
    uchar8 mask = (uchar8)(2, 3, 2, 9, 14, 4, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar8 src2 = secondSource[16];
    uchar8 mask = (uchar8)(3, 7, 14, 8, 15, 2, 10, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar8 src2 = secondSource[17];
    uchar8 mask = (uchar8)(6, 11, 11, 1, 0, 14, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar8 src2 = secondSource[18];
    uchar8 mask = (uchar8)(5, 15, 13, 12, 4, 8, 0, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar8 src2 = secondSource[19];
    uchar8 mask = (uchar8)(6, 14, 3, 3, 0, 8, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar8 src2 = secondSource[20];
    uchar8 mask = (uchar8)(5, 12, 11, 15, 1, 8, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar8 src2 = secondSource[21];
    uchar8 mask = (uchar8)(5, 6, 10, 7, 14, 8, 2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar8 src2 = secondSource[22];
    uchar8 mask = (uchar8)(13, 15, 9, 13, 0, 15, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar8 src2 = secondSource[23];
    uchar8 mask = (uchar8)(8, 2, 12, 6, 6, 6, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar8 src2 = secondSource[24];
    uchar8 mask = (uchar8)(3, 12, 3, 15, 5, 5, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar8 src2 = secondSource[25];
    uchar8 mask = (uchar8)(11, 14, 10, 5, 13, 2, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar8 src2 = secondSource[26];
    uchar8 mask = (uchar8)(14, 4, 1, 14, 2, 12, 10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar8 src2 = secondSource[27];
    uchar8 mask = (uchar8)(4, 8, 2, 2, 14, 5, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar8 src2 = secondSource[28];
    uchar8 mask = (uchar8)(15, 6, 13, 9, 13, 2, 10, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar8 src2 = secondSource[29];
    uchar8 mask = (uchar8)(3, 7, 12, 3, 0, 9, 9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar8 src2 = secondSource[30];
    uchar8 mask = (uchar8)(7, 7, 12, 1, 0, 11, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar8 src2 = secondSource[31];
    uchar8 mask = (uchar8)(7, 9, 2, 1, 6, 3, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
