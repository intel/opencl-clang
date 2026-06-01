// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *secondSource, __global long8 *source,
                          __global long4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 , src2;
  long4 tmp;
  tmp = (long4)((long)0);
  {
    long8 src1 = source[0];
    long8 src2 = secondSource[0];
    ulong4 mask = (ulong4)(12, 3, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[1];
    long8 src2 = secondSource[1];
    ulong4 mask = (ulong4)(3, 6, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[2];
    long8 src2 = secondSource[2];
    ulong4 mask = (ulong4)(5, 5, 6, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[3];
    long8 src2 = secondSource[3];
    ulong4 mask = (ulong4)(12, 5, 2, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[4];
    long8 src2 = secondSource[4];
    ulong4 mask = (ulong4)(8, 6, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[5];
    long8 src2 = secondSource[5];
    ulong4 mask = (ulong4)(3, 5, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[6];
    long8 src2 = secondSource[6];
    ulong4 mask = (ulong4)(2, 9, 15, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[7];
    long8 src2 = secondSource[7];
    ulong4 mask = (ulong4)(1, 4, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[8];
    long8 src2 = secondSource[8];
    ulong4 mask = (ulong4)(5, 15, 15, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[9];
    long8 src2 = secondSource[9];
    ulong4 mask = (ulong4)(9, 7, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[10];
    long8 src2 = secondSource[10];
    ulong4 mask = (ulong4)(14, 10, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[11];
    long8 src2 = secondSource[11];
    ulong4 mask = (ulong4)(10, 9, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[12];
    long8 src2 = secondSource[12];
    ulong4 mask = (ulong4)(0, 4, 0, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[13];
    long8 src2 = secondSource[13];
    ulong4 mask = (ulong4)(8, 0, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[14];
    long8 src2 = secondSource[14];
    ulong4 mask = (ulong4)(13, 7, 13, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[15];
    long8 src2 = secondSource[15];
    ulong4 mask = (ulong4)(10, 9, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[16];
    long8 src2 = secondSource[16];
    ulong4 mask = (ulong4)(9, 8, 11, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[17];
    long8 src2 = secondSource[17];
    ulong4 mask = (ulong4)(0, 4, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[18];
    long8 src2 = secondSource[18];
    ulong4 mask = (ulong4)(0, 7, 0, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[19];
    long8 src2 = secondSource[19];
    ulong4 mask = (ulong4)(3, 10, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[20];
    long8 src2 = secondSource[20];
    ulong4 mask = (ulong4)(0, 2, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[21];
    long8 src2 = secondSource[21];
    ulong4 mask = (ulong4)(12, 1, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[22];
    long8 src2 = secondSource[22];
    ulong4 mask = (ulong4)(13, 11, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[23];
    long8 src2 = secondSource[23];
    ulong4 mask = (ulong4)(8, 8, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[24];
    long8 src2 = secondSource[24];
    ulong4 mask = (ulong4)(14, 5, 4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[25];
    long8 src2 = secondSource[25];
    ulong4 mask = (ulong4)(4, 1, 15, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[26];
    long8 src2 = secondSource[26];
    ulong4 mask = (ulong4)(2, 9, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[27];
    long8 src2 = secondSource[27];
    ulong4 mask = (ulong4)(11, 15, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[28];
    long8 src2 = secondSource[28];
    ulong4 mask = (ulong4)(8, 8, 4, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[29];
    long8 src2 = secondSource[29];
    ulong4 mask = (ulong4)(5, 10, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[30];
    long8 src2 = secondSource[30];
    ulong4 mask = (ulong4)(14, 11, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long4)((long)0);
  {
    long8 src1 = source[31];
    long8 src2 = secondSource[31];
    ulong4 mask = (ulong4)(14, 12, 12, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
