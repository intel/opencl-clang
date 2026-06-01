// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *secondSource,
                          __global long16 *source, __global long8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 , src2;
  long8 tmp;
  tmp = (long8)((long)0);
  {
    long16 src1 = source[0];
    long16 src2 = secondSource[0];
    ulong8 mask = (ulong8)(31, 24, 1, 31, 11, 6, 17, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[1];
    long16 src2 = secondSource[1];
    ulong8 mask = (ulong8)(7, 12, 28, 10, 23, 16, 18, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[2];
    long16 src2 = secondSource[2];
    ulong8 mask = (ulong8)(12, 17, 15, 27, 13, 0, 22, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[3];
    long16 src2 = secondSource[3];
    ulong8 mask = (ulong8)(0, 30, 12, 17, 18, 12, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[4];
    long16 src2 = secondSource[4];
    ulong8 mask = (ulong8)(27, 15, 20, 25, 14, 1, 30, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[5];
    long16 src2 = secondSource[5];
    ulong8 mask = (ulong8)(27, 5, 19, 28, 20, 7, 0, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[6];
    long16 src2 = secondSource[6];
    ulong8 mask = (ulong8)(31, 30, 15, 13, 22, 0, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[7];
    long16 src2 = secondSource[7];
    ulong8 mask = (ulong8)(0, 3, 25, 16, 19, 25, 20, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[8];
    long16 src2 = secondSource[8];
    ulong8 mask = (ulong8)(23, 28, 18, 27, 29, 17, 3, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[9];
    long16 src2 = secondSource[9];
    ulong8 mask = (ulong8)(2, 27, 16, 3, 0, 31, 14, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[10];
    long16 src2 = secondSource[10];
    ulong8 mask = (ulong8)(16, 23, 26, 22, 18, 13, 31, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[11];
    long16 src2 = secondSource[11];
    ulong8 mask = (ulong8)(1, 14, 13, 3, 6, 1, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[12];
    long16 src2 = secondSource[12];
    ulong8 mask = (ulong8)(4, 7, 17, 22, 30, 7, 5, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[13];
    long16 src2 = secondSource[13];
    ulong8 mask = (ulong8)(24, 7, 8, 21, 23, 31, 4, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[14];
    long16 src2 = secondSource[14];
    ulong8 mask = (ulong8)(3, 7, 1, 2, 9, 1, 3, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[15];
    long16 src2 = secondSource[15];
    ulong8 mask = (ulong8)(11, 20, 6, 28, 25, 17, 21, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[16];
    long16 src2 = secondSource[16];
    ulong8 mask = (ulong8)(21, 14, 0, 2, 16, 6, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[17];
    long16 src2 = secondSource[17];
    ulong8 mask = (ulong8)(23, 8, 0, 3, 15, 21, 15, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[18];
    long16 src2 = secondSource[18];
    ulong8 mask = (ulong8)(12, 4, 18, 17, 17, 7, 6, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[19];
    long16 src2 = secondSource[19];
    ulong8 mask = (ulong8)(3, 15, 2, 0, 11, 8, 24, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[20];
    long16 src2 = secondSource[20];
    ulong8 mask = (ulong8)(15, 6, 17, 31, 23, 30, 16, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[21];
    long16 src2 = secondSource[21];
    ulong8 mask = (ulong8)(2, 3, 24, 19, 11, 8, 21, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[22];
    long16 src2 = secondSource[22];
    ulong8 mask = (ulong8)(17, 4, 19, 7, 13, 27, 13, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[23];
    long16 src2 = secondSource[23];
    ulong8 mask = (ulong8)(28, 27, 4, 5, 11, 1, 24, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[24];
    long16 src2 = secondSource[24];
    ulong8 mask = (ulong8)(26, 13, 20, 30, 10, 27, 29, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[25];
    long16 src2 = secondSource[25];
    ulong8 mask = (ulong8)(24, 9, 22, 6, 18, 10, 15, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[26];
    long16 src2 = secondSource[26];
    ulong8 mask = (ulong8)(25, 29, 15, 0, 18, 14, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[27];
    long16 src2 = secondSource[27];
    ulong8 mask = (ulong8)(10, 26, 16, 27, 5, 23, 26, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[28];
    long16 src2 = secondSource[28];
    ulong8 mask = (ulong8)(28, 3, 9, 11, 18, 8, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[29];
    long16 src2 = secondSource[29];
    ulong8 mask = (ulong8)(24, 24, 31, 19, 31, 28, 30, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[30];
    long16 src2 = secondSource[30];
    ulong8 mask = (ulong8)(25, 5, 17, 25, 15, 6, 15, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[31];
    long16 src2 = secondSource[31];
    ulong8 mask = (ulong8)(0, 29, 22, 19, 22, 26, 1, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
