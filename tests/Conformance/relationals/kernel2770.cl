// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *secondSource,
                          __global uchar16 *source, __global uchar4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar16 src1 , src2;
  uchar4 tmp;
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[0];
    uchar16 src2 = secondSource[0];
    uchar4 mask = (uchar4)(19, 25, 24, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[1];
    uchar16 src2 = secondSource[1];
    uchar4 mask = (uchar4)(18, 11, 12, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[2];
    uchar16 src2 = secondSource[2];
    uchar4 mask = (uchar4)(21, 3, 7, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[3];
    uchar16 src2 = secondSource[3];
    uchar4 mask = (uchar4)(11, 18, 2, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[4];
    uchar16 src2 = secondSource[4];
    uchar4 mask = (uchar4)(26, 21, 2, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[5];
    uchar16 src2 = secondSource[5];
    uchar4 mask = (uchar4)(9, 17, 29, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[6];
    uchar16 src2 = secondSource[6];
    uchar4 mask = (uchar4)(17, 28, 6, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[7];
    uchar16 src2 = secondSource[7];
    uchar4 mask = (uchar4)(31, 16, 28, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[8];
    uchar16 src2 = secondSource[8];
    uchar4 mask = (uchar4)(2, 9, 7, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[9];
    uchar16 src2 = secondSource[9];
    uchar4 mask = (uchar4)(20, 19, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[10];
    uchar16 src2 = secondSource[10];
    uchar4 mask = (uchar4)(17, 23, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[11];
    uchar16 src2 = secondSource[11];
    uchar4 mask = (uchar4)(21, 0, 16, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[12];
    uchar16 src2 = secondSource[12];
    uchar4 mask = (uchar4)(31, 5, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[13];
    uchar16 src2 = secondSource[13];
    uchar4 mask = (uchar4)(16, 8, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[14];
    uchar16 src2 = secondSource[14];
    uchar4 mask = (uchar4)(19, 23, 6, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[15];
    uchar16 src2 = secondSource[15];
    uchar4 mask = (uchar4)(29, 17, 14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[16];
    uchar16 src2 = secondSource[16];
    uchar4 mask = (uchar4)(13, 24, 25, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[17];
    uchar16 src2 = secondSource[17];
    uchar4 mask = (uchar4)(29, 8, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[18];
    uchar16 src2 = secondSource[18];
    uchar4 mask = (uchar4)(24, 27, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[19];
    uchar16 src2 = secondSource[19];
    uchar4 mask = (uchar4)(8, 14, 22, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[20];
    uchar16 src2 = secondSource[20];
    uchar4 mask = (uchar4)(29, 12, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[21];
    uchar16 src2 = secondSource[21];
    uchar4 mask = (uchar4)(4, 25, 31, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[22];
    uchar16 src2 = secondSource[22];
    uchar4 mask = (uchar4)(2, 26, 1, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[23];
    uchar16 src2 = secondSource[23];
    uchar4 mask = (uchar4)(17, 24, 7, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[24];
    uchar16 src2 = secondSource[24];
    uchar4 mask = (uchar4)(9, 22, 19, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[25];
    uchar16 src2 = secondSource[25];
    uchar4 mask = (uchar4)(11, 22, 31, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[26];
    uchar16 src2 = secondSource[26];
    uchar4 mask = (uchar4)(7, 10, 27, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[27];
    uchar16 src2 = secondSource[27];
    uchar4 mask = (uchar4)(28, 18, 14, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[28];
    uchar16 src2 = secondSource[28];
    uchar4 mask = (uchar4)(31, 20, 9, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[29];
    uchar16 src2 = secondSource[29];
    uchar4 mask = (uchar4)(2, 29, 18, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[30];
    uchar16 src2 = secondSource[30];
    uchar4 mask = (uchar4)(0, 19, 15, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar16 src1 = source[31];
    uchar16 src2 = secondSource[31];
    uchar4 mask = (uchar4)(26, 21, 13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
