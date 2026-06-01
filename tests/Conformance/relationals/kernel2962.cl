// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *secondSource,
                          __global ulong16 *source, __global ulong4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 , src2;
  ulong4 tmp;
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong16 src2 = secondSource[0];
    ulong4 mask = (ulong4)(14, 12, 25, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong16 src2 = secondSource[1];
    ulong4 mask = (ulong4)(5, 16, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong16 src2 = secondSource[2];
    ulong4 mask = (ulong4)(12, 24, 16, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong16 src2 = secondSource[3];
    ulong4 mask = (ulong4)(24, 21, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong16 src2 = secondSource[4];
    ulong4 mask = (ulong4)(27, 14, 26, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong16 src2 = secondSource[5];
    ulong4 mask = (ulong4)(13, 1, 26, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong16 src2 = secondSource[6];
    ulong4 mask = (ulong4)(9, 27, 28, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong16 src2 = secondSource[7];
    ulong4 mask = (ulong4)(16, 7, 22, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong16 src2 = secondSource[8];
    ulong4 mask = (ulong4)(7, 25, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong16 src2 = secondSource[9];
    ulong4 mask = (ulong4)(4, 7, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong16 src2 = secondSource[10];
    ulong4 mask = (ulong4)(15, 3, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong16 src2 = secondSource[11];
    ulong4 mask = (ulong4)(0, 12, 20, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong16 src2 = secondSource[12];
    ulong4 mask = (ulong4)(17, 21, 20, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong16 src2 = secondSource[13];
    ulong4 mask = (ulong4)(23, 5, 30, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong16 src2 = secondSource[14];
    ulong4 mask = (ulong4)(22, 17, 11, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong16 src2 = secondSource[15];
    ulong4 mask = (ulong4)(25, 2, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong16 src2 = secondSource[16];
    ulong4 mask = (ulong4)(5, 10, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong16 src2 = secondSource[17];
    ulong4 mask = (ulong4)(14, 26, 23, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong16 src2 = secondSource[18];
    ulong4 mask = (ulong4)(9, 26, 12, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong16 src2 = secondSource[19];
    ulong4 mask = (ulong4)(23, 29, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong16 src2 = secondSource[20];
    ulong4 mask = (ulong4)(18, 4, 11, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong16 src2 = secondSource[21];
    ulong4 mask = (ulong4)(1, 25, 26, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong16 src2 = secondSource[22];
    ulong4 mask = (ulong4)(4, 31, 9, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong16 src2 = secondSource[23];
    ulong4 mask = (ulong4)(6, 29, 29, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong16 src2 = secondSource[24];
    ulong4 mask = (ulong4)(27, 23, 6, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong16 src2 = secondSource[25];
    ulong4 mask = (ulong4)(5, 27, 16, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong16 src2 = secondSource[26];
    ulong4 mask = (ulong4)(22, 16, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong16 src2 = secondSource[27];
    ulong4 mask = (ulong4)(19, 31, 17, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong16 src2 = secondSource[28];
    ulong4 mask = (ulong4)(27, 3, 23, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong16 src2 = secondSource[29];
    ulong4 mask = (ulong4)(28, 13, 28, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong16 src2 = secondSource[30];
    ulong4 mask = (ulong4)(11, 13, 29, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong4)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong16 src2 = secondSource[31];
    ulong4 mask = (ulong4)(17, 5, 8, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
