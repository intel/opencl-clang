// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *secondSource,
                          __global float16 *source, __global float4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 , src2;
  float4 tmp;
  tmp = (float4)((float)0);
  {
    float16 src1 = source[0];
    float16 src2 = secondSource[0];
    uint4 mask = (uint4)(18, 1, 12, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint4 mask = (uint4)(18, 10, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint4 mask = (uint4)(14, 24, 27, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint4 mask = (uint4)(24, 6, 19, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint4 mask = (uint4)(21, 4, 21, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint4 mask = (uint4)(0, 3, 6, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint4 mask = (uint4)(14, 23, 23, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint4 mask = (uint4)(4, 5, 24, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint4 mask = (uint4)(13, 23, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint4 mask = (uint4)(0, 13, 26, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint4 mask = (uint4)(18, 2, 15, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint4 mask = (uint4)(18, 5, 30, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint4 mask = (uint4)(15, 12, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint4 mask = (uint4)(10, 22, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint4 mask = (uint4)(16, 22, 18, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint4 mask = (uint4)(19, 5, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint4 mask = (uint4)(6, 25, 13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint4 mask = (uint4)(6, 4, 14, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint4 mask = (uint4)(27, 19, 24, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint4 mask = (uint4)(11, 28, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint4 mask = (uint4)(15, 28, 25, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint4 mask = (uint4)(23, 13, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint4 mask = (uint4)(1, 22, 16, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint4 mask = (uint4)(1, 9, 23, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint4 mask = (uint4)(16, 4, 15, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint4 mask = (uint4)(10, 7, 20, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint4 mask = (uint4)(27, 7, 26, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint4 mask = (uint4)(4, 5, 19, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint4 mask = (uint4)(12, 14, 12, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint4 mask = (uint4)(6, 14, 25, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint4 mask = (uint4)(21, 10, 28, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint4 mask = (uint4)(6, 10, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
