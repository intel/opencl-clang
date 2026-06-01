// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float4 *secondSource,
                          __global float4 *source, __global float2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float4 src1 , src2;
  float2 tmp;
  tmp = (float2)((float)0);
  {
    float4 src1 = source[0];
    float4 src2 = secondSource[0];
    uint2 mask = (uint2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[1];
    float4 src2 = secondSource[1];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[2];
    float4 src2 = secondSource[2];
    uint2 mask = (uint2)(3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[3];
    float4 src2 = secondSource[3];
    uint2 mask = (uint2)(5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[4];
    float4 src2 = secondSource[4];
    uint2 mask = (uint2)(7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[5];
    float4 src2 = secondSource[5];
    uint2 mask = (uint2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[6];
    float4 src2 = secondSource[6];
    uint2 mask = (uint2)(4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[7];
    float4 src2 = secondSource[7];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[8];
    float4 src2 = secondSource[8];
    uint2 mask = (uint2)(0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[9];
    float4 src2 = secondSource[9];
    uint2 mask = (uint2)(5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[10];
    float4 src2 = secondSource[10];
    uint2 mask = (uint2)(7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[11];
    float4 src2 = secondSource[11];
    uint2 mask = (uint2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[12];
    float4 src2 = secondSource[12];
    uint2 mask = (uint2)(4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[13];
    float4 src2 = secondSource[13];
    uint2 mask = (uint2)(6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[14];
    float4 src2 = secondSource[14];
    uint2 mask = (uint2)(0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[15];
    float4 src2 = secondSource[15];
    uint2 mask = (uint2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[16];
    float4 src2 = secondSource[16];
    uint2 mask = (uint2)(4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[17];
    float4 src2 = secondSource[17];
    uint2 mask = (uint2)(1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[18];
    float4 src2 = secondSource[18];
    uint2 mask = (uint2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[19];
    float4 src2 = secondSource[19];
    uint2 mask = (uint2)(5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[20];
    float4 src2 = secondSource[20];
    uint2 mask = (uint2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[21];
    float4 src2 = secondSource[21];
    uint2 mask = (uint2)(0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[22];
    float4 src2 = secondSource[22];
    uint2 mask = (uint2)(1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[23];
    float4 src2 = secondSource[23];
    uint2 mask = (uint2)(7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[24];
    float4 src2 = secondSource[24];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[25];
    float4 src2 = secondSource[25];
    uint2 mask = (uint2)(5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[26];
    float4 src2 = secondSource[26];
    uint2 mask = (uint2)(0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[27];
    float4 src2 = secondSource[27];
    uint2 mask = (uint2)(5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[28];
    float4 src2 = secondSource[28];
    uint2 mask = (uint2)(6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[29];
    float4 src2 = secondSource[29];
    uint2 mask = (uint2)(7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[30];
    float4 src2 = secondSource[30];
    uint2 mask = (uint2)(0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float4 src1 = source[31];
    float4 src2 = secondSource[31];
    uint2 mask = (uint2)(3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
