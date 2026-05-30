// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float2 *secondSource,
                          __global float2 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float2 src1 , src2;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float2 src1 = source[0];
    float2 src2 = secondSource[0];
    uint16 mask = (uint16)(3, 1, 3, 2, 2, 0, 2, 3, 0, 2, 3, 1, 3, 2, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[1];
    float2 src2 = secondSource[1];
    uint16 mask = (uint16)(0, 3, 0, 0, 1, 1, 3, 1, 1, 3, 3, 2, 0, 3, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[2];
    float2 src2 = secondSource[2];
    uint16 mask = (uint16)(3, 3, 2, 2, 0, 0, 1, 3, 0, 1, 1, 1, 3, 0, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[3];
    float2 src2 = secondSource[3];
    uint16 mask = (uint16)(2, 2, 1, 0, 1, 3, 0, 3, 2, 3, 1, 1, 1, 0, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[4];
    float2 src2 = secondSource[4];
    uint16 mask = (uint16)(1, 1, 0, 0, 2, 3, 0, 3, 3, 0, 0, 0, 3, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[5];
    float2 src2 = secondSource[5];
    uint16 mask = (uint16)(0, 1, 1, 0, 1, 3, 3, 1, 2, 0, 1, 0, 0, 1, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[6];
    float2 src2 = secondSource[6];
    uint16 mask = (uint16)(3, 3, 3, 2, 3, 0, 3, 1, 0, 1, 3, 2, 3, 2, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[7];
    float2 src2 = secondSource[7];
    uint16 mask = (uint16)(3, 0, 0, 1, 0, 1, 2, 0, 1, 2, 1, 3, 0, 1, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[8];
    float2 src2 = secondSource[8];
    uint16 mask = (uint16)(3, 3, 0, 1, 2, 3, 2, 3, 1, 1, 1, 0, 3, 1, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[9];
    float2 src2 = secondSource[9];
    uint16 mask = (uint16)(0, 1, 1, 1, 3, 3, 1, 1, 2, 3, 3, 3, 2, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[10];
    float2 src2 = secondSource[10];
    uint16 mask = (uint16)(2, 2, 0, 1, 2, 2, 0, 0, 1, 2, 0, 3, 3, 0, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[11];
    float2 src2 = secondSource[11];
    uint16 mask = (uint16)(3, 1, 1, 0, 3, 1, 2, 0, 1, 1, 3, 0, 0, 2, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[12];
    float2 src2 = secondSource[12];
    uint16 mask = (uint16)(0, 2, 3, 2, 1, 2, 2, 1, 1, 0, 0, 0, 0, 1, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[13];
    float2 src2 = secondSource[13];
    uint16 mask = (uint16)(2, 2, 0, 1, 1, 0, 2, 2, 0, 0, 3, 2, 3, 2, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[14];
    float2 src2 = secondSource[14];
    uint16 mask = (uint16)(2, 3, 1, 3, 1, 2, 2, 0, 1, 2, 3, 1, 3, 1, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[15];
    float2 src2 = secondSource[15];
    uint16 mask = (uint16)(1, 1, 2, 1, 1, 0, 1, 0, 2, 3, 2, 2, 2, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[16];
    float2 src2 = secondSource[16];
    uint16 mask = (uint16)(1, 2, 1, 1, 2, 1, 3, 1, 1, 3, 0, 0, 0, 1, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[17];
    float2 src2 = secondSource[17];
    uint16 mask = (uint16)(0, 3, 0, 0, 1, 2, 3, 2, 3, 1, 1, 0, 2, 3, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[18];
    float2 src2 = secondSource[18];
    uint16 mask = (uint16)(1, 1, 1, 2, 3, 1, 3, 1, 0, 2, 1, 1, 3, 0, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[19];
    float2 src2 = secondSource[19];
    uint16 mask = (uint16)(3, 3, 3, 3, 3, 3, 0, 3, 1, 1, 1, 1, 3, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[20];
    float2 src2 = secondSource[20];
    uint16 mask = (uint16)(2, 2, 0, 3, 1, 1, 3, 3, 3, 3, 0, 1, 2, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[21];
    float2 src2 = secondSource[21];
    uint16 mask = (uint16)(0, 0, 2, 3, 2, 1, 2, 1, 2, 0, 0, 3, 0, 3, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[22];
    float2 src2 = secondSource[22];
    uint16 mask = (uint16)(3, 2, 2, 2, 3, 1, 0, 3, 1, 1, 1, 1, 1, 1, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[23];
    float2 src2 = secondSource[23];
    uint16 mask = (uint16)(3, 3, 1, 3, 1, 2, 1, 2, 0, 3, 3, 3, 1, 3, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[24];
    float2 src2 = secondSource[24];
    uint16 mask = (uint16)(1, 3, 1, 0, 1, 2, 2, 2, 0, 0, 0, 3, 2, 0, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[25];
    float2 src2 = secondSource[25];
    uint16 mask = (uint16)(1, 2, 3, 0, 1, 1, 0, 2, 0, 0, 1, 3, 3, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[26];
    float2 src2 = secondSource[26];
    uint16 mask = (uint16)(0, 3, 1, 2, 3, 3, 1, 1, 0, 3, 3, 3, 2, 3, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[27];
    float2 src2 = secondSource[27];
    uint16 mask = (uint16)(0, 0, 1, 0, 0, 1, 0, 3, 0, 2, 0, 3, 0, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[28];
    float2 src2 = secondSource[28];
    uint16 mask = (uint16)(1, 1, 0, 3, 2, 1, 1, 3, 1, 0, 2, 1, 3, 2, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[29];
    float2 src2 = secondSource[29];
    uint16 mask = (uint16)(1, 3, 0, 3, 2, 2, 1, 0, 2, 2, 1, 2, 0, 0, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[30];
    float2 src2 = secondSource[30];
    uint16 mask = (uint16)(3, 1, 2, 0, 3, 2, 2, 0, 1, 0, 3, 2, 3, 0, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float2 src1 = source[31];
    float2 src2 = secondSource[31];
    uint16 mask = (uint16)(1, 2, 1, 2, 2, 3, 1, 0, 1, 1, 2, 3, 3, 1, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
