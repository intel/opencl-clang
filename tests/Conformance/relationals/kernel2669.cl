// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float8 *source, __global float8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float8 src1 /*, src2*/;
  float8 tmp;
  tmp = (float8)((float)0);
  {
    float8 src1 = source[0];
    uint8 mask = (uint8)(1, 0, 2, 0, 4, 0, 4, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[1];
    uint8 mask = (uint8)(1, 6, 3, 7, 2, 7, 7, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[2];
    uint8 mask = (uint8)(2, 0, 5, 4, 7, 5, 2, 7);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[3];
    uint8 mask = (uint8)(1, 3, 4, 6, 6, 1, 5, 5);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[4];
    uint8 mask = (uint8)(1, 6, 3, 5, 6, 3, 1, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[5];
    uint8 mask = (uint8)(7, 5, 7, 3, 3, 3, 5, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[6];
    uint8 mask = (uint8)(0, 2, 5, 2, 5, 2, 0, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[7];
    uint8 mask = (uint8)(4, 0, 0, 2, 3, 1, 1, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[8];
    uint8 mask = (uint8)(5, 2, 0, 0, 5, 3, 2, 6);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[9];
    uint8 mask = (uint8)(0, 3, 5, 7, 5, 6, 7, 0);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[10];
    uint8 mask = (uint8)(7, 4, 1, 6, 6, 6, 2, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[11];
    uint8 mask = (uint8)(6, 2, 0, 3, 1, 1, 4, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[12];
    uint8 mask = (uint8)(5, 1, 4, 5, 5, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[13];
    uint8 mask = (uint8)(1, 2, 2, 4, 2, 3, 4, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[14];
    uint8 mask = (uint8)(5, 6, 2, 5, 3, 6, 0, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[15];
    uint8 mask = (uint8)(6, 5, 3, 7, 4, 3, 2, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[16];
    uint8 mask = (uint8)(2, 4, 2, 4, 7, 2, 0, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[17];
    uint8 mask = (uint8)(0, 0, 4, 2, 3, 1, 4, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[18];
    uint8 mask = (uint8)(1, 3, 4, 0, 5, 2, 6, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[19];
    uint8 mask = (uint8)(4, 3, 5, 2, 2, 7, 1, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[20];
    uint8 mask = (uint8)(3, 0, 6, 5, 4, 5, 3, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[21];
    uint8 mask = (uint8)(3, 7, 6, 5, 5, 7, 7, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[22];
    uint8 mask = (uint8)(5, 7, 4, 5, 7, 3, 0, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[23];
    uint8 mask = (uint8)(5, 3, 0, 2, 2, 7, 2, 0);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[24];
    uint8 mask = (uint8)(7, 3, 1, 7, 5, 3, 7, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[25];
    uint8 mask = (uint8)(1, 1, 1, 2, 4, 2, 3, 4);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[26];
    uint8 mask = (uint8)(4, 2, 6, 7, 6, 5, 5, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[27];
    uint8 mask = (uint8)(1, 0, 0, 3, 2, 6, 0, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[28];
    uint8 mask = (uint8)(3, 6, 2, 3, 6, 7, 6, 6);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[29];
    uint8 mask = (uint8)(7, 4, 7, 4, 0, 0, 3, 2);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[30];
    uint8 mask = (uint8)(7, 0, 2, 0, 3, 7, 6, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[31];
    uint8 mask = (uint8)(5, 1, 6, 0, 2, 3, 0, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
