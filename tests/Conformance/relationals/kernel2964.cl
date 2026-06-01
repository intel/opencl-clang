// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *secondSource,
                          __global ulong16 *source, __global ulong8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 , src2;
  ulong8 tmp;
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong16 src2 = secondSource[0];
    ulong8 mask = (ulong8)(14, 25, 29, 29, 25, 4, 17, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 src2 = secondSource[1];
    ulong8 mask = (ulong8)(12, 19, 20, 31, 4, 0, 0, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 src2 = secondSource[2];
    ulong8 mask = (ulong8)(26, 8, 23, 15, 28, 26, 18, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 src2 = secondSource[3];
    ulong8 mask = (ulong8)(26, 28, 18, 13, 7, 17, 22, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 src2 = secondSource[4];
    ulong8 mask = (ulong8)(29, 3, 30, 17, 6, 17, 26, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 src2 = secondSource[5];
    ulong8 mask = (ulong8)(20, 2, 20, 16, 26, 1, 7, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 src2 = secondSource[6];
    ulong8 mask = (ulong8)(15, 18, 24, 6, 12, 24, 9, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 src2 = secondSource[7];
    ulong8 mask = (ulong8)(1, 3, 18, 13, 11, 17, 12, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 src2 = secondSource[8];
    ulong8 mask = (ulong8)(15, 11, 23, 1, 26, 2, 5, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 src2 = secondSource[9];
    ulong8 mask = (ulong8)(14, 27, 18, 8, 12, 5, 24, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 src2 = secondSource[10];
    ulong8 mask = (ulong8)(28, 4, 17, 8, 26, 7, 19, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 src2 = secondSource[11];
    ulong8 mask = (ulong8)(16, 31, 27, 11, 23, 20, 20, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 src2 = secondSource[12];
    ulong8 mask = (ulong8)(24, 28, 16, 1, 5, 10, 26, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 src2 = secondSource[13];
    ulong8 mask = (ulong8)(16, 26, 29, 8, 31, 6, 21, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 src2 = secondSource[14];
    ulong8 mask = (ulong8)(9, 12, 18, 24, 11, 9, 8, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 src2 = secondSource[15];
    ulong8 mask = (ulong8)(14, 17, 13, 18, 19, 24, 27, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 src2 = secondSource[16];
    ulong8 mask = (ulong8)(11, 9, 14, 26, 26, 4, 6, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 src2 = secondSource[17];
    ulong8 mask = (ulong8)(4, 21, 17, 4, 26, 29, 11, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 src2 = secondSource[18];
    ulong8 mask = (ulong8)(20, 25, 0, 18, 29, 23, 19, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 src2 = secondSource[19];
    ulong8 mask = (ulong8)(8, 23, 2, 22, 7, 9, 20, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 src2 = secondSource[20];
    ulong8 mask = (ulong8)(21, 6, 22, 8, 27, 3, 17, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 src2 = secondSource[21];
    ulong8 mask = (ulong8)(7, 10, 31, 15, 3, 5, 9, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 src2 = secondSource[22];
    ulong8 mask = (ulong8)(22, 4, 19, 30, 17, 22, 3, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 src2 = secondSource[23];
    ulong8 mask = (ulong8)(31, 27, 4, 4, 10, 10, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 src2 = secondSource[24];
    ulong8 mask = (ulong8)(7, 17, 9, 26, 22, 25, 24, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 src2 = secondSource[25];
    ulong8 mask = (ulong8)(18, 9, 27, 12, 22, 31, 14, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 src2 = secondSource[26];
    ulong8 mask = (ulong8)(19, 21, 14, 2, 30, 26, 15, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 src2 = secondSource[27];
    ulong8 mask = (ulong8)(1, 3, 1, 16, 13, 19, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 src2 = secondSource[28];
    ulong8 mask = (ulong8)(28, 21, 30, 9, 3, 14, 16, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 src2 = secondSource[29];
    ulong8 mask = (ulong8)(10, 20, 28, 30, 1, 22, 30, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 src2 = secondSource[30];
    ulong8 mask = (ulong8)(27, 18, 2, 0, 27, 24, 21, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 src2 = secondSource[31];
    ulong8 mask = (ulong8)(8, 15, 19, 9, 7, 30, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
