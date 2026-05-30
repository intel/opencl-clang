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
    ulong8 mask = (ulong8)(23, 27, 7, 7, 13, 28, 31, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 src2 = secondSource[1];
    ulong8 mask = (ulong8)(31, 29, 21, 3, 20, 27, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 src2 = secondSource[2];
    ulong8 mask = (ulong8)(4, 1, 2, 19, 10, 17, 10, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 src2 = secondSource[3];
    ulong8 mask = (ulong8)(15, 27, 8, 12, 17, 5, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 src2 = secondSource[4];
    ulong8 mask = (ulong8)(5, 2, 12, 8, 30, 2, 7, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 src2 = secondSource[5];
    ulong8 mask = (ulong8)(27, 4, 15, 4, 27, 3, 23, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 src2 = secondSource[6];
    ulong8 mask = (ulong8)(1, 11, 31, 9, 1, 8, 23, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 src2 = secondSource[7];
    ulong8 mask = (ulong8)(26, 25, 8, 0, 5, 16, 20, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 src2 = secondSource[8];
    ulong8 mask = (ulong8)(31, 27, 27, 30, 2, 0, 27, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 src2 = secondSource[9];
    ulong8 mask = (ulong8)(11, 15, 26, 3, 0, 6, 19, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 src2 = secondSource[10];
    ulong8 mask = (ulong8)(17, 3, 0, 30, 17, 20, 7, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 src2 = secondSource[11];
    ulong8 mask = (ulong8)(0, 23, 17, 10, 11, 7, 25, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 src2 = secondSource[12];
    ulong8 mask = (ulong8)(26, 31, 2, 3, 13, 1, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 src2 = secondSource[13];
    ulong8 mask = (ulong8)(6, 21, 18, 6, 22, 18, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 src2 = secondSource[14];
    ulong8 mask = (ulong8)(16, 25, 15, 6, 9, 23, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 src2 = secondSource[15];
    ulong8 mask = (ulong8)(11, 18, 15, 4, 8, 21, 17, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 src2 = secondSource[16];
    ulong8 mask = (ulong8)(24, 15, 12, 22, 3, 5, 20, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 src2 = secondSource[17];
    ulong8 mask = (ulong8)(22, 15, 8, 16, 26, 18, 8, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 src2 = secondSource[18];
    ulong8 mask = (ulong8)(23, 23, 7, 8, 13, 23, 24, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 src2 = secondSource[19];
    ulong8 mask = (ulong8)(8, 19, 23, 0, 11, 25, 31, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 src2 = secondSource[20];
    ulong8 mask = (ulong8)(8, 23, 3, 31, 13, 2, 23, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 src2 = secondSource[21];
    ulong8 mask = (ulong8)(30, 5, 21, 20, 17, 11, 24, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 src2 = secondSource[22];
    ulong8 mask = (ulong8)(19, 11, 21, 2, 17, 29, 8, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 src2 = secondSource[23];
    ulong8 mask = (ulong8)(24, 27, 14, 16, 12, 23, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 src2 = secondSource[24];
    ulong8 mask = (ulong8)(11, 19, 29, 7, 1, 10, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 src2 = secondSource[25];
    ulong8 mask = (ulong8)(22, 10, 20, 29, 19, 11, 17, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 src2 = secondSource[26];
    ulong8 mask = (ulong8)(19, 5, 21, 14, 16, 12, 20, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 src2 = secondSource[27];
    ulong8 mask = (ulong8)(0, 26, 15, 12, 13, 7, 24, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 src2 = secondSource[28];
    ulong8 mask = (ulong8)(7, 28, 24, 19, 16, 2, 21, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 src2 = secondSource[29];
    ulong8 mask = (ulong8)(1, 22, 26, 18, 17, 22, 18, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 src2 = secondSource[30];
    ulong8 mask = (ulong8)(6, 21, 27, 14, 8, 28, 26, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 src2 = secondSource[31];
    ulong8 mask = (ulong8)(29, 28, 25, 0, 30, 31, 5, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
