// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint8 *secondSource, __global uint8 *source,
                          __global uint4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint8 src1 , src2;
  uint4 tmp;
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[0];
    uint8 src2 = secondSource[0];
    uint4 mask = (uint4)(9, 1, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[1];
    uint8 src2 = secondSource[1];
    uint4 mask = (uint4)(4, 1, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[2];
    uint8 src2 = secondSource[2];
    uint4 mask = (uint4)(4, 9, 14, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[3];
    uint8 src2 = secondSource[3];
    uint4 mask = (uint4)(8, 3, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[4];
    uint8 src2 = secondSource[4];
    uint4 mask = (uint4)(14, 13, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[5];
    uint8 src2 = secondSource[5];
    uint4 mask = (uint4)(6, 2, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[6];
    uint8 src2 = secondSource[6];
    uint4 mask = (uint4)(13, 10, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[7];
    uint8 src2 = secondSource[7];
    uint4 mask = (uint4)(9, 11, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[8];
    uint8 src2 = secondSource[8];
    uint4 mask = (uint4)(4, 10, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[9];
    uint8 src2 = secondSource[9];
    uint4 mask = (uint4)(6, 9, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[10];
    uint8 src2 = secondSource[10];
    uint4 mask = (uint4)(9, 13, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[11];
    uint8 src2 = secondSource[11];
    uint4 mask = (uint4)(8, 14, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[12];
    uint8 src2 = secondSource[12];
    uint4 mask = (uint4)(10, 2, 7, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[13];
    uint8 src2 = secondSource[13];
    uint4 mask = (uint4)(4, 10, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[14];
    uint8 src2 = secondSource[14];
    uint4 mask = (uint4)(4, 15, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[15];
    uint8 src2 = secondSource[15];
    uint4 mask = (uint4)(1, 13, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[16];
    uint8 src2 = secondSource[16];
    uint4 mask = (uint4)(9, 13, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[17];
    uint8 src2 = secondSource[17];
    uint4 mask = (uint4)(13, 7, 11, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[18];
    uint8 src2 = secondSource[18];
    uint4 mask = (uint4)(13, 5, 12, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[19];
    uint8 src2 = secondSource[19];
    uint4 mask = (uint4)(2, 15, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[20];
    uint8 src2 = secondSource[20];
    uint4 mask = (uint4)(6, 2, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[21];
    uint8 src2 = secondSource[21];
    uint4 mask = (uint4)(2, 2, 15, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[22];
    uint8 src2 = secondSource[22];
    uint4 mask = (uint4)(2, 7, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[23];
    uint8 src2 = secondSource[23];
    uint4 mask = (uint4)(3, 2, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[24];
    uint8 src2 = secondSource[24];
    uint4 mask = (uint4)(3, 15, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[25];
    uint8 src2 = secondSource[25];
    uint4 mask = (uint4)(15, 14, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[26];
    uint8 src2 = secondSource[26];
    uint4 mask = (uint4)(14, 9, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[27];
    uint8 src2 = secondSource[27];
    uint4 mask = (uint4)(0, 9, 14, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[28];
    uint8 src2 = secondSource[28];
    uint4 mask = (uint4)(10, 2, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[29];
    uint8 src2 = secondSource[29];
    uint4 mask = (uint4)(12, 10, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[30];
    uint8 src2 = secondSource[30];
    uint4 mask = (uint4)(0, 15, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint8 src1 = source[31];
    uint8 src2 = secondSource[31];
    uint4 mask = (uint4)(10, 15, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
