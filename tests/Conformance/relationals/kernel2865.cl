// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *secondSource, __global int16 *source,
                          __global int2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 , src2;
  int2 tmp;
  tmp = (int2)((int)0);
  {
    int16 src1 = source[0];
    int16 src2 = secondSource[0];
    uint2 mask = (uint2)(18, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint2 mask = (uint2)(22, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint2 mask = (uint2)(14, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint2 mask = (uint2)(31, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint2 mask = (uint2)(22, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint2 mask = (uint2)(9, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint2 mask = (uint2)(5, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint2 mask = (uint2)(0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint2 mask = (uint2)(2, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint2 mask = (uint2)(2, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint2 mask = (uint2)(6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint2 mask = (uint2)(28, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint2 mask = (uint2)(19, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint2 mask = (uint2)(4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint2 mask = (uint2)(11, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint2 mask = (uint2)(3, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint2 mask = (uint2)(16, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint2 mask = (uint2)(6, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint2 mask = (uint2)(31, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint2 mask = (uint2)(16, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint2 mask = (uint2)(9, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint2 mask = (uint2)(23, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint2 mask = (uint2)(3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint2 mask = (uint2)(25, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint2 mask = (uint2)(7, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint2 mask = (uint2)(4, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint2 mask = (uint2)(5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint2 mask = (uint2)(18, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint2 mask = (uint2)(28, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint2 mask = (uint2)(14, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint2 mask = (uint2)(15, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint2 mask = (uint2)(8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
