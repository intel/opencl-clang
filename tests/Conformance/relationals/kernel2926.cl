// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *secondSource, __global long8 *source,
                          __global long16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 , src2;
  long16 tmp;
  tmp = (long16)((long)0);
  {
    long8 src1 = source[0];
    long8 src2 = secondSource[0];
    ulong16 mask = (ulong16)(7, 3, 5, 6, 6, 2, 1, 15, 8, 3, 9, 8, 0, 13, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[1];
    long8 src2 = secondSource[1];
    ulong16 mask = (ulong16)(6, 5, 6, 9, 2, 5, 10, 1, 3, 1, 7, 3, 5, 1, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[2];
    long8 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(5, 7, 3, 9, 12, 2, 7, 11, 13, 0, 13, 14, 8, 7, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[3];
    long8 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(13, 0, 5, 0, 3, 7, 15, 8, 9, 15, 10, 10, 10, 4, 4, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[4];
    long8 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(7, 0, 14, 11, 7, 9, 14, 8, 4, 6, 4, 8, 2, 10, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[5];
    long8 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(9, 3, 13, 12, 5, 1, 14, 3, 7, 11, 2, 0, 0, 11, 9, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[6];
    long8 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(2, 9, 8, 8, 0, 12, 14, 7, 4, 4, 11, 8, 9, 9, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[7];
    long8 src2 = secondSource[7];
    ulong16 mask = (ulong16)(0, 8, 1, 3, 13, 7, 4, 15, 1, 14, 2, 8, 6, 2, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[8];
    long8 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(11, 12, 10, 2, 14, 14, 2, 1, 2, 5, 6, 4, 2, 15, 12, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[9];
    long8 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(3, 5, 1, 0, 2, 4, 4, 11, 15, 4, 4, 3, 8, 13, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[10];
    long8 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(5, 0, 9, 0, 0, 7, 4, 14, 8, 2, 6, 13, 14, 10, 4, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[11];
    long8 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(5, 8, 8, 8, 8, 13, 8, 9, 8, 8, 15, 1, 9, 13, 12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[12];
    long8 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(13, 12, 15, 10, 14, 13, 6, 8, 13, 12, 12, 12, 4, 4, 7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[13];
    long8 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(13, 2, 2, 0, 14, 2, 3, 8, 8, 15, 5, 7, 4, 0, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[14];
    long8 src2 = secondSource[14];
    ulong16 mask = (ulong16)(12, 8, 1, 2, 6, 13, 8, 5, 9, 3, 6, 12, 6, 1, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[15];
    long8 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(4, 1, 4, 5, 6, 0, 11, 8, 7, 1, 13, 11, 4, 3, 11, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[16];
    long8 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(5, 11, 14, 14, 4, 15, 0, 15, 15, 9, 14, 7, 6, 11, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[17];
    long8 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(13, 0, 3, 14, 2, 14, 0, 12, 3, 6, 3, 1, 0, 7, 7, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[18];
    long8 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(13, 1, 10, 12, 1, 1, 13, 14, 15, 7, 11, 5, 0, 9, 10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[19];
    long8 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(9, 3, 13, 0, 7, 11, 11, 7, 4, 4, 5, 0, 3, 12, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[20];
    long8 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(2, 0, 11, 13, 14, 12, 11, 7, 12, 5, 4, 3, 9, 11, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[21];
    long8 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(12, 1, 15, 1, 10, 12, 6, 15, 3, 5, 11, 9, 2, 2, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[22];
    long8 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(9, 10, 7, 11, 9, 7, 8, 14, 9, 9, 8, 12, 9, 14, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[23];
    long8 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(10, 7, 15, 7, 4, 5, 0, 4, 0, 13, 15, 11, 6, 13, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[24];
    long8 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(7, 13, 15, 3, 10, 6, 13, 4, 8, 13, 6, 11, 11, 7, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[25];
    long8 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(2, 3, 14, 6, 6, 1, 1, 5, 3, 10, 0, 7, 6, 15, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[26];
    long8 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(13, 1, 11, 4, 5, 9, 6, 10, 12, 11, 11, 0, 11, 14, 14, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[27];
    long8 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(4, 4, 5, 13, 2, 8, 6, 4, 10, 4, 1, 2, 12, 9, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[28];
    long8 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(3, 11, 9, 3, 13, 0, 0, 4, 2, 12, 3, 15, 10, 1, 9, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[29];
    long8 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(6, 12, 6, 13, 11, 5, 9, 15, 7, 14, 0, 3, 14, 11, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[30];
    long8 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(0, 10, 11, 12, 13, 7, 6, 9, 9, 14, 4, 8, 15, 14, 10, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[31];
    long8 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(3, 3, 5, 8, 0, 15, 6, 15, 15, 7, 3, 9, 8, 14, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
