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
        (ushort16)(0, 11, 7, 13, 10, 5, 4, 9, 11, 7, 14, 12, 4, 0, 9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[1];
    ushort8 src2 = secondSource[1];
    ushort16 mask =
        (ushort16)(0, 7, 10, 10, 8, 1, 6, 11, 14, 10, 15, 8, 5, 8, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[2];
    ushort8 src2 = secondSource[2];
    ushort16 mask =
        (ushort16)(1, 8, 8, 10, 14, 6, 3, 10, 0, 5, 6, 15, 3, 14, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[3];
    ushort8 src2 = secondSource[3];
    ushort16 mask =
        (ushort16)(14, 13, 13, 11, 5, 14, 14, 14, 13, 1, 15, 5, 8, 13, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[4];
    ushort8 src2 = secondSource[4];
    ushort16 mask =
        (ushort16)(15, 8, 14, 15, 15, 15, 5, 7, 7, 8, 12, 2, 10, 12, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[5];
    ushort8 src2 = secondSource[5];
    ushort16 mask =
        (ushort16)(14, 11, 8, 1, 6, 15, 12, 1, 1, 15, 7, 7, 9, 11, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[6];
    ushort8 src2 = secondSource[6];
    ushort16 mask =
        (ushort16)(12, 4, 15, 9, 10, 12, 10, 14, 14, 15, 8, 8, 2, 7, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[7];
    ushort8 src2 = secondSource[7];
    ushort16 mask =
        (ushort16)(15, 12, 3, 3, 3, 7, 8, 12, 4, 9, 13, 0, 7, 12, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[8];
    ushort8 src2 = secondSource[8];
    ushort16 mask =
        (ushort16)(0, 5, 1, 11, 5, 6, 14, 9, 5, 2, 2, 11, 15, 0, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[9];
    ushort8 src2 = secondSource[9];
    ushort16 mask =
        (ushort16)(6, 8, 11, 0, 14, 5, 2, 2, 8, 9, 11, 6, 15, 6, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[10];
    ushort8 src2 = secondSource[10];
    ushort16 mask =
        (ushort16)(7, 0, 2, 15, 9, 4, 8, 11, 10, 3, 8, 2, 3, 10, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[11];
    ushort8 src2 = secondSource[11];
    ushort16 mask =
        (ushort16)(2, 14, 3, 10, 5, 4, 13, 9, 7, 11, 0, 7, 15, 7, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[12];
    ushort8 src2 = secondSource[12];
    ushort16 mask =
        (ushort16)(14, 8, 8, 12, 9, 15, 10, 10, 6, 10, 5, 6, 0, 8, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[13];
    ushort8 src2 = secondSource[13];
    ushort16 mask =
        (ushort16)(15, 0, 7, 5, 8, 4, 5, 15, 3, 1, 1, 2, 15, 6, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[14];
    ushort8 src2 = secondSource[14];
    ushort16 mask =
        (ushort16)(8, 9, 10, 11, 14, 6, 11, 13, 6, 12, 0, 9, 0, 10, 12, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[15];
    ushort8 src2 = secondSource[15];
    ushort16 mask =
        (ushort16)(15, 10, 12, 12, 7, 9, 5, 11, 2, 6, 8, 15, 6, 3, 10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[16];
    ushort8 src2 = secondSource[16];
    ushort16 mask =
        (ushort16)(13, 11, 1, 7, 3, 9, 1, 2, 3, 14, 3, 13, 0, 7, 0, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[17];
    ushort8 src2 = secondSource[17];
    ushort16 mask =
        (ushort16)(2, 5, 7, 14, 4, 4, 13, 6, 0, 4, 5, 0, 8, 4, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[18];
    ushort8 src2 = secondSource[18];
    ushort16 mask =
        (ushort16)(14, 1, 14, 12, 13, 8, 10, 7, 5, 2, 4, 6, 13, 12, 9, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[19];
    ushort8 src2 = secondSource[19];
    ushort16 mask =
        (ushort16)(4, 15, 11, 4, 13, 0, 6, 6, 15, 11, 8, 13, 14, 4, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[20];
    ushort8 src2 = secondSource[20];
    ushort16 mask =
        (ushort16)(5, 3, 2, 14, 5, 1, 8, 12, 12, 12, 1, 12, 10, 14, 12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[21];
    ushort8 src2 = secondSource[21];
    ushort16 mask =
        (ushort16)(10, 0, 11, 6, 12, 4, 14, 6, 1, 11, 9, 9, 2, 12, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[22];
    ushort8 src2 = secondSource[22];
    ushort16 mask =
        (ushort16)(0, 3, 0, 14, 0, 15, 6, 2, 1, 9, 13, 1, 14, 5, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[23];
    ushort8 src2 = secondSource[23];
    ushort16 mask =
        (ushort16)(5, 14, 6, 8, 7, 11, 15, 6, 4, 7, 2, 6, 0, 0, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[24];
    ushort8 src2 = secondSource[24];
    ushort16 mask =
        (ushort16)(13, 7, 4, 5, 7, 13, 7, 7, 6, 0, 2, 0, 10, 11, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[25];
    ushort8 src2 = secondSource[25];
    ushort16 mask =
        (ushort16)(2, 2, 12, 10, 12, 0, 3, 3, 1, 12, 13, 15, 8, 4, 4, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[26];
    ushort8 src2 = secondSource[26];
    ushort16 mask =
        (ushort16)(3, 4, 0, 8, 5, 10, 4, 15, 2, 8, 7, 1, 9, 10, 0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[27];
    ushort8 src2 = secondSource[27];
    ushort16 mask =
        (ushort16)(10, 4, 14, 9, 5, 10, 3, 10, 1, 12, 5, 13, 10, 9, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[28];
    ushort8 src2 = secondSource[28];
    ushort16 mask =
        (ushort16)(12, 12, 10, 15, 6, 11, 2, 7, 6, 10, 7, 15, 2, 4, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[29];
    ushort8 src2 = secondSource[29];
    ushort16 mask =
        (ushort16)(0, 6, 0, 14, 11, 13, 9, 8, 11, 7, 4, 2, 9, 5, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[30];
    ushort8 src2 = secondSource[30];
    ushort16 mask =
        (ushort16)(1, 14, 11, 11, 8, 10, 2, 12, 6, 13, 0, 1, 3, 11, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort8 src1 = source[31];
    ushort8 src2 = secondSource[31];
    ushort16 mask =
        (ushort16)(14, 2, 12, 8, 0, 3, 12, 10, 4, 13, 6, 12, 9, 5, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
