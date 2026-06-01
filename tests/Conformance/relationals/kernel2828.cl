// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort8 *secondSource,
                          __global ushort8 *source, __global ushort8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort8 src1 , src2;
  ushort8 tmp;
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[0];
    ushort8 src2 = secondSource[0];
    ushort8 mask = (ushort8)(5, 4, 5, 0, 12, 11, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[1];
    ushort8 src2 = secondSource[1];
    ushort8 mask = (ushort8)(7, 1, 10, 5, 13, 5, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[2];
    ushort8 src2 = secondSource[2];
    ushort8 mask = (ushort8)(3, 3, 5, 5, 3, 8, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[3];
    ushort8 src2 = secondSource[3];
    ushort8 mask = (ushort8)(0, 9, 7, 11, 1, 10, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[4];
    ushort8 src2 = secondSource[4];
    ushort8 mask = (ushort8)(13, 0, 13, 10, 14, 11, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[5];
    ushort8 src2 = secondSource[5];
    ushort8 mask = (ushort8)(0, 8, 14, 0, 8, 0, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[6];
    ushort8 src2 = secondSource[6];
    ushort8 mask = (ushort8)(6, 10, 1, 11, 8, 7, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[7];
    ushort8 src2 = secondSource[7];
    ushort8 mask = (ushort8)(6, 2, 1, 5, 0, 8, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[8];
    ushort8 src2 = secondSource[8];
    ushort8 mask = (ushort8)(1, 5, 0, 1, 11, 14, 14, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[9];
    ushort8 src2 = secondSource[9];
    ushort8 mask = (ushort8)(3, 3, 14, 14, 8, 8, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[10];
    ushort8 src2 = secondSource[10];
    ushort8 mask = (ushort8)(13, 12, 7, 9, 15, 8, 0, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[11];
    ushort8 src2 = secondSource[11];
    ushort8 mask = (ushort8)(5, 1, 3, 12, 0, 2, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[12];
    ushort8 src2 = secondSource[12];
    ushort8 mask = (ushort8)(7, 8, 8, 14, 12, 4, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[13];
    ushort8 src2 = secondSource[13];
    ushort8 mask = (ushort8)(0, 6, 10, 6, 14, 1, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[14];
    ushort8 src2 = secondSource[14];
    ushort8 mask = (ushort8)(3, 8, 4, 5, 5, 2, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[15];
    ushort8 src2 = secondSource[15];
    ushort8 mask = (ushort8)(13, 2, 1, 3, 2, 8, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[16];
    ushort8 src2 = secondSource[16];
    ushort8 mask = (ushort8)(10, 13, 14, 9, 7, 5, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[17];
    ushort8 src2 = secondSource[17];
    ushort8 mask = (ushort8)(13, 9, 4, 9, 11, 14, 3, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[18];
    ushort8 src2 = secondSource[18];
    ushort8 mask = (ushort8)(1, 5, 7, 2, 0, 15, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[19];
    ushort8 src2 = secondSource[19];
    ushort8 mask = (ushort8)(3, 0, 14, 11, 0, 2, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[20];
    ushort8 src2 = secondSource[20];
    ushort8 mask = (ushort8)(6, 9, 15, 5, 6, 8, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[21];
    ushort8 src2 = secondSource[21];
    ushort8 mask = (ushort8)(0, 7, 8, 8, 6, 1, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[22];
    ushort8 src2 = secondSource[22];
    ushort8 mask = (ushort8)(7, 4, 14, 6, 14, 0, 10, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[23];
    ushort8 src2 = secondSource[23];
    ushort8 mask = (ushort8)(5, 8, 12, 4, 12, 0, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[24];
    ushort8 src2 = secondSource[24];
    ushort8 mask = (ushort8)(14, 13, 4, 10, 8, 7, 9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[25];
    ushort8 src2 = secondSource[25];
    ushort8 mask = (ushort8)(3, 2, 15, 4, 11, 11, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[26];
    ushort8 src2 = secondSource[26];
    ushort8 mask = (ushort8)(7, 0, 13, 7, 13, 1, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[27];
    ushort8 src2 = secondSource[27];
    ushort8 mask = (ushort8)(13, 2, 13, 3, 13, 14, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[28];
    ushort8 src2 = secondSource[28];
    ushort8 mask = (ushort8)(9, 12, 8, 10, 12, 1, 15, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[29];
    ushort8 src2 = secondSource[29];
    ushort8 mask = (ushort8)(0, 7, 12, 2, 6, 10, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[30];
    ushort8 src2 = secondSource[30];
    ushort8 mask = (ushort8)(9, 13, 3, 3, 13, 10, 0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort8 src1 = source[31];
    ushort8 src2 = secondSource[31];
    ushort8 mask = (ushort8)(1, 10, 13, 8, 11, 3, 11, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
