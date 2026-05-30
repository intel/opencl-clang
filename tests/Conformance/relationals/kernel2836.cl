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
    ushort8 mask = (ushort8)(0, 3, 15, 8, 18, 31, 5, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 src2 = secondSource[1];
    ushort8 mask = (ushort8)(10, 8, 12, 10, 11, 9, 19, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 src2 = secondSource[2];
    ushort8 mask = (ushort8)(16, 7, 16, 30, 8, 6, 25, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 src2 = secondSource[3];
    ushort8 mask = (ushort8)(31, 7, 24, 27, 3, 16, 31, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 src2 = secondSource[4];
    ushort8 mask = (ushort8)(21, 3, 2, 1, 31, 17, 19, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 src2 = secondSource[5];
    ushort8 mask = (ushort8)(0, 25, 7, 9, 16, 0, 30, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 src2 = secondSource[6];
    ushort8 mask = (ushort8)(1, 23, 14, 2, 2, 31, 13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 src2 = secondSource[7];
    ushort8 mask = (ushort8)(4, 6, 26, 23, 9, 15, 24, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 src2 = secondSource[8];
    ushort8 mask = (ushort8)(3, 21, 30, 11, 17, 23, 7, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 src2 = secondSource[9];
    ushort8 mask = (ushort8)(25, 16, 18, 11, 7, 14, 21, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 src2 = secondSource[10];
    ushort8 mask = (ushort8)(20, 15, 30, 23, 22, 24, 21, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 src2 = secondSource[11];
    ushort8 mask = (ushort8)(9, 8, 24, 15, 2, 2, 3, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 src2 = secondSource[12];
    ushort8 mask = (ushort8)(5, 20, 19, 27, 6, 3, 0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 src2 = secondSource[13];
    ushort8 mask = (ushort8)(18, 11, 9, 13, 20, 24, 15, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 src2 = secondSource[14];
    ushort8 mask = (ushort8)(27, 17, 0, 23, 18, 12, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 src2 = secondSource[15];
    ushort8 mask = (ushort8)(21, 9, 18, 8, 30, 3, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 src2 = secondSource[16];
    ushort8 mask = (ushort8)(21, 13, 25, 27, 16, 5, 8, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 src2 = secondSource[17];
    ushort8 mask = (ushort8)(11, 17, 14, 20, 3, 9, 10, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 src2 = secondSource[18];
    ushort8 mask = (ushort8)(2, 8, 14, 7, 7, 13, 18, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 src2 = secondSource[19];
    ushort8 mask = (ushort8)(27, 13, 6, 24, 12, 17, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 src2 = secondSource[20];
    ushort8 mask = (ushort8)(15, 22, 14, 20, 15, 23, 31, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 src2 = secondSource[21];
    ushort8 mask = (ushort8)(0, 24, 11, 9, 20, 10, 6, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 src2 = secondSource[22];
    ushort8 mask = (ushort8)(22, 3, 4, 10, 14, 27, 21, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 src2 = secondSource[23];
    ushort8 mask = (ushort8)(3, 31, 29, 10, 11, 18, 28, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 src2 = secondSource[24];
    ushort8 mask = (ushort8)(23, 7, 5, 11, 29, 28, 10, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 src2 = secondSource[25];
    ushort8 mask = (ushort8)(15, 0, 23, 0, 29, 20, 10, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 src2 = secondSource[26];
    ushort8 mask = (ushort8)(28, 0, 4, 10, 28, 0, 25, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 src2 = secondSource[27];
    ushort8 mask = (ushort8)(10, 13, 9, 22, 24, 16, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 src2 = secondSource[28];
    ushort8 mask = (ushort8)(23, 28, 21, 28, 19, 11, 9, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 src2 = secondSource[29];
    ushort8 mask = (ushort8)(20, 5, 16, 30, 0, 28, 29, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 src2 = secondSource[30];
    ushort8 mask = (ushort8)(15, 25, 28, 11, 0, 30, 25, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 src2 = secondSource[31];
    ushort8 mask = (ushort8)(30, 17, 10, 28, 19, 14, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
