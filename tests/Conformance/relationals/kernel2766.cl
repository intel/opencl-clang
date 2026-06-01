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
    uchar16 mask = (uchar16)(7, 13, 4, 8, 8, 6, 0, 5, 4, 3, 12, 0, 10, 3, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar8 src2 = secondSource[1];
    uchar16 mask =
        (uchar16)(9, 12, 3, 12, 15, 6, 12, 0, 2, 7, 6, 14, 7, 11, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar8 src2 = secondSource[2];
    uchar16 mask =
        (uchar16)(11, 10, 13, 9, 0, 13, 2, 7, 4, 3, 15, 13, 6, 12, 2, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar8 src2 = secondSource[3];
    uchar16 mask =
        (uchar16)(1, 0, 14, 6, 12, 2, 9, 7, 8, 14, 12, 2, 5, 6, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar8 src2 = secondSource[4];
    uchar16 mask =
        (uchar16)(11, 0, 9, 2, 2, 7, 15, 12, 12, 4, 7, 9, 9, 6, 12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar8 src2 = secondSource[5];
    uchar16 mask =
        (uchar16)(7, 7, 11, 11, 12, 5, 7, 15, 3, 8, 9, 2, 8, 10, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar8 src2 = secondSource[6];
    uchar16 mask =
        (uchar16)(0, 0, 12, 5, 8, 13, 6, 7, 13, 6, 3, 14, 4, 10, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar8 src2 = secondSource[7];
    uchar16 mask =
        (uchar16)(6, 8, 4, 6, 4, 5, 7, 9, 12, 15, 12, 6, 12, 0, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar8 src2 = secondSource[8];
    uchar16 mask =
        (uchar16)(0, 3, 15, 5, 6, 8, 3, 1, 15, 1, 13, 8, 14, 13, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar8 src2 = secondSource[9];
    uchar16 mask =
        (uchar16)(11, 2, 8, 14, 8, 10, 15, 10, 11, 12, 9, 8, 6, 14, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar8 src2 = secondSource[10];
    uchar16 mask =
        (uchar16)(1, 14, 4, 3, 11, 2, 3, 4, 2, 4, 1, 7, 13, 1, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar8 src2 = secondSource[11];
    uchar16 mask =
        (uchar16)(3, 15, 6, 2, 10, 10, 9, 10, 14, 4, 10, 14, 8, 10, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar8 src2 = secondSource[12];
    uchar16 mask =
        (uchar16)(10, 9, 12, 4, 9, 2, 12, 5, 14, 8, 11, 10, 5, 13, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar8 src2 = secondSource[13];
    uchar16 mask =
        (uchar16)(10, 4, 10, 5, 0, 8, 11, 13, 3, 8, 0, 12, 2, 9, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar8 src2 = secondSource[14];
    uchar16 mask =
        (uchar16)(8, 13, 13, 7, 1, 11, 13, 13, 10, 10, 3, 0, 11, 7, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar8 src2 = secondSource[15];
    uchar16 mask =
        (uchar16)(1, 4, 4, 9, 10, 14, 6, 9, 12, 0, 8, 8, 13, 4, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar8 src2 = secondSource[16];
    uchar16 mask =
        (uchar16)(11, 11, 7, 1, 8, 0, 4, 15, 4, 2, 3, 13, 5, 4, 3, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar8 src2 = secondSource[17];
    uchar16 mask =
        (uchar16)(3, 5, 15, 3, 7, 7, 10, 12, 5, 12, 9, 11, 7, 14, 9, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar8 src2 = secondSource[18];
    uchar16 mask =
        (uchar16)(11, 6, 10, 3, 12, 5, 2, 3, 1, 0, 5, 14, 7, 12, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar8 src2 = secondSource[19];
    uchar16 mask =
        (uchar16)(12, 10, 11, 0, 14, 12, 11, 8, 1, 2, 10, 6, 6, 1, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar8 src2 = secondSource[20];
    uchar16 mask =
        (uchar16)(9, 4, 4, 10, 8, 14, 9, 0, 8, 5, 0, 7, 5, 11, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar8 src2 = secondSource[21];
    uchar16 mask =
        (uchar16)(5, 3, 8, 2, 5, 3, 3, 4, 3, 15, 11, 0, 10, 4, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar8 src2 = secondSource[22];
    uchar16 mask =
        (uchar16)(6, 14, 10, 4, 7, 5, 7, 8, 13, 1, 7, 1, 14, 2, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar8 src2 = secondSource[23];
    uchar16 mask =
        (uchar16)(1, 8, 1, 8, 15, 12, 6, 7, 9, 11, 6, 11, 2, 15, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar8 src2 = secondSource[24];
    uchar16 mask =
        (uchar16)(3, 5, 9, 11, 8, 5, 5, 13, 0, 1, 5, 11, 6, 2, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar8 src2 = secondSource[25];
    uchar16 mask =
        (uchar16)(11, 8, 3, 10, 3, 8, 10, 8, 10, 8, 8, 12, 1, 4, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar8 src2 = secondSource[26];
    uchar16 mask =
        (uchar16)(0, 0, 12, 2, 12, 10, 14, 11, 1, 10, 14, 1, 14, 12, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar8 src2 = secondSource[27];
    uchar16 mask =
        (uchar16)(12, 3, 4, 9, 4, 6, 11, 11, 10, 7, 10, 0, 5, 10, 8, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar8 src2 = secondSource[28];
    uchar16 mask =
        (uchar16)(4, 10, 9, 14, 12, 5, 11, 3, 6, 8, 8, 12, 12, 10, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar8 src2 = secondSource[29];
    uchar16 mask = (uchar16)(3, 2, 7, 2, 7, 6, 0, 14, 9, 6, 6, 14, 9, 7, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar8 src2 = secondSource[30];
    uchar16 mask = (uchar16)(5, 4, 1, 0, 3, 3, 4, 7, 13, 7, 8, 15, 15, 2, 4, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar8 src2 = secondSource[31];
    uchar16 mask =
        (uchar16)(1, 1, 4, 5, 15, 10, 11, 9, 14, 5, 9, 10, 4, 10, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
