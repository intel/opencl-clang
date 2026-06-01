// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int8 *secondSource, __global int8 *source,
                          __global int2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int8 src1 , src2;
  int2 tmp;
  tmp = (int2)((int)0);
  {
    int8 src1 = source[0];
    int8 src2 = secondSource[0];
    uint2 mask = (uint2)(2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[1];
    int8 src2 = secondSource[1];
    uint2 mask = (uint2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[2];
    int8 src2 = secondSource[2];
    uint2 mask = (uint2)(7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[3];
    int8 src2 = secondSource[3];
    uint2 mask = (uint2)(15, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[4];
    int8 src2 = secondSource[4];
    uint2 mask = (uint2)(5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[5];
    int8 src2 = secondSource[5];
    uint2 mask = (uint2)(15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[6];
    int8 src2 = secondSource[6];
    uint2 mask = (uint2)(9, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[7];
    int8 src2 = secondSource[7];
    uint2 mask = (uint2)(8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[8];
    int8 src2 = secondSource[8];
    uint2 mask = (uint2)(13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[9];
    int8 src2 = secondSource[9];
    uint2 mask = (uint2)(8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[10];
    int8 src2 = secondSource[10];
    uint2 mask = (uint2)(0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[11];
    int8 src2 = secondSource[11];
    uint2 mask = (uint2)(9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[12];
    int8 src2 = secondSource[12];
    uint2 mask = (uint2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[13];
    int8 src2 = secondSource[13];
    uint2 mask = (uint2)(2, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[14];
    int8 src2 = secondSource[14];
    uint2 mask = (uint2)(10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[15];
    int8 src2 = secondSource[15];
    uint2 mask = (uint2)(2, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[16];
    int8 src2 = secondSource[16];
    uint2 mask = (uint2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[17];
    int8 src2 = secondSource[17];
    uint2 mask = (uint2)(9, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[18];
    int8 src2 = secondSource[18];
    uint2 mask = (uint2)(3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[19];
    int8 src2 = secondSource[19];
    uint2 mask = (uint2)(1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[20];
    int8 src2 = secondSource[20];
    uint2 mask = (uint2)(14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[21];
    int8 src2 = secondSource[21];
    uint2 mask = (uint2)(8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[22];
    int8 src2 = secondSource[22];
    uint2 mask = (uint2)(4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[23];
    int8 src2 = secondSource[23];
    uint2 mask = (uint2)(0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[24];
    int8 src2 = secondSource[24];
    uint2 mask = (uint2)(13, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[25];
    int8 src2 = secondSource[25];
    uint2 mask = (uint2)(14, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[26];
    int8 src2 = secondSource[26];
    uint2 mask = (uint2)(10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[27];
    int8 src2 = secondSource[27];
    uint2 mask = (uint2)(5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[28];
    int8 src2 = secondSource[28];
    uint2 mask = (uint2)(8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[29];
    int8 src2 = secondSource[29];
    uint2 mask = (uint2)(2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[30];
    int8 src2 = secondSource[30];
    uint2 mask = (uint2)(8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int8 src1 = source[31];
    int8 src2 = secondSource[31];
    uint2 mask = (uint2)(1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
