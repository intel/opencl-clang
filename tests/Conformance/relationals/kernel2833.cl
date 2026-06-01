// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *secondSource,
                          __global ushort16 *source, __global ushort2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 , src2;
  ushort2 tmp;
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort16 src2 = secondSource[0];
    ushort2 mask = (ushort2)(14, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 src2 = secondSource[1];
    ushort2 mask = (ushort2)(7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 src2 = secondSource[2];
    ushort2 mask = (ushort2)(15, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 src2 = secondSource[3];
    ushort2 mask = (ushort2)(1, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 src2 = secondSource[4];
    ushort2 mask = (ushort2)(23, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 src2 = secondSource[5];
    ushort2 mask = (ushort2)(22, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 src2 = secondSource[6];
    ushort2 mask = (ushort2)(25, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 src2 = secondSource[7];
    ushort2 mask = (ushort2)(2, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 src2 = secondSource[8];
    ushort2 mask = (ushort2)(17, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 src2 = secondSource[9];
    ushort2 mask = (ushort2)(9, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 src2 = secondSource[10];
    ushort2 mask = (ushort2)(5, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 src2 = secondSource[11];
    ushort2 mask = (ushort2)(8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 src2 = secondSource[12];
    ushort2 mask = (ushort2)(12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 src2 = secondSource[13];
    ushort2 mask = (ushort2)(10, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 src2 = secondSource[14];
    ushort2 mask = (ushort2)(11, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 src2 = secondSource[15];
    ushort2 mask = (ushort2)(3, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 src2 = secondSource[16];
    ushort2 mask = (ushort2)(30, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 src2 = secondSource[17];
    ushort2 mask = (ushort2)(19, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 src2 = secondSource[18];
    ushort2 mask = (ushort2)(0, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 src2 = secondSource[19];
    ushort2 mask = (ushort2)(27, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 src2 = secondSource[20];
    ushort2 mask = (ushort2)(6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 src2 = secondSource[21];
    ushort2 mask = (ushort2)(5, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 src2 = secondSource[22];
    ushort2 mask = (ushort2)(16, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 src2 = secondSource[23];
    ushort2 mask = (ushort2)(0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 src2 = secondSource[24];
    ushort2 mask = (ushort2)(26, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 src2 = secondSource[25];
    ushort2 mask = (ushort2)(2, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 src2 = secondSource[26];
    ushort2 mask = (ushort2)(7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 src2 = secondSource[27];
    ushort2 mask = (ushort2)(10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 src2 = secondSource[28];
    ushort2 mask = (ushort2)(10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 src2 = secondSource[29];
    ushort2 mask = (ushort2)(23, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 src2 = secondSource[30];
    ushort2 mask = (ushort2)(4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort2)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 src2 = secondSource[31];
    ushort2 mask = (ushort2)(28, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
