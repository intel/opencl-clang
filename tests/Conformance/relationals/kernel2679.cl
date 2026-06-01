// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 /*, src2*/;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float16 src1 = source[0];
    uint16 mask =
        (uint16)(3, 13, 14, 13, 0, 0, 13, 3, 13, 6, 1, 10, 11, 7, 10, 9);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[1];
    uint16 mask =
        (uint16)(9, 13, 3, 10, 13, 11, 4, 12, 6, 13, 15, 0, 0, 14, 2, 7);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[2];
    uint16 mask =
        (uint16)(12, 8, 3, 0, 6, 14, 0, 9, 8, 6, 15, 14, 15, 6, 12, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[3];
    uint16 mask = (uint16)(12, 3, 10, 1, 2, 14, 7, 5, 8, 3, 9, 11, 6, 1, 12, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[4];
    uint16 mask =
        (uint16)(5, 11, 13, 15, 0, 13, 7, 9, 2, 5, 3, 13, 7, 12, 12, 13);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[5];
    uint16 mask = (uint16)(0, 4, 10, 2, 5, 13, 0, 15, 4, 6, 2, 0, 9, 7, 2, 15);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[6];
    uint16 mask =
        (uint16)(7, 13, 11, 9, 12, 4, 13, 0, 15, 4, 15, 0, 15, 10, 15, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[7];
    uint16 mask =
        (uint16)(7, 9, 15, 1, 10, 4, 10, 14, 7, 7, 2, 5, 6, 9, 14, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[8];
    uint16 mask =
        (uint16)(7, 9, 14, 8, 8, 10, 8, 4, 13, 14, 7, 8, 9, 14, 0, 13);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[9];
    uint16 mask = (uint16)(10, 13, 12, 0, 0, 7, 7, 15, 8, 8, 6, 2, 9, 3, 9, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[10];
    uint16 mask =
        (uint16)(9, 4, 2, 11, 12, 13, 6, 13, 14, 11, 12, 13, 2, 11, 8, 7);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[11];
    uint16 mask =
        (uint16)(0, 3, 14, 11, 9, 0, 10, 9, 3, 10, 4, 11, 8, 14, 4, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[12];
    uint16 mask =
        (uint16)(6, 12, 15, 9, 0, 6, 10, 9, 12, 11, 11, 3, 0, 8, 9, 7);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[13];
    uint16 mask =
        (uint16)(0, 11, 8, 2, 13, 6, 7, 6, 0, 10, 10, 12, 7, 0, 14, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[14];
    uint16 mask = (uint16)(7, 14, 6, 3, 6, 3, 9, 11, 9, 8, 8, 13, 15, 13, 9, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[15];
    uint16 mask =
        (uint16)(10, 8, 9, 13, 6, 1, 5, 1, 14, 11, 5, 10, 6, 10, 1, 8);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[16];
    uint16 mask = (uint16)(12, 3, 3, 8, 10, 6, 15, 9, 11, 5, 7, 6, 4, 13, 8, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[17];
    uint16 mask =
        (uint16)(8, 10, 9, 10, 9, 15, 5, 12, 9, 6, 10, 7, 6, 9, 14, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[18];
    uint16 mask = (uint16)(1, 7, 3, 3, 3, 0, 9, 6, 13, 6, 5, 11, 2, 9, 15, 14);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[19];
    uint16 mask =
        (uint16)(0, 6, 15, 8, 12, 6, 11, 11, 0, 15, 10, 10, 5, 15, 2, 14);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[20];
    uint16 mask = (uint16)(8, 4, 9, 5, 7, 2, 6, 10, 9, 12, 0, 1, 6, 9, 0, 12);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[21];
    uint16 mask =
        (uint16)(12, 5, 2, 0, 12, 14, 0, 7, 12, 12, 15, 1, 4, 13, 5, 9);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[22];
    uint16 mask =
        (uint16)(9, 14, 12, 2, 4, 6, 14, 13, 3, 8, 0, 14, 15, 11, 1, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[23];
    uint16 mask =
        (uint16)(0, 2, 4, 7, 8, 13, 5, 7, 6, 11, 0, 13, 13, 6, 11, 12);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[24];
    uint16 mask = (uint16)(3, 4, 10, 2, 7, 6, 15, 15, 2, 9, 3, 7, 12, 2, 12, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[25];
    uint16 mask =
        (uint16)(10, 5, 3, 6, 8, 1, 1, 14, 12, 14, 15, 0, 1, 15, 11, 7);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[26];
    uint16 mask =
        (uint16)(1, 4, 13, 2, 14, 14, 0, 0, 7, 9, 2, 15, 12, 14, 11, 5);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[27];
    uint16 mask =
        (uint16)(13, 7, 12, 9, 8, 9, 1, 12, 13, 14, 7, 15, 7, 6, 7, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[28];
    uint16 mask =
        (uint16)(10, 14, 3, 10, 11, 1, 6, 6, 10, 14, 14, 3, 10, 11, 3, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[29];
    uint16 mask =
        (uint16)(12, 1, 12, 2, 1, 13, 3, 0, 1, 3, 1, 14, 10, 13, 15, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[30];
    uint16 mask = (uint16)(8, 3, 4, 7, 3, 1, 3, 0, 3, 9, 0, 14, 0, 8, 1, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[31];
    uint16 mask =
        (uint16)(6, 2, 9, 0, 9, 10, 5, 13, 3, 14, 2, 14, 15, 6, 13, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
