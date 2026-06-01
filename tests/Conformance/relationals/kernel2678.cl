// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 /*, src2*/;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float16 src1 = source[0];
    uint16 mask = (uint16)(0, 12, 12, 12, 4, 5, 8, 7, 2, 8, 15, 3, 6, 0, 5, 12);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[1];
    uint16 mask =
        (uint16)(7, 7, 8, 5, 13, 7, 12, 10, 14, 8, 5, 1, 14, 5, 11, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[2];
    uint16 mask =
        (uint16)(8, 9, 11, 7, 6, 12, 14, 11, 2, 2, 9, 10, 13, 6, 9, 9);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[3];
    uint16 mask = (uint16)(4, 10, 13, 14, 7, 2, 1, 0, 9, 12, 7, 9, 11, 6, 0, 9);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[4];
    uint16 mask = (uint16)(12, 4, 8, 1, 3, 0, 0, 14, 15, 7, 9, 11, 0, 1, 5, 7);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[5];
    uint16 mask =
        (uint16)(14, 7, 8, 14, 5, 7, 1, 8, 3, 14, 9, 13, 4, 14, 14, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[6];
    uint16 mask = (uint16)(7, 4, 10, 4, 6, 15, 8, 9, 7, 9, 11, 0, 7, 0, 3, 15);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[7];
    uint16 mask =
        (uint16)(9, 11, 13, 5, 14, 13, 10, 10, 4, 10, 10, 7, 3, 12, 7, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[8];
    uint16 mask =
        (uint16)(6, 12, 9, 5, 4, 12, 8, 1, 10, 12, 9, 12, 11, 14, 14, 10);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[9];
    uint16 mask =
        (uint16)(3, 3, 1, 15, 2, 12, 12, 5, 5, 9, 4, 3, 13, 9, 10, 10);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[10];
    uint16 mask =
        (uint16)(8, 10, 6, 10, 7, 0, 10, 3, 6, 10, 9, 0, 13, 11, 14, 13);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[11];
    uint16 mask = (uint16)(3, 0, 2, 10, 9, 4, 1, 8, 2, 0, 7, 10, 2, 4, 4, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[12];
    uint16 mask =
        (uint16)(7, 13, 7, 5, 7, 2, 2, 12, 9, 7, 11, 1, 10, 13, 5, 10);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[13];
    uint16 mask =
        (uint16)(14, 1, 10, 8, 10, 9, 5, 3, 1, 13, 0, 9, 15, 5, 15, 4);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[14];
    uint16 mask = (uint16)(5, 14, 6, 6, 14, 1, 5, 1, 8, 14, 4, 3, 6, 15, 9, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[15];
    uint16 mask = (uint16)(0, 7, 2, 9, 14, 9, 1, 11, 10, 8, 4, 10, 1, 6, 3, 0);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[16];
    uint16 mask = (uint16)(5, 6, 14, 5, 7, 6, 4, 4, 12, 2, 7, 3, 12, 8, 1, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[17];
    uint16 mask =
        (uint16)(10, 1, 6, 5, 10, 5, 8, 11, 9, 9, 11, 12, 10, 3, 10, 14);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[18];
    uint16 mask = (uint16)(2, 0, 15, 8, 8, 14, 4, 5, 5, 11, 2, 2, 7, 12, 14, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[19];
    uint16 mask =
        (uint16)(12, 15, 12, 2, 10, 3, 14, 15, 1, 0, 14, 11, 0, 0, 13, 12);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[20];
    uint16 mask =
        (uint16)(7, 14, 9, 1, 15, 2, 14, 0, 3, 10, 9, 12, 9, 12, 6, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[21];
    uint16 mask =
        (uint16)(4, 14, 14, 9, 7, 7, 0, 8, 13, 15, 7, 14, 13, 5, 2, 3);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[22];
    uint16 mask =
        (uint16)(6, 9, 6, 2, 2, 13, 9, 6, 10, 9, 15, 3, 12, 13, 15, 9);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[23];
    uint16 mask = (uint16)(6, 2, 10, 0, 12, 7, 0, 1, 10, 14, 7, 9, 4, 7, 4, 2);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[24];
    uint16 mask =
        (uint16)(6, 2, 15, 0, 3, 13, 2, 7, 7, 10, 10, 6, 4, 14, 11, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[25];
    uint16 mask = (uint16)(0, 10, 14, 4, 1, 0, 12, 5, 6, 4, 4, 7, 0, 13, 11, 3);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[26];
    uint16 mask =
        (uint16)(14, 9, 3, 11, 12, 12, 0, 15, 7, 11, 6, 2, 6, 4, 9, 15);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[27];
    uint16 mask =
        (uint16)(11, 3, 0, 1, 7, 1, 9, 13, 15, 8, 13, 2, 13, 15, 2, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[28];
    uint16 mask = (uint16)(9, 7, 7, 0, 3, 1, 8, 1, 0, 6, 13, 7, 4, 0, 12, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[29];
    uint16 mask = (uint16)(11, 6, 13, 1, 3, 8, 0, 0, 2, 10, 0, 1, 6, 3, 12, 11);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[30];
    uint16 mask =
        (uint16)(11, 7, 9, 10, 2, 4, 13, 6, 7, 4, 11, 14, 15, 10, 9, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[31];
    uint16 mask =
        (uint16)(4, 9, 4, 4, 12, 5, 9, 6, 7, 10, 10, 12, 13, 14, 13, 0);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
