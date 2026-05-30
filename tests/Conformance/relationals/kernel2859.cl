// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int8 *secondSource, __global int8 *source,
                          __global int4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int8 src1 , src2;
  int4 tmp;
  tmp = (int4)((int)0);
  {
    int8 src1 = source[0];
    int8 src2 = secondSource[0];
    uint4 mask = (uint4)(2, 15, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[1];
    int8 src2 = secondSource[1];
    uint4 mask = (uint4)(5, 8, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[2];
    int8 src2 = secondSource[2];
    uint4 mask = (uint4)(9, 13, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[3];
    int8 src2 = secondSource[3];
    uint4 mask = (uint4)(1, 6, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[4];
    int8 src2 = secondSource[4];
    uint4 mask = (uint4)(11, 15, 6, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[5];
    int8 src2 = secondSource[5];
    uint4 mask = (uint4)(9, 6, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[6];
    int8 src2 = secondSource[6];
    uint4 mask = (uint4)(14, 7, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[7];
    int8 src2 = secondSource[7];
    uint4 mask = (uint4)(3, 6, 9, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[8];
    int8 src2 = secondSource[8];
    uint4 mask = (uint4)(11, 15, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[9];
    int8 src2 = secondSource[9];
    uint4 mask = (uint4)(0, 3, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[10];
    int8 src2 = secondSource[10];
    uint4 mask = (uint4)(15, 11, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[11];
    int8 src2 = secondSource[11];
    uint4 mask = (uint4)(14, 13, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[12];
    int8 src2 = secondSource[12];
    uint4 mask = (uint4)(10, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[13];
    int8 src2 = secondSource[13];
    uint4 mask = (uint4)(2, 0, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[14];
    int8 src2 = secondSource[14];
    uint4 mask = (uint4)(12, 13, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[15];
    int8 src2 = secondSource[15];
    uint4 mask = (uint4)(0, 4, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[16];
    int8 src2 = secondSource[16];
    uint4 mask = (uint4)(0, 6, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[17];
    int8 src2 = secondSource[17];
    uint4 mask = (uint4)(10, 9, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[18];
    int8 src2 = secondSource[18];
    uint4 mask = (uint4)(8, 7, 6, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[19];
    int8 src2 = secondSource[19];
    uint4 mask = (uint4)(12, 15, 6, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[20];
    int8 src2 = secondSource[20];
    uint4 mask = (uint4)(14, 2, 11, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[21];
    int8 src2 = secondSource[21];
    uint4 mask = (uint4)(1, 13, 12, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[22];
    int8 src2 = secondSource[22];
    uint4 mask = (uint4)(12, 7, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[23];
    int8 src2 = secondSource[23];
    uint4 mask = (uint4)(0, 9, 2, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[24];
    int8 src2 = secondSource[24];
    uint4 mask = (uint4)(12, 1, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[25];
    int8 src2 = secondSource[25];
    uint4 mask = (uint4)(13, 10, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[26];
    int8 src2 = secondSource[26];
    uint4 mask = (uint4)(7, 10, 10, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[27];
    int8 src2 = secondSource[27];
    uint4 mask = (uint4)(4, 6, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[28];
    int8 src2 = secondSource[28];
    uint4 mask = (uint4)(5, 7, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[29];
    int8 src2 = secondSource[29];
    uint4 mask = (uint4)(1, 6, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[30];
    int8 src2 = secondSource[30];
    uint4 mask = (uint4)(3, 8, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int8 src1 = source[31];
    int8 src2 = secondSource[31];
    uint4 mask = (uint4)(4, 5, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
