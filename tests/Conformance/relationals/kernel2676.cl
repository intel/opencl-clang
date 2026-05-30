// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *source, __global float8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 /*, src2*/;
  float8 tmp;
  tmp = (float8)((float)0);
  {
    float16 src1 = source[0];
    uint8 mask = (uint8)(3, 3, 1, 11, 1, 12, 14, 11);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[1];
    uint8 mask = (uint8)(1, 12, 13, 1, 12, 1, 15, 12);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[2];
    uint8 mask = (uint8)(0, 9, 11, 12, 13, 7, 8, 10);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[3];
    uint8 mask = (uint8)(11, 5, 12, 5, 5, 3, 15, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[4];
    uint8 mask = (uint8)(14, 13, 4, 14, 7, 8, 2, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[5];
    uint8 mask = (uint8)(4, 11, 3, 5, 12, 13, 12, 8);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[6];
    uint8 mask = (uint8)(1, 7, 4, 1, 15, 15, 15, 14);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[7];
    uint8 mask = (uint8)(9, 6, 14, 7, 2, 4, 15, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[8];
    uint8 mask = (uint8)(2, 14, 10, 3, 7, 11, 12, 6);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[9];
    uint8 mask = (uint8)(3, 6, 9, 7, 6, 9, 6, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[10];
    uint8 mask = (uint8)(8, 1, 4, 2, 14, 3, 15, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[11];
    uint8 mask = (uint8)(9, 12, 9, 10, 14, 13, 6, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[12];
    uint8 mask = (uint8)(4, 11, 2, 6, 11, 5, 13, 4);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[13];
    uint8 mask = (uint8)(9, 11, 3, 8, 5, 5, 14, 15);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[14];
    uint8 mask = (uint8)(4, 0, 8, 6, 15, 0, 14, 14);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[15];
    uint8 mask = (uint8)(6, 11, 5, 15, 7, 2, 0, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[16];
    uint8 mask = (uint8)(6, 7, 10, 13, 5, 1, 13, 9);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[17];
    uint8 mask = (uint8)(0, 10, 10, 2, 5, 10, 12, 8);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[18];
    uint8 mask = (uint8)(2, 6, 1, 4, 13, 4, 4, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[19];
    uint8 mask = (uint8)(5, 10, 13, 2, 14, 0, 4, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[20];
    uint8 mask = (uint8)(5, 13, 1, 6, 5, 6, 4, 8);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[21];
    uint8 mask = (uint8)(2, 9, 6, 1, 4, 4, 9, 6);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[22];
    uint8 mask = (uint8)(13, 1, 6, 2, 5, 10, 6, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[23];
    uint8 mask = (uint8)(1, 10, 12, 14, 2, 12, 4, 2);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[24];
    uint8 mask = (uint8)(6, 14, 12, 13, 14, 14, 1, 12);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[25];
    uint8 mask = (uint8)(13, 0, 12, 6, 4, 13, 8, 3);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[26];
    uint8 mask = (uint8)(13, 9, 15, 13, 11, 2, 7, 15);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[27];
    uint8 mask = (uint8)(15, 3, 1, 14, 8, 15, 15, 6);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[28];
    uint8 mask = (uint8)(7, 9, 1, 3, 4, 6, 5, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[29];
    uint8 mask = (uint8)(1, 8, 1, 8, 13, 5, 15, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[30];
    uint8 mask = (uint8)(3, 13, 8, 3, 2, 3, 5, 12);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[31];
    uint8 mask = (uint8)(0, 15, 11, 4, 10, 1, 5, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
