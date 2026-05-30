// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *source, __global float4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 /*, src2*/;
  float4 tmp;
  tmp = (float4)((float)0);
  {
    float16 src1 = source[0];
    uint4 mask = (uint4)(9, 0, 6, 10);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[1];
    uint4 mask = (uint4)(9, 5, 0, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[2];
    uint4 mask = (uint4)(7, 12, 13, 7);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[3];
    uint4 mask = (uint4)(12, 3, 9, 6);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[4];
    uint4 mask = (uint4)(10, 2, 10, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[5];
    uint4 mask = (uint4)(0, 1, 3, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[6];
    uint4 mask = (uint4)(7, 11, 11, 5);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[7];
    uint4 mask = (uint4)(2, 2, 12, 11);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[8];
    uint4 mask = (uint4)(6, 11, 3, 7);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[9];
    uint4 mask = (uint4)(0, 6, 13, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[10];
    uint4 mask = (uint4)(9, 1, 7, 9);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[11];
    uint4 mask = (uint4)(9, 2, 15, 9);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[12];
    uint4 mask = (uint4)(7, 6, 3, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[13];
    uint4 mask = (uint4)(5, 11, 4, 4);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[14];
    uint4 mask = (uint4)(8, 11, 9, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[15];
    uint4 mask = (uint4)(9, 2, 0, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[16];
    uint4 mask = (uint4)(3, 12, 6, 4);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[17];
    uint4 mask = (uint4)(3, 2, 7, 11);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[18];
    uint4 mask = (uint4)(13, 9, 12, 14);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[19];
    uint4 mask = (uint4)(5, 14, 7, 6);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[20];
    uint4 mask = (uint4)(7, 14, 12, 11);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[21];
    uint4 mask = (uint4)(11, 6, 1, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[22];
    uint4 mask = (uint4)(0, 11, 8, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[23];
    uint4 mask = (uint4)(0, 4, 11, 12);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[24];
    uint4 mask = (uint4)(8, 2, 7, 12);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[25];
    uint4 mask = (uint4)(5, 3, 10, 6);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[26];
    uint4 mask = (uint4)(13, 3, 13, 7);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[27];
    uint4 mask = (uint4)(2, 2, 9, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[28];
    uint4 mask = (uint4)(6, 7, 6, 15);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[29];
    uint4 mask = (uint4)(3, 7, 12, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[30];
    uint4 mask = (uint4)(10, 5, 14, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float4)((float)0);
  {
    float16 src1 = source[31];
    uint4 mask = (uint4)(3, 5, 4, 5);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
