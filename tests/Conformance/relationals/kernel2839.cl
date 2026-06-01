// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *secondSource,
                          __global ushort16 *source, __global ushort16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 , src2;
  ushort16 tmp;
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort16 src2 = secondSource[0];
    ushort16 mask =
        (ushort16)(6, 27, 18, 19, 15, 11, 21, 19, 9, 8, 1, 10, 12, 5, 7, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(11, 17, 30, 26, 30, 22, 9, 5, 9, 21, 5, 11, 29, 17, 7, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(13, 4, 22, 25, 23, 17, 31, 29, 4, 0, 12, 14, 18, 3, 25, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(11, 31, 28, 0, 30, 12, 31, 8, 4, 8, 5, 14, 10, 17, 13, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(31, 17, 24, 1, 20, 0, 23, 27, 11, 4, 20, 5, 1, 4, 8, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 src2 = secondSource[5];
    ushort16 mask = (ushort16)(31, 20, 17, 12, 24, 14, 19, 9, 24, 21, 15, 17,
                               31, 19, 29, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(27, 8, 2, 25, 0, 6, 11, 1, 17, 0, 10, 19, 21, 31, 6, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 src2 = secondSource[7];
    ushort16 mask = (ushort16)(13, 3, 23, 19, 11, 24, 31, 10, 16, 30, 25, 19,
                               18, 26, 21, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(20, 10, 1, 24, 24, 12, 7, 1, 9, 22, 4, 18, 15, 11, 14, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(9, 22, 31, 2, 29, 4, 3, 16, 23, 5, 10, 17, 21, 24, 27, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(23, 20, 0, 11, 28, 29, 19, 26, 27, 2, 30, 7, 24, 16, 16, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(4, 19, 25, 18, 16, 6, 29, 24, 29, 12, 2, 1, 21, 8, 20, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(16, 30, 7, 19, 9, 13, 19, 15, 29, 16, 30, 28, 22, 1, 0, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(5, 17, 0, 1, 3, 31, 11, 17, 7, 3, 22, 10, 2, 30, 27, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(4, 18, 14, 18, 31, 14, 1, 21, 29, 30, 29, 20, 19, 2, 25, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 src2 = secondSource[15];
    ushort16 mask = (ushort16)(7, 13, 14, 20, 30, 19, 17, 30, 31, 16, 18, 21, 9,
                               15, 16, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(10, 6, 9, 28, 20, 1, 29, 16, 7, 27, 11, 13, 5, 30, 3, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 src2 = secondSource[17];
    ushort16 mask = (ushort16)(12, 19, 29, 19, 15, 23, 14, 2, 30, 23, 30, 6, 16,
                               13, 22, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(20, 12, 11, 28, 27, 24, 16, 20, 20, 8, 13, 12, 1, 0, 10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 src2 = secondSource[19];
    ushort16 mask =
        (ushort16)(9, 15, 4, 17, 4, 3, 28, 14, 21, 23, 14, 5, 26, 7, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(9, 27, 27, 20, 15, 5, 3, 11, 0, 11, 23, 30, 21, 30, 25, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(0, 27, 9, 8, 21, 1, 21, 1, 15, 30, 2, 5, 13, 22, 17, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 src2 = secondSource[22];
    ushort16 mask = (ushort16)(31, 31, 13, 18, 20, 19, 27, 31, 14, 4, 4, 22, 25,
                               10, 30, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(21, 25, 19, 10, 28, 17, 29, 2, 8, 26, 26, 26, 6, 25, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(12, 15, 7, 7, 25, 11, 18, 3, 30, 5, 11, 9, 24, 26, 28, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 src2 = secondSource[25];
    ushort16 mask =
        (ushort16)(20, 10, 21, 1, 13, 19, 15, 16, 18, 22, 6, 23, 1, 22, 2, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(30, 30, 19, 10, 0, 23, 3, 28, 25, 18, 10, 11, 23, 2, 23, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(23, 13, 0, 3, 8, 16, 9, 15, 3, 12, 14, 27, 29, 31, 2, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(6, 6, 14, 19, 12, 3, 21, 1, 6, 27, 12, 11, 26, 2, 19, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(14, 23, 18, 5, 17, 22, 17, 7, 0, 9, 31, 17, 1, 15, 10, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(30, 13, 17, 7, 14, 25, 22, 19, 2, 10, 26, 1, 18, 18, 29, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(31, 1, 29, 11, 31, 2, 11, 10, 18, 24, 29, 12, 6, 19, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
