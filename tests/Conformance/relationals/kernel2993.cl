// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *secondSource,
                          __global float16 *source, __global float2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 , src2;
  float2 tmp;
  tmp = (float2)((float)0);
  {
    float16 src1 = source[0];
    float16 src2 = secondSource[0];
    uint2 mask = (uint2)(21, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint2 mask = (uint2)(12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint2 mask = (uint2)(24, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint2 mask = (uint2)(21, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint2 mask = (uint2)(28, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint2 mask = (uint2)(29, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint2 mask = (uint2)(12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint2 mask = (uint2)(21, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint2 mask = (uint2)(31, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint2 mask = (uint2)(26, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint2 mask = (uint2)(3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint2 mask = (uint2)(27, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint2 mask = (uint2)(9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint2 mask = (uint2)(25, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint2 mask = (uint2)(27, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint2 mask = (uint2)(26, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint2 mask = (uint2)(11, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint2 mask = (uint2)(4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint2 mask = (uint2)(6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint2 mask = (uint2)(25, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint2 mask = (uint2)(5, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint2 mask = (uint2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint2 mask = (uint2)(20, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint2 mask = (uint2)(3, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint2 mask = (uint2)(8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint2 mask = (uint2)(19, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint2 mask = (uint2)(24, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint2 mask = (uint2)(4, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint2 mask = (uint2)(1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint2 mask = (uint2)(8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint2 mask = (uint2)(2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float2)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint2 mask = (uint2)(12, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
