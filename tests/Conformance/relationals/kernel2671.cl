// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float8 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float8 src1 /*, src2*/;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float8 src1 = source[0];
    uint16 mask = (uint16)(0, 7, 6, 0, 5, 2, 2, 7, 3, 5, 5, 5, 5, 3, 5, 3);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[1];
    uint16 mask = (uint16)(3, 7, 6, 3, 7, 4, 2, 4, 6, 1, 5, 4, 3, 4, 7, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[2];
    uint16 mask = (uint16)(5, 1, 0, 2, 5, 6, 4, 2, 5, 5, 0, 2, 2, 4, 3, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[3];
    uint16 mask = (uint16)(2, 4, 5, 4, 7, 1, 2, 2, 0, 2, 6, 0, 2, 1, 5, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[4];
    uint16 mask = (uint16)(2, 0, 5, 7, 2, 3, 6, 7, 7, 0, 6, 0, 7, 4, 2, 7);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[5];
    uint16 mask = (uint16)(0, 6, 7, 0, 7, 4, 4, 3, 3, 1, 5, 5, 0, 0, 2, 6);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[6];
    uint16 mask = (uint16)(5, 4, 7, 6, 6, 5, 0, 5, 0, 4, 3, 7, 3, 3, 3, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[7];
    uint16 mask = (uint16)(4, 2, 1, 6, 5, 6, 2, 0, 1, 2, 0, 2, 1, 6, 0, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[8];
    uint16 mask = (uint16)(5, 1, 2, 5, 0, 3, 6, 1, 3, 6, 5, 2, 7, 2, 2, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[9];
    uint16 mask = (uint16)(1, 2, 5, 2, 5, 2, 2, 0, 6, 0, 0, 3, 1, 0, 2, 6);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[10];
    uint16 mask = (uint16)(3, 5, 3, 5, 0, 1, 2, 4, 4, 4, 6, 2, 4, 6, 6, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[11];
    uint16 mask = (uint16)(1, 3, 1, 2, 5, 6, 0, 5, 4, 5, 2, 7, 3, 2, 2, 2);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[12];
    uint16 mask = (uint16)(2, 5, 0, 7, 0, 5, 1, 5, 4, 5, 3, 2, 1, 2, 7, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[13];
    uint16 mask = (uint16)(6, 7, 2, 6, 4, 2, 0, 2, 4, 5, 2, 4, 7, 3, 2, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[14];
    uint16 mask = (uint16)(0, 5, 0, 4, 6, 4, 4, 0, 1, 6, 4, 1, 6, 7, 7, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[15];
    uint16 mask = (uint16)(1, 3, 3, 6, 6, 2, 4, 5, 5, 6, 6, 4, 1, 2, 3, 7);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[16];
    uint16 mask = (uint16)(1, 0, 4, 7, 6, 1, 1, 2, 7, 6, 1, 2, 5, 5, 4, 4);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[17];
    uint16 mask = (uint16)(4, 7, 1, 7, 5, 2, 7, 5, 0, 6, 7, 3, 4, 3, 2, 7);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[18];
    uint16 mask = (uint16)(5, 3, 5, 4, 3, 2, 7, 6, 1, 4, 3, 0, 4, 1, 0, 7);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[19];
    uint16 mask = (uint16)(3, 6, 6, 1, 2, 3, 1, 4, 5, 0, 1, 3, 4, 3, 3, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[20];
    uint16 mask = (uint16)(1, 0, 5, 3, 5, 1, 1, 2, 3, 5, 7, 6, 6, 5, 4, 5);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[21];
    uint16 mask = (uint16)(0, 5, 0, 2, 0, 5, 6, 1, 5, 3, 0, 4, 2, 4, 1, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[22];
    uint16 mask = (uint16)(0, 1, 2, 3, 5, 4, 6, 1, 5, 1, 2, 2, 7, 4, 6, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[23];
    uint16 mask = (uint16)(6, 2, 2, 5, 5, 4, 0, 1, 2, 3, 0, 1, 7, 6, 7, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[24];
    uint16 mask = (uint16)(4, 6, 7, 0, 4, 0, 7, 2, 4, 5, 3, 0, 4, 3, 2, 5);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[25];
    uint16 mask = (uint16)(0, 4, 0, 2, 4, 1, 0, 6, 4, 3, 7, 3, 6, 4, 3, 3);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[26];
    uint16 mask = (uint16)(1, 1, 5, 0, 1, 1, 7, 2, 2, 5, 5, 4, 3, 7, 4, 2);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[27];
    uint16 mask = (uint16)(0, 7, 6, 0, 3, 6, 1, 3, 1, 5, 7, 2, 0, 5, 6, 7);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[28];
    uint16 mask = (uint16)(3, 4, 3, 5, 1, 6, 0, 1, 4, 0, 0, 2, 5, 2, 3, 5);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[29];
    uint16 mask = (uint16)(0, 7, 1, 1, 3, 3, 4, 0, 0, 5, 4, 6, 5, 5, 2, 4);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[30];
    uint16 mask = (uint16)(4, 3, 6, 4, 2, 0, 6, 1, 1, 2, 7, 3, 3, 1, 0, 7);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[31];
    uint16 mask = (uint16)(6, 2, 5, 6, 0, 5, 7, 6, 3, 4, 6, 7, 2, 7, 7, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
