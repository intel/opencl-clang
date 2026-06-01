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
        (ulong16)(14, 2, 4, 13, 0, 14, 6, 11, 7, 11, 13, 0, 4, 9, 13, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[1];
    ulong8 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(7, 0, 14, 9, 1, 9, 4, 12, 8, 6, 7, 10, 11, 12, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[2];
    ulong8 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(14, 6, 13, 8, 0, 4, 0, 11, 15, 4, 6, 5, 7, 2, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[3];
    ulong8 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(1, 1, 12, 2, 2, 3, 15, 2, 2, 6, 0, 10, 5, 8, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[4];
    ulong8 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(7, 13, 5, 1, 15, 12, 5, 9, 0, 6, 0, 7, 13, 5, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[5];
    ulong8 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(15, 10, 6, 5, 2, 5, 9, 10, 6, 3, 3, 0, 9, 7, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[6];
    ulong8 src2 = secondSource[6];
    ulong16 mask = (ulong16)(5, 1, 1, 8, 14, 0, 9, 2, 2, 12, 4, 9, 15, 5, 9, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[7];
    ulong8 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(9, 4, 8, 11, 13, 3, 15, 15, 10, 13, 12, 14, 14, 0, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[8];
    ulong8 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(12, 15, 11, 14, 2, 13, 15, 2, 1, 13, 9, 1, 8, 7, 8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[9];
    ulong8 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(6, 15, 14, 7, 9, 12, 0, 13, 15, 12, 7, 14, 1, 8, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[10];
    ulong8 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(1, 13, 12, 8, 15, 9, 8, 15, 7, 6, 9, 14, 6, 6, 5, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[11];
    ulong8 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(11, 3, 0, 5, 7, 0, 8, 10, 14, 6, 14, 3, 2, 7, 14, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[12];
    ulong8 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(4, 10, 6, 7, 8, 3, 13, 13, 6, 13, 14, 4, 13, 2, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[13];
    ulong8 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(5, 4, 2, 13, 9, 4, 15, 14, 10, 8, 14, 1, 5, 15, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[14];
    ulong8 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(6, 10, 5, 9, 8, 4, 15, 9, 4, 13, 4, 3, 8, 15, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[15];
    ulong8 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(14, 10, 12, 5, 8, 6, 9, 11, 14, 0, 13, 4, 2, 13, 13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[16];
    ulong8 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(14, 3, 14, 1, 0, 9, 3, 14, 2, 2, 8, 13, 8, 14, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[17];
    ulong8 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(14, 6, 9, 7, 4, 1, 5, 13, 9, 13, 1, 9, 11, 6, 11, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[18];
    ulong8 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(14, 9, 1, 9, 5, 11, 12, 4, 9, 8, 13, 2, 6, 4, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[19];
    ulong8 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(12, 1, 14, 13, 10, 12, 1, 7, 13, 14, 1, 2, 0, 10, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[20];
    ulong8 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(9, 8, 14, 2, 8, 9, 14, 4, 12, 12, 7, 7, 4, 7, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[21];
    ulong8 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(8, 3, 10, 0, 10, 11, 7, 12, 0, 1, 4, 12, 1, 14, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[22];
    ulong8 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(11, 1, 4, 15, 11, 1, 6, 5, 10, 14, 11, 8, 1, 6, 3, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[23];
    ulong8 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(9, 13, 4, 4, 1, 2, 8, 7, 15, 13, 3, 1, 0, 14, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[24];
    ulong8 src2 = secondSource[24];
    ulong16 mask = (ulong16)(2, 8, 8, 11, 5, 6, 4, 8, 14, 6, 3, 0, 1, 5, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[25];
    ulong8 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(7, 13, 2, 5, 6, 13, 5, 7, 15, 15, 10, 8, 6, 6, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[26];
    ulong8 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(8, 4, 8, 1, 8, 3, 11, 9, 7, 7, 11, 15, 6, 13, 11, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[27];
    ulong8 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(5, 5, 9, 9, 12, 4, 9, 6, 13, 2, 11, 13, 7, 1, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[28];
    ulong8 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(8, 2, 12, 15, 3, 1, 10, 15, 3, 8, 7, 8, 10, 10, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[29];
    ulong8 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(1, 14, 14, 14, 5, 7, 9, 5, 12, 0, 1, 6, 3, 14, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[30];
    ulong8 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(2, 7, 1, 3, 7, 12, 0, 12, 12, 15, 15, 3, 9, 7, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[31];
    ulong8 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(3, 7, 3, 6, 14, 4, 13, 7, 15, 4, 3, 9, 6, 14, 2, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
