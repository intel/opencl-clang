// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long4 *secondSource, __global long4 *source,
                          __global long8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long4 src1 , src2;
  long8 tmp;
  tmp = (long8)((long)0);
  {
    long4 src1 = source[0];
    long4 src2 = secondSource[0];
    ulong8 mask = (ulong8)(6, 7, 3, 0, 1, 2, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[1];
    long4 src2 = secondSource[1];
    ulong8 mask = (ulong8)(5, 4, 0, 6, 2, 6, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[2];
    long4 src2 = secondSource[2];
    ulong8 mask = (ulong8)(4, 4, 2, 4, 6, 7, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[3];
    long4 src2 = secondSource[3];
    ulong8 mask = (ulong8)(4, 6, 3, 6, 7, 2, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[4];
    long4 src2 = secondSource[4];
    ulong8 mask = (ulong8)(5, 2, 6, 0, 5, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[5];
    long4 src2 = secondSource[5];
    ulong8 mask = (ulong8)(0, 2, 7, 5, 4, 6, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[6];
    long4 src2 = secondSource[6];
    ulong8 mask = (ulong8)(7, 0, 1, 3, 3, 3, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[7];
    long4 src2 = secondSource[7];
    ulong8 mask = (ulong8)(3, 4, 3, 6, 3, 0, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[8];
    long4 src2 = secondSource[8];
    ulong8 mask = (ulong8)(6, 7, 3, 4, 2, 4, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[9];
    long4 src2 = secondSource[9];
    ulong8 mask = (ulong8)(0, 7, 7, 5, 1, 1, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[10];
    long4 src2 = secondSource[10];
    ulong8 mask = (ulong8)(5, 6, 4, 7, 1, 7, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[11];
    long4 src2 = secondSource[11];
    ulong8 mask = (ulong8)(6, 0, 0, 6, 4, 4, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[12];
    long4 src2 = secondSource[12];
    ulong8 mask = (ulong8)(1, 3, 4, 5, 7, 5, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[13];
    long4 src2 = secondSource[13];
    ulong8 mask = (ulong8)(7, 2, 7, 4, 6, 4, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[14];
    long4 src2 = secondSource[14];
    ulong8 mask = (ulong8)(7, 5, 0, 2, 1, 5, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[15];
    long4 src2 = secondSource[15];
    ulong8 mask = (ulong8)(1, 2, 4, 1, 1, 7, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[16];
    long4 src2 = secondSource[16];
    ulong8 mask = (ulong8)(7, 2, 4, 7, 7, 5, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[17];
    long4 src2 = secondSource[17];
    ulong8 mask = (ulong8)(3, 4, 3, 4, 3, 5, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[18];
    long4 src2 = secondSource[18];
    ulong8 mask = (ulong8)(3, 6, 6, 2, 0, 5, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[19];
    long4 src2 = secondSource[19];
    ulong8 mask = (ulong8)(0, 5, 0, 7, 6, 3, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[20];
    long4 src2 = secondSource[20];
    ulong8 mask = (ulong8)(2, 0, 1, 7, 2, 5, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[21];
    long4 src2 = secondSource[21];
    ulong8 mask = (ulong8)(5, 0, 3, 1, 1, 2, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[22];
    long4 src2 = secondSource[22];
    ulong8 mask = (ulong8)(7, 5, 5, 3, 0, 0, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[23];
    long4 src2 = secondSource[23];
    ulong8 mask = (ulong8)(1, 1, 1, 1, 4, 6, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[24];
    long4 src2 = secondSource[24];
    ulong8 mask = (ulong8)(6, 5, 7, 4, 4, 7, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[25];
    long4 src2 = secondSource[25];
    ulong8 mask = (ulong8)(2, 4, 4, 1, 2, 2, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[26];
    long4 src2 = secondSource[26];
    ulong8 mask = (ulong8)(2, 7, 4, 7, 2, 4, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[27];
    long4 src2 = secondSource[27];
    ulong8 mask = (ulong8)(1, 0, 7, 0, 7, 0, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[28];
    long4 src2 = secondSource[28];
    ulong8 mask = (ulong8)(5, 0, 6, 5, 7, 4, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[29];
    long4 src2 = secondSource[29];
    ulong8 mask = (ulong8)(4, 5, 2, 3, 1, 5, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[30];
    long4 src2 = secondSource[30];
    ulong8 mask = (ulong8)(4, 4, 4, 5, 7, 6, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long4 src1 = source[31];
    long4 src2 = secondSource[31];
    ulong8 mask = (ulong8)(2, 7, 5, 5, 3, 1, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
