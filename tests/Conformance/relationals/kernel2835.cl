// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *secondSource,
                          __global ushort16 *source, __global ushort4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 , src2;
  ushort4 tmp;
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort16 src2 = secondSource[0];
    ushort4 mask = (ushort4)(27, 3, 7, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 src2 = secondSource[1];
    ushort4 mask = (ushort4)(31, 28, 1, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 src2 = secondSource[2];
    ushort4 mask = (ushort4)(4, 22, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 src2 = secondSource[3];
    ushort4 mask = (ushort4)(4, 19, 9, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 src2 = secondSource[4];
    ushort4 mask = (ushort4)(18, 7, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 src2 = secondSource[5];
    ushort4 mask = (ushort4)(22, 29, 14, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 src2 = secondSource[6];
    ushort4 mask = (ushort4)(21, 18, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 src2 = secondSource[7];
    ushort4 mask = (ushort4)(17, 2, 5, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 src2 = secondSource[8];
    ushort4 mask = (ushort4)(26, 12, 23, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 src2 = secondSource[9];
    ushort4 mask = (ushort4)(7, 19, 7, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 src2 = secondSource[10];
    ushort4 mask = (ushort4)(7, 9, 4, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 src2 = secondSource[11];
    ushort4 mask = (ushort4)(17, 0, 6, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 src2 = secondSource[12];
    ushort4 mask = (ushort4)(14, 10, 4, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 src2 = secondSource[13];
    ushort4 mask = (ushort4)(18, 14, 2, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 src2 = secondSource[14];
    ushort4 mask = (ushort4)(26, 27, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 src2 = secondSource[15];
    ushort4 mask = (ushort4)(3, 16, 15, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 src2 = secondSource[16];
    ushort4 mask = (ushort4)(28, 5, 16, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 src2 = secondSource[17];
    ushort4 mask = (ushort4)(19, 9, 23, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 src2 = secondSource[18];
    ushort4 mask = (ushort4)(1, 13, 26, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 src2 = secondSource[19];
    ushort4 mask = (ushort4)(1, 5, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 src2 = secondSource[20];
    ushort4 mask = (ushort4)(3, 18, 30, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 src2 = secondSource[21];
    ushort4 mask = (ushort4)(17, 18, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 src2 = secondSource[22];
    ushort4 mask = (ushort4)(29, 25, 30, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 src2 = secondSource[23];
    ushort4 mask = (ushort4)(31, 7, 12, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 src2 = secondSource[24];
    ushort4 mask = (ushort4)(10, 31, 21, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 src2 = secondSource[25];
    ushort4 mask = (ushort4)(10, 9, 17, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 src2 = secondSource[26];
    ushort4 mask = (ushort4)(3, 22, 9, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 src2 = secondSource[27];
    ushort4 mask = (ushort4)(29, 25, 0, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 src2 = secondSource[28];
    ushort4 mask = (ushort4)(16, 13, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 src2 = secondSource[29];
    ushort4 mask = (ushort4)(27, 8, 16, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 src2 = secondSource[30];
    ushort4 mask = (ushort4)(30, 12, 16, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 src2 = secondSource[31];
    ushort4 mask = (ushort4)(9, 30, 4, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
