// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float8 *secondSource,
                          __global float8 *source, __global float4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float8 src1 , src2;
  float4 tmp;
  tmp = (float4)((float)0);
  {
    float8 src1 = source[0];
    float8 src2 = secondSource[0];
    uint4 mask = (uint4)(1, 10, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[1];
    float8 src2 = secondSource[1];
    uint4 mask = (uint4)(13, 1, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[2];
    float8 src2 = secondSource[2];
    uint4 mask = (uint4)(6, 4, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[3];
    float8 src2 = secondSource[3];
    uint4 mask = (uint4)(6, 11, 15, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[4];
    float8 src2 = secondSource[4];
    uint4 mask = (uint4)(11, 13, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[5];
    float8 src2 = secondSource[5];
    uint4 mask = (uint4)(12, 3, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[6];
    float8 src2 = secondSource[6];
    uint4 mask = (uint4)(8, 0, 2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[7];
    float8 src2 = secondSource[7];
    uint4 mask = (uint4)(0, 11, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[8];
    float8 src2 = secondSource[8];
    uint4 mask = (uint4)(13, 10, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[9];
    float8 src2 = secondSource[9];
    uint4 mask = (uint4)(0, 7, 14, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[10];
    float8 src2 = secondSource[10];
    uint4 mask = (uint4)(2, 11, 15, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[11];
    float8 src2 = secondSource[11];
    uint4 mask = (uint4)(3, 15, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[12];
    float8 src2 = secondSource[12];
    uint4 mask = (uint4)(6, 10, 13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[13];
    float8 src2 = secondSource[13];
    uint4 mask = (uint4)(9, 11, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[14];
    float8 src2 = secondSource[14];
    uint4 mask = (uint4)(9, 5, 5, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[15];
    float8 src2 = secondSource[15];
    uint4 mask = (uint4)(12, 13, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[16];
    float8 src2 = secondSource[16];
    uint4 mask = (uint4)(14, 10, 8, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[17];
    float8 src2 = secondSource[17];
    uint4 mask = (uint4)(11, 12, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[18];
    float8 src2 = secondSource[18];
    uint4 mask = (uint4)(4, 1, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[19];
    float8 src2 = secondSource[19];
    uint4 mask = (uint4)(1, 9, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[20];
    float8 src2 = secondSource[20];
    uint4 mask = (uint4)(14, 1, 0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[21];
    float8 src2 = secondSource[21];
    uint4 mask = (uint4)(0, 6, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[22];
    float8 src2 = secondSource[22];
    uint4 mask = (uint4)(9, 2, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[23];
    float8 src2 = secondSource[23];
    uint4 mask = (uint4)(9, 4, 10, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[24];
    float8 src2 = secondSource[24];
    uint4 mask = (uint4)(7, 0, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[25];
    float8 src2 = secondSource[25];
    uint4 mask = (uint4)(9, 15, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[26];
    float8 src2 = secondSource[26];
    uint4 mask = (uint4)(7, 7, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[27];
    float8 src2 = secondSource[27];
    uint4 mask = (uint4)(15, 4, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[28];
    float8 src2 = secondSource[28];
    uint4 mask = (uint4)(2, 8, 11, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[29];
    float8 src2 = secondSource[29];
    uint4 mask = (uint4)(8, 7, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[30];
    float8 src2 = secondSource[30];
    uint4 mask = (uint4)(15, 0, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float8 src1 = source[31];
    float8 src2 = secondSource[31];
    uint4 mask = (uint4)(13, 13, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
