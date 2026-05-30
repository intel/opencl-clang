// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float4 *secondSource,
                          __global float4 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float4 src1 , src2;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float4 src1 = source[0];
    float4 src2 = secondSource[0];
    uint16 mask = (uint16)(2, 3, 4, 3, 5, 2, 2, 0, 4, 5, 4, 3, 5, 4, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[1];
    float4 src2 = secondSource[1];
    uint16 mask = (uint16)(4, 2, 1, 4, 2, 2, 1, 7, 7, 0, 7, 4, 4, 1, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[2];
    float4 src2 = secondSource[2];
    uint16 mask = (uint16)(4, 2, 0, 0, 7, 4, 1, 3, 4, 2, 0, 2, 0, 1, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[3];
    float4 src2 = secondSource[3];
    uint16 mask = (uint16)(6, 6, 4, 5, 5, 1, 7, 5, 4, 5, 1, 4, 3, 4, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[4];
    float4 src2 = secondSource[4];
    uint16 mask = (uint16)(5, 7, 0, 0, 2, 4, 4, 3, 3, 1, 7, 4, 5, 4, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[5];
    float4 src2 = secondSource[5];
    uint16 mask = (uint16)(4, 4, 7, 5, 1, 4, 2, 7, 2, 0, 3, 7, 0, 3, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[6];
    float4 src2 = secondSource[6];
    uint16 mask = (uint16)(2, 3, 6, 5, 0, 0, 2, 0, 0, 3, 0, 0, 1, 0, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[7];
    float4 src2 = secondSource[7];
    uint16 mask = (uint16)(2, 2, 4, 2, 1, 1, 3, 3, 6, 7, 3, 0, 2, 6, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[8];
    float4 src2 = secondSource[8];
    uint16 mask = (uint16)(1, 0, 2, 2, 1, 0, 7, 2, 3, 2, 7, 7, 4, 6, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[9];
    float4 src2 = secondSource[9];
    uint16 mask = (uint16)(3, 6, 0, 5, 3, 7, 1, 2, 5, 5, 5, 2, 3, 1, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[10];
    float4 src2 = secondSource[10];
    uint16 mask = (uint16)(4, 4, 3, 5, 4, 4, 0, 0, 2, 4, 1, 7, 3, 2, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[11];
    float4 src2 = secondSource[11];
    uint16 mask = (uint16)(6, 7, 6, 0, 0, 6, 4, 2, 3, 6, 5, 5, 7, 4, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[12];
    float4 src2 = secondSource[12];
    uint16 mask = (uint16)(7, 4, 7, 3, 0, 6, 1, 1, 7, 7, 4, 0, 3, 5, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[13];
    float4 src2 = secondSource[13];
    uint16 mask = (uint16)(6, 0, 4, 7, 5, 2, 6, 5, 4, 0, 5, 4, 4, 5, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[14];
    float4 src2 = secondSource[14];
    uint16 mask = (uint16)(7, 1, 0, 1, 3, 6, 7, 0, 2, 0, 5, 7, 0, 6, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[15];
    float4 src2 = secondSource[15];
    uint16 mask = (uint16)(5, 3, 2, 3, 5, 1, 6, 2, 3, 6, 6, 3, 2, 0, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[16];
    float4 src2 = secondSource[16];
    uint16 mask = (uint16)(6, 7, 2, 2, 2, 1, 0, 4, 3, 0, 6, 1, 3, 3, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[17];
    float4 src2 = secondSource[17];
    uint16 mask = (uint16)(6, 5, 3, 0, 1, 3, 2, 4, 2, 6, 3, 1, 6, 2, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[18];
    float4 src2 = secondSource[18];
    uint16 mask = (uint16)(1, 6, 5, 6, 6, 6, 3, 1, 7, 3, 1, 2, 1, 1, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[19];
    float4 src2 = secondSource[19];
    uint16 mask = (uint16)(6, 7, 0, 5, 5, 7, 3, 7, 3, 1, 7, 0, 6, 0, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[20];
    float4 src2 = secondSource[20];
    uint16 mask = (uint16)(3, 2, 7, 0, 6, 4, 0, 2, 1, 7, 7, 2, 3, 5, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[21];
    float4 src2 = secondSource[21];
    uint16 mask = (uint16)(6, 6, 5, 2, 6, 3, 5, 3, 5, 5, 2, 3, 2, 4, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[22];
    float4 src2 = secondSource[22];
    uint16 mask = (uint16)(5, 6, 1, 0, 2, 6, 2, 5, 1, 6, 6, 5, 5, 7, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[23];
    float4 src2 = secondSource[23];
    uint16 mask = (uint16)(7, 0, 3, 0, 3, 0, 6, 0, 1, 7, 5, 2, 2, 1, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[24];
    float4 src2 = secondSource[24];
    uint16 mask = (uint16)(4, 1, 0, 4, 5, 0, 7, 4, 4, 1, 7, 5, 0, 2, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[25];
    float4 src2 = secondSource[25];
    uint16 mask = (uint16)(0, 3, 2, 5, 7, 5, 0, 6, 2, 4, 5, 3, 0, 0, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[26];
    float4 src2 = secondSource[26];
    uint16 mask = (uint16)(5, 5, 2, 6, 5, 4, 6, 3, 2, 6, 6, 1, 4, 6, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[27];
    float4 src2 = secondSource[27];
    uint16 mask = (uint16)(6, 4, 4, 6, 1, 1, 0, 4, 6, 5, 7, 5, 4, 0, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[28];
    float4 src2 = secondSource[28];
    uint16 mask = (uint16)(3, 2, 7, 7, 4, 3, 5, 2, 5, 4, 4, 2, 2, 1, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[29];
    float4 src2 = secondSource[29];
    uint16 mask = (uint16)(4, 1, 5, 5, 3, 2, 6, 6, 7, 0, 1, 3, 4, 2, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[30];
    float4 src2 = secondSource[30];
    uint16 mask = (uint16)(4, 1, 4, 0, 5, 3, 6, 4, 3, 3, 1, 1, 6, 7, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float4 src1 = source[31];
    float4 src2 = secondSource[31];
    uint16 mask = (uint16)(5, 1, 0, 5, 7, 5, 2, 3, 5, 2, 4, 1, 1, 1, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
