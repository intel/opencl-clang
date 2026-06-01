// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong8 *secondSource,
                          __global ulong8 *source, __global ulong16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong8 src1 , src2;
  ulong16 tmp;
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[0];
    ulong8 src2 = secondSource[0];
    ulong16 mask =
        (ulong16)(3, 13, 13, 10, 8, 12, 1, 15, 8, 5, 3, 10, 2, 14, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[1];
    ulong8 src2 = secondSource[1];
    ulong16 mask = (ulong16)(3, 11, 0, 5, 14, 5, 7, 8, 9, 1, 2, 3, 0, 15, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[2];
    ulong8 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(13, 14, 4, 3, 10, 12, 12, 9, 15, 8, 9, 0, 6, 13, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[3];
    ulong8 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(15, 2, 11, 2, 3, 2, 2, 10, 3, 4, 14, 7, 9, 2, 13, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[4];
    ulong8 src2 = secondSource[4];
    ulong16 mask = (ulong16)(4, 0, 2, 8, 2, 2, 1, 5, 4, 11, 13, 1, 1, 12, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[5];
    ulong8 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(11, 1, 5, 14, 8, 12, 11, 8, 12, 7, 7, 0, 14, 0, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[6];
    ulong8 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(1, 0, 3, 6, 0, 13, 8, 1, 6, 4, 15, 13, 7, 8, 14, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[7];
    ulong8 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(12, 8, 14, 7, 15, 12, 0, 8, 2, 3, 11, 6, 8, 5, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[8];
    ulong8 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(1, 14, 8, 7, 15, 8, 2, 5, 4, 14, 9, 12, 9, 9, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[9];
    ulong8 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(8, 1, 15, 10, 0, 3, 14, 10, 10, 7, 12, 15, 2, 10, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[10];
    ulong8 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(0, 8, 12, 11, 13, 6, 4, 7, 2, 5, 10, 6, 5, 4, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[11];
    ulong8 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(0, 12, 7, 8, 4, 8, 14, 15, 1, 5, 6, 11, 14, 13, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[12];
    ulong8 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(9, 0, 11, 4, 6, 12, 15, 0, 6, 2, 11, 15, 15, 10, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[13];
    ulong8 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(10, 7, 1, 3, 15, 7, 2, 14, 5, 12, 0, 0, 9, 15, 12, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[14];
    ulong8 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(0, 14, 13, 9, 8, 2, 11, 10, 4, 5, 14, 2, 5, 4, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[15];
    ulong8 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(2, 14, 0, 10, 5, 10, 12, 13, 13, 4, 11, 13, 0, 15, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[16];
    ulong8 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(12, 14, 14, 13, 12, 13, 14, 2, 9, 13, 4, 9, 1, 7, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[17];
    ulong8 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(7, 15, 11, 0, 15, 1, 6, 14, 7, 3, 12, 12, 1, 8, 3, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[18];
    ulong8 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(7, 7, 13, 8, 3, 11, 10, 7, 12, 4, 15, 7, 8, 1, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[19];
    ulong8 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(0, 13, 2, 0, 0, 3, 9, 14, 14, 1, 15, 3, 0, 7, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[20];
    ulong8 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(6, 12, 0, 3, 5, 11, 6, 15, 14, 5, 8, 11, 10, 8, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[21];
    ulong8 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(10, 15, 11, 2, 11, 13, 4, 2, 13, 6, 4, 5, 10, 9, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[22];
    ulong8 src2 = secondSource[22];
    ulong16 mask = (ulong16)(0, 9, 8, 4, 2, 3, 5, 6, 1, 9, 15, 9, 9, 3, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[23];
    ulong8 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(8, 15, 6, 13, 14, 3, 0, 1, 6, 15, 2, 10, 6, 3, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[24];
    ulong8 src2 = secondSource[24];
    ulong16 mask = (ulong16)(7, 6, 3, 9, 2, 5, 14, 12, 8, 8, 11, 1, 1, 2, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[25];
    ulong8 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(14, 14, 12, 4, 5, 10, 15, 13, 13, 3, 13, 0, 15, 14, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[26];
    ulong8 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(13, 12, 15, 6, 10, 12, 11, 14, 12, 8, 8, 13, 7, 12, 2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[27];
    ulong8 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(13, 13, 3, 13, 5, 8, 9, 4, 0, 12, 10, 10, 6, 8, 12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[28];
    ulong8 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(0, 4, 6, 9, 9, 15, 1, 6, 13, 10, 5, 12, 3, 4, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[29];
    ulong8 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(2, 0, 11, 10, 11, 6, 14, 8, 2, 8, 1, 13, 15, 0, 14, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[30];
    ulong8 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(3, 10, 0, 14, 7, 9, 3, 13, 13, 7, 6, 0, 6, 7, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[31];
    ulong8 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(7, 10, 1, 12, 7, 15, 5, 0, 8, 5, 12, 5, 7, 3, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
