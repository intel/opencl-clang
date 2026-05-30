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
    ulong16 mask =
        (ulong16)(14, 12, 7, 9, 12, 10, 14, 8, 7, 9, 14, 5, 14, 8, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[1];
    long8 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(14, 2, 4, 11, 0, 10, 14, 3, 6, 11, 10, 15, 5, 15, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[2];
    long8 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(12, 3, 13, 8, 7, 14, 10, 5, 13, 13, 13, 1, 8, 13, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[3];
    long8 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(10, 12, 6, 11, 12, 9, 6, 6, 1, 6, 14, 11, 15, 14, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[4];
    long8 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(10, 15, 10, 11, 1, 7, 12, 10, 9, 1, 11, 6, 2, 6, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[5];
    long8 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(14, 9, 13, 12, 8, 1, 9, 12, 8, 8, 13, 10, 9, 14, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[6];
    long8 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(0, 10, 3, 1, 7, 1, 14, 0, 14, 7, 9, 13, 8, 6, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[7];
    long8 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(8, 0, 2, 11, 9, 7, 6, 9, 5, 10, 10, 6, 0, 12, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[8];
    long8 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(3, 4, 4, 4, 12, 14, 1, 5, 0, 12, 9, 4, 5, 15, 10, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[9];
    long8 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(5, 14, 1, 13, 12, 4, 7, 6, 3, 10, 10, 11, 10, 2, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[10];
    long8 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(15, 10, 8, 4, 11, 8, 7, 7, 15, 6, 10, 7, 6, 13, 0, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[11];
    long8 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(9, 14, 0, 2, 3, 3, 7, 15, 13, 12, 5, 5, 8, 11, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[12];
    long8 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(9, 9, 6, 4, 5, 9, 6, 12, 11, 5, 7, 0, 12, 7, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[13];
    long8 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(15, 6, 2, 8, 3, 14, 5, 4, 3, 9, 6, 12, 8, 6, 13, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[14];
    long8 src2 = secondSource[14];
    ulong16 mask = (ulong16)(7, 7, 2, 12, 7, 5, 4, 2, 1, 8, 3, 7, 1, 12, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[15];
    long8 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(13, 7, 12, 3, 13, 13, 8, 8, 7, 8, 11, 9, 0, 8, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[16];
    long8 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(11, 4, 0, 9, 5, 10, 14, 7, 10, 10, 6, 3, 14, 13, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[17];
    long8 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(8, 15, 5, 9, 2, 14, 1, 9, 6, 6, 3, 13, 1, 2, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[18];
    long8 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(11, 3, 10, 4, 10, 0, 2, 6, 5, 12, 4, 3, 13, 5, 8, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[19];
    long8 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(3, 15, 1, 7, 14, 1, 5, 2, 4, 2, 15, 11, 15, 15, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[20];
    long8 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(1, 11, 3, 6, 4, 0, 2, 1, 15, 2, 13, 0, 11, 2, 10, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[21];
    long8 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(4, 6, 10, 0, 7, 0, 13, 5, 2, 5, 15, 4, 4, 3, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[22];
    long8 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(15, 4, 9, 0, 5, 9, 8, 14, 13, 12, 2, 7, 5, 1, 2, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[23];
    long8 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(5, 14, 4, 5, 2, 6, 11, 14, 13, 15, 2, 4, 7, 7, 14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[24];
    long8 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(11, 3, 0, 8, 5, 10, 4, 4, 6, 11, 8, 4, 7, 15, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[25];
    long8 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(10, 5, 6, 2, 13, 4, 5, 13, 11, 9, 7, 5, 1, 12, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[26];
    long8 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(5, 3, 7, 4, 13, 11, 3, 4, 5, 3, 11, 7, 1, 11, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[27];
    long8 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(11, 14, 9, 9, 0, 13, 14, 10, 10, 14, 9, 5, 6, 11, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[28];
    long8 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(9, 0, 11, 13, 8, 10, 2, 12, 8, 10, 11, 4, 5, 7, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[29];
    long8 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(8, 1, 0, 12, 8, 7, 12, 7, 11, 14, 1, 2, 13, 14, 14, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[30];
    long8 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(5, 14, 5, 0, 2, 11, 7, 11, 7, 10, 1, 1, 6, 5, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[31];
    long8 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(8, 12, 14, 13, 2, 7, 14, 11, 0, 4, 4, 2, 4, 14, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
