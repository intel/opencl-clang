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
    uint4 mask = (uint4)(21, 15, 6, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint4 mask = (uint4)(1, 4, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint4 mask = (uint4)(0, 2, 14, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint4 mask = (uint4)(1, 31, 14, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint4 mask = (uint4)(25, 16, 31, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint4 mask = (uint4)(15, 14, 28, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint4 mask = (uint4)(1, 21, 29, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint4 mask = (uint4)(24, 17, 28, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint4 mask = (uint4)(26, 14, 12, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint4 mask = (uint4)(16, 29, 27, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint4 mask = (uint4)(6, 4, 4, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint4 mask = (uint4)(26, 24, 23, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint4 mask = (uint4)(26, 20, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint4 mask = (uint4)(7, 14, 14, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint4 mask = (uint4)(25, 22, 9, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint4 mask = (uint4)(6, 27, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint4 mask = (uint4)(6, 4, 9, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint4 mask = (uint4)(26, 30, 21, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint4 mask = (uint4)(22, 2, 23, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint4 mask = (uint4)(7, 5, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint4 mask = (uint4)(6, 28, 6, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint4 mask = (uint4)(1, 13, 20, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint4 mask = (uint4)(22, 16, 22, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint4 mask = (uint4)(17, 6, 29, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint4 mask = (uint4)(24, 27, 4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint4 mask = (uint4)(31, 17, 25, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint4 mask = (uint4)(21, 13, 22, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint4 mask = (uint4)(3, 18, 16, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint4 mask = (uint4)(23, 14, 22, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint4 mask = (uint4)(5, 10, 30, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint4 mask = (uint4)(15, 9, 25, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint4 mask = (uint4)(29, 1, 9, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
