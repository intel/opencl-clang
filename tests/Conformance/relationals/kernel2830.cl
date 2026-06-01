// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort8 *secondSource,
                          __global ushort8 *source, __global ushort16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort8 src1 , src2;
  ushort16 tmp;
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[0];
    ushort8 src2 = secondSource[0];
    ushort16 mask =
        (ushort16)(0, 2, 14, 14, 8, 8, 6, 3, 15, 1, 11, 9, 4, 6, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[1];
    ushort8 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(8, 6, 6, 13, 0, 10, 13, 1, 8, 11, 1, 15, 3, 15, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[2];
    ushort8 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(5, 9, 3, 9, 0, 12, 0, 10, 9, 6, 8, 11, 11, 12, 9, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[3];
    ushort8 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(3, 15, 8, 0, 12, 12, 0, 5, 9, 5, 10, 9, 1, 14, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[4];
    ushort8 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(2, 5, 9, 10, 13, 11, 13, 11, 2, 2, 11, 13, 10, 6, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[5];
    ushort8 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(3, 4, 9, 4, 1, 11, 4, 2, 10, 1, 1, 11, 15, 13, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[6];
    ushort8 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(9, 13, 8, 12, 10, 15, 12, 11, 2, 7, 8, 3, 1, 11, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[7];
    ushort8 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(9, 13, 10, 7, 15, 3, 7, 10, 5, 10, 6, 2, 14, 10, 9, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[8];
    ushort8 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(15, 14, 15, 2, 9, 7, 5, 13, 14, 1, 7, 7, 11, 5, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[9];
    ushort8 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(1, 9, 14, 6, 1, 5, 8, 11, 10, 1, 15, 12, 2, 12, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[10];
    ushort8 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(7, 8, 13, 15, 0, 2, 12, 2, 9, 11, 14, 2, 2, 12, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[11];
    ushort8 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(12, 3, 12, 5, 15, 2, 7, 15, 6, 11, 10, 3, 1, 2, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[12];
    ushort8 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(5, 4, 6, 8, 3, 0, 14, 8, 1, 8, 0, 3, 15, 0, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[13];
    ushort8 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(9, 8, 15, 15, 7, 0, 10, 9, 13, 15, 15, 1, 12, 5, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[14];
    ushort8 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(5, 0, 3, 11, 0, 15, 13, 8, 1, 10, 2, 5, 14, 6, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[15];
    ushort8 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(13, 5, 14, 5, 1, 0, 4, 8, 12, 0, 3, 13, 6, 4, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[16];
    ushort8 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(6, 0, 6, 7, 6, 11, 14, 2, 8, 14, 13, 7, 14, 13, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[17];
    ushort8 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(5, 6, 1, 2, 6, 8, 15, 4, 5, 7, 5, 9, 6, 6, 14, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[18];
    ushort8 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(8, 7, 7, 9, 0, 3, 4, 15, 9, 4, 4, 6, 0, 6, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[19];
    ushort8 src2 = secondSource[19];
    ushort16 mask =
        (ushort16)(5, 15, 10, 14, 15, 6, 14, 10, 12, 7, 0, 2, 1, 1, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[20];
    ushort8 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(8, 13, 12, 8, 4, 2, 7, 9, 4, 6, 4, 9, 11, 9, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[21];
    ushort8 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(2, 2, 1, 15, 14, 6, 13, 1, 13, 1, 8, 5, 0, 8, 4, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[22];
    ushort8 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(2, 2, 2, 2, 15, 8, 12, 2, 5, 11, 3, 2, 14, 10, 9, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[23];
    ushort8 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(14, 6, 11, 2, 3, 15, 4, 8, 4, 10, 7, 13, 2, 11, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[24];
    ushort8 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(1, 8, 3, 8, 5, 7, 11, 11, 9, 7, 6, 3, 11, 4, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[25];
    ushort8 src2 = secondSource[25];
    ushort16 mask =
        (ushort16)(5, 2, 8, 4, 7, 11, 12, 0, 3, 12, 13, 9, 13, 4, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[26];
    ushort8 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(13, 9, 10, 7, 8, 14, 9, 15, 8, 4, 10, 0, 6, 3, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[27];
    ushort8 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(3, 5, 8, 10, 4, 13, 5, 9, 1, 8, 9, 8, 15, 10, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[28];
    ushort8 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(14, 8, 0, 11, 6, 7, 13, 9, 4, 15, 2, 0, 10, 9, 15, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[29];
    ushort8 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(10, 15, 1, 5, 11, 15, 0, 15, 8, 10, 13, 10, 6, 10, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[30];
    ushort8 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(14, 14, 2, 11, 6, 14, 7, 11, 0, 11, 8, 15, 9, 4, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[31];
    ushort8 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(0, 9, 1, 14, 6, 8, 6, 15, 14, 13, 5, 9, 11, 10, 9, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
