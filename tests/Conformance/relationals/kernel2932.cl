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
    ulong8 mask = (ulong8)(18, 26, 8, 2, 1, 13, 28, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[1];
    long16 src2 = secondSource[1];
    ulong8 mask = (ulong8)(11, 21, 25, 31, 26, 9, 21, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[2];
    long16 src2 = secondSource[2];
    ulong8 mask = (ulong8)(20, 16, 5, 25, 12, 25, 16, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[3];
    long16 src2 = secondSource[3];
    ulong8 mask = (ulong8)(28, 8, 16, 26, 15, 30, 12, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[4];
    long16 src2 = secondSource[4];
    ulong8 mask = (ulong8)(27, 20, 29, 23, 3, 7, 12, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[5];
    long16 src2 = secondSource[5];
    ulong8 mask = (ulong8)(30, 14, 13, 18, 7, 28, 25, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[6];
    long16 src2 = secondSource[6];
    ulong8 mask = (ulong8)(13, 25, 24, 4, 19, 24, 10, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[7];
    long16 src2 = secondSource[7];
    ulong8 mask = (ulong8)(6, 28, 4, 12, 3, 7, 19, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[8];
    long16 src2 = secondSource[8];
    ulong8 mask = (ulong8)(9, 9, 23, 13, 4, 1, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[9];
    long16 src2 = secondSource[9];
    ulong8 mask = (ulong8)(10, 6, 27, 22, 17, 4, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[10];
    long16 src2 = secondSource[10];
    ulong8 mask = (ulong8)(4, 19, 0, 3, 15, 27, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[11];
    long16 src2 = secondSource[11];
    ulong8 mask = (ulong8)(6, 19, 17, 1, 1, 1, 7, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[12];
    long16 src2 = secondSource[12];
    ulong8 mask = (ulong8)(0, 7, 17, 3, 4, 13, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[13];
    long16 src2 = secondSource[13];
    ulong8 mask = (ulong8)(11, 15, 22, 22, 27, 0, 24, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[14];
    long16 src2 = secondSource[14];
    ulong8 mask = (ulong8)(5, 2, 23, 2, 10, 26, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[15];
    long16 src2 = secondSource[15];
    ulong8 mask = (ulong8)(20, 6, 9, 0, 0, 7, 26, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[16];
    long16 src2 = secondSource[16];
    ulong8 mask = (ulong8)(6, 8, 7, 3, 13, 20, 22, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[17];
    long16 src2 = secondSource[17];
    ulong8 mask = (ulong8)(11, 19, 31, 12, 19, 28, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[18];
    long16 src2 = secondSource[18];
    ulong8 mask = (ulong8)(13, 16, 19, 14, 31, 16, 23, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[19];
    long16 src2 = secondSource[19];
    ulong8 mask = (ulong8)(23, 20, 16, 13, 29, 16, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[20];
    long16 src2 = secondSource[20];
    ulong8 mask = (ulong8)(17, 18, 6, 9, 2, 20, 29, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[21];
    long16 src2 = secondSource[21];
    ulong8 mask = (ulong8)(29, 31, 14, 12, 15, 14, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[22];
    long16 src2 = secondSource[22];
    ulong8 mask = (ulong8)(10, 12, 16, 5, 0, 18, 16, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[23];
    long16 src2 = secondSource[23];
    ulong8 mask = (ulong8)(17, 19, 23, 28, 6, 5, 24, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[24];
    long16 src2 = secondSource[24];
    ulong8 mask = (ulong8)(31, 29, 3, 6, 27, 10, 7, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[25];
    long16 src2 = secondSource[25];
    ulong8 mask = (ulong8)(9, 20, 14, 20, 6, 18, 26, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[26];
    long16 src2 = secondSource[26];
    ulong8 mask = (ulong8)(21, 13, 12, 11, 18, 21, 19, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[27];
    long16 src2 = secondSource[27];
    ulong8 mask = (ulong8)(23, 2, 28, 1, 25, 26, 24, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[28];
    long16 src2 = secondSource[28];
    ulong8 mask = (ulong8)(29, 24, 10, 31, 21, 30, 18, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[29];
    long16 src2 = secondSource[29];
    ulong8 mask = (ulong8)(9, 20, 5, 11, 18, 7, 15, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[30];
    long16 src2 = secondSource[30];
    ulong8 mask = (ulong8)(29, 3, 16, 28, 17, 21, 21, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long8)((long)0);
  {
    long16 src1 = source[31];
    long16 src2 = secondSource[31];
    ulong8 mask = (ulong8)(12, 10, 12, 1, 15, 24, 27, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
