// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *secondSource, __global long8 *source,
                          __global long8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 , src2;
  long8 tmp;
  tmp = (long8)((long)0);
  {
    long8 src1 = source[0];
    long8 src2 = secondSource[0];
    ulong8 mask = (ulong8)(1, 6, 11, 5, 1, 10, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[1];
    long8 src2 = secondSource[1];
    ulong8 mask = (ulong8)(14, 6, 4, 15, 4, 13, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[2];
    long8 src2 = secondSource[2];
    ulong8 mask = (ulong8)(15, 3, 5, 12, 4, 15, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[3];
    long8 src2 = secondSource[3];
    ulong8 mask = (ulong8)(3, 4, 13, 2, 4, 11, 2, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[4];
    long8 src2 = secondSource[4];
    ulong8 mask = (ulong8)(0, 13, 6, 4, 10, 2, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[5];
    long8 src2 = secondSource[5];
    ulong8 mask = (ulong8)(6, 2, 10, 10, 13, 2, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[6];
    long8 src2 = secondSource[6];
    ulong8 mask = (ulong8)(0, 10, 11, 0, 3, 13, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[7];
    long8 src2 = secondSource[7];
    ulong8 mask = (ulong8)(0, 6, 8, 11, 9, 7, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[8];
    long8 src2 = secondSource[8];
    ulong8 mask = (ulong8)(8, 3, 12, 8, 10, 10, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[9];
    long8 src2 = secondSource[9];
    ulong8 mask = (ulong8)(0, 8, 2, 9, 15, 11, 6, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[10];
    long8 src2 = secondSource[10];
    ulong8 mask = (ulong8)(4, 10, 7, 1, 4, 8, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[11];
    long8 src2 = secondSource[11];
    ulong8 mask = (ulong8)(14, 5, 13, 14, 10, 10, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[12];
    long8 src2 = secondSource[12];
    ulong8 mask = (ulong8)(7, 5, 3, 3, 2, 10, 12, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[13];
    long8 src2 = secondSource[13];
    ulong8 mask = (ulong8)(0, 2, 13, 10, 11, 6, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[14];
    long8 src2 = secondSource[14];
    ulong8 mask = (ulong8)(9, 10, 7, 13, 12, 9, 12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[15];
    long8 src2 = secondSource[15];
    ulong8 mask = (ulong8)(8, 12, 5, 8, 6, 0, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[16];
    long8 src2 = secondSource[16];
    ulong8 mask = (ulong8)(1, 9, 14, 6, 4, 3, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[17];
    long8 src2 = secondSource[17];
    ulong8 mask = (ulong8)(4, 8, 9, 3, 6, 8, 4, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[18];
    long8 src2 = secondSource[18];
    ulong8 mask = (ulong8)(11, 5, 10, 9, 10, 1, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[19];
    long8 src2 = secondSource[19];
    ulong8 mask = (ulong8)(9, 4, 1, 2, 2, 1, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[20];
    long8 src2 = secondSource[20];
    ulong8 mask = (ulong8)(1, 12, 10, 7, 7, 8, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[21];
    long8 src2 = secondSource[21];
    ulong8 mask = (ulong8)(7, 13, 5, 14, 15, 11, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[22];
    long8 src2 = secondSource[22];
    ulong8 mask = (ulong8)(4, 6, 1, 13, 3, 6, 1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[23];
    long8 src2 = secondSource[23];
    ulong8 mask = (ulong8)(11, 7, 13, 8, 10, 12, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[24];
    long8 src2 = secondSource[24];
    ulong8 mask = (ulong8)(5, 2, 5, 6, 13, 7, 12, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[25];
    long8 src2 = secondSource[25];
    ulong8 mask = (ulong8)(14, 13, 2, 1, 5, 11, 13, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[26];
    long8 src2 = secondSource[26];
    ulong8 mask = (ulong8)(6, 9, 10, 1, 8, 7, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[27];
    long8 src2 = secondSource[27];
    ulong8 mask = (ulong8)(12, 2, 7, 3, 13, 4, 11, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[28];
    long8 src2 = secondSource[28];
    ulong8 mask = (ulong8)(3, 14, 13, 10, 5, 11, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[29];
    long8 src2 = secondSource[29];
    ulong8 mask = (ulong8)(5, 15, 12, 13, 11, 9, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[30];
    long8 src2 = secondSource[30];
    ulong8 mask = (ulong8)(10, 12, 3, 10, 0, 0, 0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long8 src1 = source[31];
    long8 src2 = secondSource[31];
    ulong8 mask = (ulong8)(12, 6, 15, 9, 10, 1, 4, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
