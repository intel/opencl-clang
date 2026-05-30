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
        (ushort16)(3, 13, 4, 26, 9, 13, 20, 6, 9, 7, 20, 8, 1, 28, 7, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 src2 = secondSource[1];
    ushort16 mask = (ushort16)(14, 14, 15, 10, 14, 5, 17, 0, 13, 17, 28, 30, 25,
                               30, 13, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 src2 = secondSource[2];
    ushort16 mask = (ushort16)(26, 25, 25, 30, 17, 1, 18, 30, 15, 26, 17, 24,
                               16, 24, 8, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(10, 16, 31, 26, 31, 5, 2, 26, 26, 6, 27, 25, 21, 6, 29, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(30, 17, 11, 9, 29, 26, 12, 4, 13, 11, 17, 31, 28, 3, 10, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(21, 8, 12, 0, 21, 3, 26, 28, 10, 17, 7, 30, 28, 27, 12, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(22, 31, 19, 0, 25, 31, 1, 25, 3, 0, 14, 30, 5, 27, 16, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(10, 18, 23, 8, 25, 23, 22, 20, 7, 1, 9, 12, 1, 22, 26, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(16, 3, 9, 4, 21, 2, 30, 28, 2, 16, 23, 26, 13, 28, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(13, 28, 6, 6, 6, 27, 10, 15, 28, 18, 1, 16, 9, 8, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(19, 13, 6, 16, 0, 29, 4, 18, 11, 19, 25, 8, 27, 0, 20, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(13, 10, 20, 5, 6, 5, 25, 28, 14, 1, 30, 25, 8, 5, 20, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(27, 24, 7, 20, 0, 25, 13, 6, 16, 3, 6, 29, 25, 14, 23, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 src2 = secondSource[13];
    ushort16 mask = (ushort16)(18, 18, 31, 0, 18, 29, 13, 23, 4, 30, 30, 14, 14,
                               31, 10, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(24, 31, 25, 19, 2, 21, 2, 20, 2, 12, 1, 6, 17, 6, 5, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(21, 7, 27, 7, 16, 29, 26, 28, 11, 14, 25, 5, 26, 12, 7, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(31, 19, 23, 30, 1, 20, 5, 10, 26, 27, 19, 29, 14, 25, 17, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(9, 16, 18, 25, 0, 11, 30, 11, 31, 1, 7, 13, 11, 25, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(7, 16, 3, 8, 22, 4, 10, 13, 6, 7, 17, 13, 11, 23, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 src2 = secondSource[19];
    ushort16 mask = (ushort16)(12, 3, 22, 15, 18, 11, 14, 5, 30, 24, 23, 23, 30,
                               31, 25, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(4, 30, 6, 31, 2, 4, 12, 5, 15, 1, 31, 8, 28, 20, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(12, 24, 16, 14, 18, 12, 7, 5, 9, 26, 19, 28, 10, 10, 23, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(9, 1, 6, 14, 17, 16, 3, 15, 29, 9, 7, 18, 14, 25, 22, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(19, 28, 9, 3, 29, 30, 14, 22, 21, 11, 4, 3, 8, 31, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(19, 27, 2, 28, 13, 11, 13, 15, 5, 6, 5, 8, 10, 18, 16, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 src2 = secondSource[25];
    ushort16 mask = (ushort16)(19, 7, 22, 19, 25, 13, 12, 11, 13, 10, 17, 7, 25,
                               26, 18, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(4, 9, 4, 6, 2, 15, 0, 9, 24, 3, 4, 31, 1, 24, 22, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(13, 17, 24, 10, 21, 7, 13, 17, 31, 4, 3, 2, 1, 17, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(30, 31, 0, 25, 1, 1, 28, 22, 28, 17, 26, 12, 21, 1, 29, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(20, 8, 10, 11, 29, 28, 4, 6, 25, 6, 0, 25, 11, 20, 31, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(3, 14, 20, 22, 28, 10, 7, 6, 6, 12, 25, 16, 5, 26, 27, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(20, 9, 27, 10, 31, 25, 21, 5, 28, 27, 22, 29, 1, 5, 1, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
