// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *source, __global float8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 /*, src2*/;
  float8 tmp;
  tmp = (float8)((float)0);
  {
    float16 src1 = source[0];
    uint8 mask = (uint8)(12, 0, 5, 13, 8, 9, 1, 15);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[1];
    uint8 mask = (uint8)(3, 11, 8, 2, 5, 0, 3, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[2];
    uint8 mask = (uint8)(10, 2, 9, 9, 11, 1, 13, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[3];
    uint8 mask = (uint8)(13, 11, 7, 2, 12, 6, 4, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[4];
    uint8 mask = (uint8)(1, 11, 4, 4, 13, 1, 14, 12);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[5];
    uint8 mask = (uint8)(4, 11, 0, 6, 5, 13, 12, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[6];
    uint8 mask = (uint8)(2, 11, 10, 0, 5, 11, 6, 7);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[7];
    uint8 mask = (uint8)(8, 15, 0, 1, 13, 4, 10, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[8];
    uint8 mask = (uint8)(2, 7, 0, 6, 12, 4, 8, 8);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[9];
    uint8 mask = (uint8)(0, 1, 2, 9, 9, 10, 6, 8);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[10];
    uint8 mask = (uint8)(13, 0, 15, 2, 4, 4, 0, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[11];
    uint8 mask = (uint8)(7, 6, 1, 9, 4, 15, 12, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[12];
    uint8 mask = (uint8)(11, 0, 11, 1, 0, 3, 7, 8);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[13];
    uint8 mask = (uint8)(2, 13, 14, 6, 12, 5, 1, 12);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[14];
    uint8 mask = (uint8)(11, 8, 9, 12, 4, 2, 12, 10);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[15];
    uint8 mask = (uint8)(15, 12, 0, 5, 7, 6, 6, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[16];
    uint8 mask = (uint8)(15, 9, 8, 4, 6, 0, 0, 4);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[17];
    uint8 mask = (uint8)(4, 0, 1, 14, 9, 12, 11, 14);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[18];
    uint8 mask = (uint8)(9, 5, 14, 7, 9, 10, 6, 7);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[19];
    uint8 mask = (uint8)(4, 4, 5, 12, 3, 0, 12, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[20];
    uint8 mask = (uint8)(2, 6, 2, 14, 1, 0, 5, 12);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[21];
    uint8 mask = (uint8)(5, 7, 9, 14, 11, 1, 9, 12);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[22];
    uint8 mask = (uint8)(9, 13, 14, 3, 5, 5, 15, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[23];
    uint8 mask = (uint8)(2, 12, 0, 12, 10, 11, 2, 9);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[24];
    uint8 mask = (uint8)(11, 0, 9, 13, 3, 3, 6, 10);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[25];
    uint8 mask = (uint8)(8, 9, 6, 4, 15, 5, 14, 3);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[26];
    uint8 mask = (uint8)(10, 5, 4, 15, 0, 12, 15, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[27];
    uint8 mask = (uint8)(15, 4, 5, 9, 14, 4, 8, 14);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[28];
    uint8 mask = (uint8)(13, 0, 15, 15, 5, 2, 12, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[29];
    uint8 mask = (uint8)(11, 6, 10, 4, 2, 11, 15, 11);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[30];
    uint8 mask = (uint8)(5, 2, 13, 10, 9, 8, 2, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[31];
    uint8 mask = (uint8)(6, 4, 0, 3, 13, 9, 1, 7);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
