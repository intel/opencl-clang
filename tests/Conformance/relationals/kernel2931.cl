// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *secondSource,
                          __global long16 *source, __global long4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 , src2;
  long4 tmp;
  tmp = (long4)((long)0);
  {
    long16 src1 = source[0];
    long16 src2 = secondSource[0];
    ulong4 mask = (ulong4)(20, 23, 30, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[1];
    long16 src2 = secondSource[1];
    ulong4 mask = (ulong4)(31, 10, 30, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[2];
    long16 src2 = secondSource[2];
    ulong4 mask = (ulong4)(27, 22, 16, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[3];
    long16 src2 = secondSource[3];
    ulong4 mask = (ulong4)(25, 3, 3, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[4];
    long16 src2 = secondSource[4];
    ulong4 mask = (ulong4)(4, 10, 14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[5];
    long16 src2 = secondSource[5];
    ulong4 mask = (ulong4)(31, 24, 4, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[6];
    long16 src2 = secondSource[6];
    ulong4 mask = (ulong4)(29, 27, 23, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[7];
    long16 src2 = secondSource[7];
    ulong4 mask = (ulong4)(3, 23, 25, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[8];
    long16 src2 = secondSource[8];
    ulong4 mask = (ulong4)(22, 16, 24, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[9];
    long16 src2 = secondSource[9];
    ulong4 mask = (ulong4)(13, 20, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[10];
    long16 src2 = secondSource[10];
    ulong4 mask = (ulong4)(13, 23, 19, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[11];
    long16 src2 = secondSource[11];
    ulong4 mask = (ulong4)(3, 4, 6, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[12];
    long16 src2 = secondSource[12];
    ulong4 mask = (ulong4)(5, 24, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[13];
    long16 src2 = secondSource[13];
    ulong4 mask = (ulong4)(29, 28, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[14];
    long16 src2 = secondSource[14];
    ulong4 mask = (ulong4)(29, 0, 30, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[15];
    long16 src2 = secondSource[15];
    ulong4 mask = (ulong4)(20, 9, 31, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[16];
    long16 src2 = secondSource[16];
    ulong4 mask = (ulong4)(21, 25, 8, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[17];
    long16 src2 = secondSource[17];
    ulong4 mask = (ulong4)(5, 6, 28, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[18];
    long16 src2 = secondSource[18];
    ulong4 mask = (ulong4)(11, 27, 23, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[19];
    long16 src2 = secondSource[19];
    ulong4 mask = (ulong4)(8, 12, 19, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[20];
    long16 src2 = secondSource[20];
    ulong4 mask = (ulong4)(4, 8, 13, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[21];
    long16 src2 = secondSource[21];
    ulong4 mask = (ulong4)(31, 11, 30, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[22];
    long16 src2 = secondSource[22];
    ulong4 mask = (ulong4)(8, 18, 6, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[23];
    long16 src2 = secondSource[23];
    ulong4 mask = (ulong4)(22, 19, 14, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[24];
    long16 src2 = secondSource[24];
    ulong4 mask = (ulong4)(4, 31, 12, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[25];
    long16 src2 = secondSource[25];
    ulong4 mask = (ulong4)(0, 19, 4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[26];
    long16 src2 = secondSource[26];
    ulong4 mask = (ulong4)(24, 6, 15, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[27];
    long16 src2 = secondSource[27];
    ulong4 mask = (ulong4)(24, 18, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[28];
    long16 src2 = secondSource[28];
    ulong4 mask = (ulong4)(0, 23, 24, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[29];
    long16 src2 = secondSource[29];
    ulong4 mask = (ulong4)(13, 10, 31, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[30];
    long16 src2 = secondSource[30];
    ulong4 mask = (ulong4)(10, 21, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long16 src1 = source[31];
    long16 src2 = secondSource[31];
    ulong4 mask = (ulong4)(25, 2, 6, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
