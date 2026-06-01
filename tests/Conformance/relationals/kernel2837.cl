// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *secondSource,
                          __global ushort16 *source, __global ushort8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 , src2;
  ushort8 tmp;
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort16 src2 = secondSource[0];
    ushort8 mask = (ushort8)(11, 8, 11, 28, 29, 26, 10, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 src2 = secondSource[1];
    ushort8 mask = (ushort8)(24, 3, 28, 24, 28, 30, 13, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 src2 = secondSource[2];
    ushort8 mask = (ushort8)(30, 15, 31, 21, 26, 21, 28, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 src2 = secondSource[3];
    ushort8 mask = (ushort8)(2, 16, 13, 0, 12, 26, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 src2 = secondSource[4];
    ushort8 mask = (ushort8)(10, 14, 8, 29, 20, 12, 9, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 src2 = secondSource[5];
    ushort8 mask = (ushort8)(9, 7, 5, 11, 7, 10, 19, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 src2 = secondSource[6];
    ushort8 mask = (ushort8)(20, 5, 13, 21, 22, 23, 5, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 src2 = secondSource[7];
    ushort8 mask = (ushort8)(17, 18, 21, 7, 20, 5, 16, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 src2 = secondSource[8];
    ushort8 mask = (ushort8)(3, 17, 2, 23, 10, 29, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 src2 = secondSource[9];
    ushort8 mask = (ushort8)(6, 7, 7, 21, 0, 4, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 src2 = secondSource[10];
    ushort8 mask = (ushort8)(1, 17, 15, 15, 22, 30, 25, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 src2 = secondSource[11];
    ushort8 mask = (ushort8)(20, 14, 8, 31, 12, 11, 15, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 src2 = secondSource[12];
    ushort8 mask = (ushort8)(9, 25, 18, 2, 15, 23, 25, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 src2 = secondSource[13];
    ushort8 mask = (ushort8)(28, 22, 12, 12, 28, 10, 17, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 src2 = secondSource[14];
    ushort8 mask = (ushort8)(8, 6, 28, 5, 29, 2, 28, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 src2 = secondSource[15];
    ushort8 mask = (ushort8)(14, 8, 17, 13, 5, 26, 30, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 src2 = secondSource[16];
    ushort8 mask = (ushort8)(1, 16, 26, 1, 6, 24, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 src2 = secondSource[17];
    ushort8 mask = (ushort8)(22, 25, 2, 3, 24, 20, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 src2 = secondSource[18];
    ushort8 mask = (ushort8)(26, 22, 16, 22, 29, 19, 17, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 src2 = secondSource[19];
    ushort8 mask = (ushort8)(6, 23, 7, 3, 14, 2, 31, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 src2 = secondSource[20];
    ushort8 mask = (ushort8)(11, 8, 25, 18, 18, 11, 30, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 src2 = secondSource[21];
    ushort8 mask = (ushort8)(24, 15, 0, 2, 3, 24, 5, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 src2 = secondSource[22];
    ushort8 mask = (ushort8)(15, 11, 26, 11, 27, 21, 16, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 src2 = secondSource[23];
    ushort8 mask = (ushort8)(19, 27, 7, 12, 2, 25, 2, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 src2 = secondSource[24];
    ushort8 mask = (ushort8)(3, 12, 9, 6, 11, 12, 27, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 src2 = secondSource[25];
    ushort8 mask = (ushort8)(29, 7, 4, 10, 22, 31, 18, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 src2 = secondSource[26];
    ushort8 mask = (ushort8)(18, 18, 16, 11, 2, 6, 5, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 src2 = secondSource[27];
    ushort8 mask = (ushort8)(10, 25, 13, 17, 0, 2, 1, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 src2 = secondSource[28];
    ushort8 mask = (ushort8)(2, 23, 2, 7, 29, 28, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 src2 = secondSource[29];
    ushort8 mask = (ushort8)(30, 13, 2, 5, 26, 29, 18, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 src2 = secondSource[30];
    ushort8 mask = (ushort8)(12, 31, 16, 9, 31, 11, 4, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 src2 = secondSource[31];
    ushort8 mask = (ushort8)(14, 10, 31, 23, 20, 26, 31, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
