// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *secondSource,
                          __global uint16 *source, __global uint4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 , src2;
  uint4 tmp;
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[0];
    uint16 src2 = secondSource[0];
    uint4 mask = (uint4)(19, 27, 2, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[1];
    uint16 src2 = secondSource[1];
    uint4 mask = (uint4)(9, 23, 24, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[2];
    uint16 src2 = secondSource[2];
    uint4 mask = (uint4)(19, 18, 26, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[3];
    uint16 src2 = secondSource[3];
    uint4 mask = (uint4)(10, 16, 10, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[4];
    uint16 src2 = secondSource[4];
    uint4 mask = (uint4)(14, 8, 9, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[5];
    uint16 src2 = secondSource[5];
    uint4 mask = (uint4)(8, 25, 12, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[6];
    uint16 src2 = secondSource[6];
    uint4 mask = (uint4)(14, 30, 20, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[7];
    uint16 src2 = secondSource[7];
    uint4 mask = (uint4)(11, 18, 23, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[8];
    uint16 src2 = secondSource[8];
    uint4 mask = (uint4)(24, 9, 29, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[9];
    uint16 src2 = secondSource[9];
    uint4 mask = (uint4)(23, 18, 5, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[10];
    uint16 src2 = secondSource[10];
    uint4 mask = (uint4)(2, 19, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[11];
    uint16 src2 = secondSource[11];
    uint4 mask = (uint4)(8, 25, 10, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[12];
    uint16 src2 = secondSource[12];
    uint4 mask = (uint4)(11, 10, 0, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[13];
    uint16 src2 = secondSource[13];
    uint4 mask = (uint4)(5, 2, 1, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[14];
    uint16 src2 = secondSource[14];
    uint4 mask = (uint4)(31, 28, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[15];
    uint16 src2 = secondSource[15];
    uint4 mask = (uint4)(22, 11, 18, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[16];
    uint16 src2 = secondSource[16];
    uint4 mask = (uint4)(24, 1, 26, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[17];
    uint16 src2 = secondSource[17];
    uint4 mask = (uint4)(12, 23, 15, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[18];
    uint16 src2 = secondSource[18];
    uint4 mask = (uint4)(0, 12, 21, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[19];
    uint16 src2 = secondSource[19];
    uint4 mask = (uint4)(7, 29, 11, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[20];
    uint16 src2 = secondSource[20];
    uint4 mask = (uint4)(16, 22, 14, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[21];
    uint16 src2 = secondSource[21];
    uint4 mask = (uint4)(19, 27, 30, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[22];
    uint16 src2 = secondSource[22];
    uint4 mask = (uint4)(24, 15, 28, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[23];
    uint16 src2 = secondSource[23];
    uint4 mask = (uint4)(18, 3, 29, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[24];
    uint16 src2 = secondSource[24];
    uint4 mask = (uint4)(24, 5, 20, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[25];
    uint16 src2 = secondSource[25];
    uint4 mask = (uint4)(6, 29, 8, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[26];
    uint16 src2 = secondSource[26];
    uint4 mask = (uint4)(8, 24, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[27];
    uint16 src2 = secondSource[27];
    uint4 mask = (uint4)(6, 27, 23, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[28];
    uint16 src2 = secondSource[28];
    uint4 mask = (uint4)(16, 22, 9, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[29];
    uint16 src2 = secondSource[29];
    uint4 mask = (uint4)(22, 9, 22, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[30];
    uint16 src2 = secondSource[30];
    uint4 mask = (uint4)(20, 14, 23, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[31];
    uint16 src2 = secondSource[31];
    uint4 mask = (uint4)(6, 29, 20, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
