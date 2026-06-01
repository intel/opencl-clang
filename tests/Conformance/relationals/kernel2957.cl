// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong8 *secondSource,
                          __global ulong8 *source, __global ulong8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong8 src1 , src2;
  ulong8 tmp;
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[0];
    ulong8 src2 = secondSource[0];
    ulong8 mask = (ulong8)(14, 15, 14, 6, 14, 8, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[1];
    ulong8 src2 = secondSource[1];
    ulong8 mask = (ulong8)(12, 15, 5, 15, 3, 7, 2, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[2];
    ulong8 src2 = secondSource[2];
    ulong8 mask = (ulong8)(9, 2, 11, 3, 8, 7, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[3];
    ulong8 src2 = secondSource[3];
    ulong8 mask = (ulong8)(7, 10, 6, 7, 11, 8, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[4];
    ulong8 src2 = secondSource[4];
    ulong8 mask = (ulong8)(14, 7, 11, 0, 12, 4, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[5];
    ulong8 src2 = secondSource[5];
    ulong8 mask = (ulong8)(8, 8, 6, 7, 15, 11, 14, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[6];
    ulong8 src2 = secondSource[6];
    ulong8 mask = (ulong8)(14, 12, 10, 15, 3, 12, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[7];
    ulong8 src2 = secondSource[7];
    ulong8 mask = (ulong8)(12, 4, 2, 1, 1, 14, 10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[8];
    ulong8 src2 = secondSource[8];
    ulong8 mask = (ulong8)(3, 12, 4, 8, 1, 1, 9, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[9];
    ulong8 src2 = secondSource[9];
    ulong8 mask = (ulong8)(11, 0, 13, 13, 12, 11, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[10];
    ulong8 src2 = secondSource[10];
    ulong8 mask = (ulong8)(11, 0, 7, 12, 8, 9, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[11];
    ulong8 src2 = secondSource[11];
    ulong8 mask = (ulong8)(6, 3, 8, 5, 15, 12, 6, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[12];
    ulong8 src2 = secondSource[12];
    ulong8 mask = (ulong8)(8, 6, 7, 8, 3, 12, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[13];
    ulong8 src2 = secondSource[13];
    ulong8 mask = (ulong8)(11, 12, 0, 11, 4, 4, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[14];
    ulong8 src2 = secondSource[14];
    ulong8 mask = (ulong8)(12, 2, 12, 8, 10, 5, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[15];
    ulong8 src2 = secondSource[15];
    ulong8 mask = (ulong8)(14, 15, 4, 14, 8, 2, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[16];
    ulong8 src2 = secondSource[16];
    ulong8 mask = (ulong8)(10, 7, 1, 8, 1, 7, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[17];
    ulong8 src2 = secondSource[17];
    ulong8 mask = (ulong8)(13, 2, 8, 10, 8, 9, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[18];
    ulong8 src2 = secondSource[18];
    ulong8 mask = (ulong8)(12, 7, 13, 4, 3, 8, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[19];
    ulong8 src2 = secondSource[19];
    ulong8 mask = (ulong8)(14, 4, 0, 15, 0, 3, 12, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[20];
    ulong8 src2 = secondSource[20];
    ulong8 mask = (ulong8)(9, 12, 9, 10, 2, 6, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[21];
    ulong8 src2 = secondSource[21];
    ulong8 mask = (ulong8)(13, 13, 2, 13, 3, 11, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[22];
    ulong8 src2 = secondSource[22];
    ulong8 mask = (ulong8)(13, 12, 3, 12, 0, 4, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[23];
    ulong8 src2 = secondSource[23];
    ulong8 mask = (ulong8)(7, 15, 5, 12, 4, 9, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[24];
    ulong8 src2 = secondSource[24];
    ulong8 mask = (ulong8)(9, 0, 7, 10, 9, 5, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[25];
    ulong8 src2 = secondSource[25];
    ulong8 mask = (ulong8)(7, 13, 15, 11, 2, 13, 7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[26];
    ulong8 src2 = secondSource[26];
    ulong8 mask = (ulong8)(5, 12, 13, 12, 15, 8, 10, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[27];
    ulong8 src2 = secondSource[27];
    ulong8 mask = (ulong8)(14, 7, 7, 4, 8, 11, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[28];
    ulong8 src2 = secondSource[28];
    ulong8 mask = (ulong8)(2, 15, 10, 6, 8, 15, 13, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[29];
    ulong8 src2 = secondSource[29];
    ulong8 mask = (ulong8)(10, 5, 2, 2, 4, 4, 13, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[30];
    ulong8 src2 = secondSource[30];
    ulong8 mask = (ulong8)(1, 0, 10, 1, 5, 4, 9, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[31];
    ulong8 src2 = secondSource[31];
    ulong8 mask = (ulong8)(11, 12, 15, 6, 12, 0, 8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
