// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *secondSource,
                          __global uchar8 *source, __global uchar16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar8 src1 , src2;
  uchar16 tmp;
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[0];
    uchar8 src2 = secondSource[0];
    uchar16 mask =
        (uchar16)(3, 6, 6, 6, 4, 14, 10, 10, 6, 11, 15, 2, 15, 15, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar8 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(14, 8, 12, 1, 11, 3, 5, 2, 10, 12, 12, 14, 13, 10, 12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar8 src2 = secondSource[2];
    uchar16 mask =
        (uchar16)(5, 2, 2, 7, 8, 1, 4, 14, 12, 10, 0, 1, 6, 11, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar8 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(1, 14, 10, 1, 3, 4, 2, 13, 4, 1, 0, 4, 10, 2, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar8 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(15, 7, 1, 13, 14, 5, 7, 10, 1, 1, 13, 6, 1, 4, 10, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar8 src2 = secondSource[5];
    uchar16 mask = (uchar16)(3, 1, 7, 6, 9, 2, 14, 10, 4, 8, 6, 7, 3, 13, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar8 src2 = secondSource[6];
    uchar16 mask = (uchar16)(2, 11, 8, 2, 8, 10, 9, 0, 3, 0, 6, 6, 0, 15, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar8 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(4, 12, 7, 9, 11, 4, 12, 12, 6, 4, 12, 2, 11, 3, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar8 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(2, 12, 4, 8, 8, 10, 13, 14, 6, 2, 15, 6, 10, 10, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar8 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(8, 10, 6, 5, 14, 2, 0, 8, 3, 0, 1, 6, 12, 10, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar8 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(11, 11, 8, 7, 13, 4, 15, 6, 2, 1, 2, 7, 10, 6, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar8 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(13, 1, 6, 0, 6, 2, 9, 4, 5, 1, 4, 12, 3, 13, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar8 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(12, 10, 9, 15, 3, 8, 11, 13, 2, 11, 14, 8, 7, 8, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar8 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(3, 4, 9, 3, 15, 4, 9, 10, 10, 8, 4, 6, 5, 10, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar8 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(8, 3, 2, 7, 9, 11, 7, 1, 9, 13, 1, 12, 14, 10, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar8 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(3, 13, 8, 6, 14, 3, 11, 3, 5, 14, 4, 9, 10, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar8 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(5, 7, 7, 8, 12, 14, 5, 4, 12, 10, 12, 11, 0, 14, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar8 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(10, 9, 7, 5, 0, 4, 5, 11, 10, 12, 15, 6, 3, 11, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar8 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(5, 1, 8, 6, 10, 11, 5, 14, 3, 10, 0, 2, 2, 6, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar8 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(3, 1, 5, 13, 1, 5, 6, 8, 2, 9, 9, 14, 6, 1, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar8 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(12, 7, 1, 8, 6, 15, 15, 2, 0, 11, 7, 10, 7, 3, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar8 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(4, 0, 12, 10, 0, 13, 7, 6, 5, 7, 12, 1, 6, 4, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar8 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(11, 15, 0, 5, 5, 2, 7, 1, 11, 2, 5, 1, 1, 13, 13, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar8 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(0, 6, 13, 13, 1, 11, 2, 8, 2, 7, 2, 11, 12, 9, 12, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar8 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(2, 2, 1, 6, 9, 7, 11, 1, 8, 8, 0, 15, 12, 11, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar8 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(11, 9, 3, 12, 1, 5, 15, 6, 7, 0, 11, 13, 1, 7, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar8 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(8, 3, 1, 6, 5, 3, 14, 14, 11, 3, 11, 6, 14, 2, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar8 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(12, 3, 1, 0, 9, 9, 8, 3, 6, 6, 3, 12, 6, 6, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar8 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(11, 11, 7, 13, 15, 6, 12, 11, 0, 9, 12, 8, 11, 4, 0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar8 src2 = secondSource[29];
    uchar16 mask =
        (uchar16)(14, 0, 7, 1, 3, 7, 7, 4, 13, 14, 4, 15, 14, 14, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar8 src2 = secondSource[30];
    uchar16 mask =
        (uchar16)(1, 13, 9, 7, 8, 0, 10, 1, 0, 12, 4, 7, 11, 9, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar8 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(4, 0, 13, 6, 12, 8, 11, 2, 10, 5, 15, 0, 0, 2, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
