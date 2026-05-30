// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *secondSource,
                          __global float16 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 , src2;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float16 src1 = source[0];
    float16 src2 = secondSource[0];
    uint16 mask =
        (uint16)(6, 26, 28, 26, 1, 1, 26, 7, 27, 13, 2, 21, 22, 15, 21, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint16 mask =
        (uint16)(18, 26, 7, 20, 27, 22, 8, 25, 13, 26, 31, 1, 0, 29, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint16 mask =
        (uint16)(24, 17, 7, 1, 12, 28, 0, 18, 16, 13, 31, 28, 31, 13, 24, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint16 mask =
        (uint16)(24, 7, 21, 3, 4, 29, 15, 10, 17, 6, 18, 22, 13, 3, 25, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint16 mask =
        (uint16)(10, 22, 26, 31, 0, 27, 14, 18, 5, 10, 7, 27, 15, 24, 24, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint16 mask =
        (uint16)(0, 9, 21, 5, 10, 26, 1, 31, 9, 12, 4, 1, 18, 14, 5, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint16 mask =
        (uint16)(14, 27, 23, 19, 24, 8, 26, 1, 31, 9, 30, 1, 30, 20, 30, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint16 mask =
        (uint16)(15, 19, 31, 3, 20, 8, 20, 29, 14, 14, 4, 10, 13, 19, 29, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint16 mask =
        (uint16)(15, 18, 29, 17, 16, 21, 16, 8, 26, 28, 14, 16, 18, 28, 0, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint16 mask =
        (uint16)(20, 27, 25, 0, 1, 14, 14, 30, 16, 16, 13, 4, 18, 6, 18, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint16 mask =
        (uint16)(19, 9, 4, 22, 24, 27, 12, 26, 29, 23, 24, 27, 4, 23, 16, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint16 mask =
        (uint16)(0, 6, 29, 22, 18, 0, 20, 19, 6, 21, 9, 22, 17, 29, 9, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint16 mask =
        (uint16)(12, 25, 31, 19, 0, 13, 20, 18, 25, 23, 23, 7, 0, 16, 18, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint16 mask =
        (uint16)(1, 22, 17, 5, 26, 13, 15, 13, 1, 21, 21, 24, 15, 1, 29, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint16 mask =
        (uint16)(15, 29, 13, 7, 13, 7, 19, 22, 19, 17, 16, 26, 31, 27, 19, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint16 mask =
        (uint16)(21, 16, 18, 27, 13, 2, 10, 3, 28, 22, 10, 21, 12, 21, 2, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint16 mask =
        (uint16)(24, 6, 7, 17, 21, 13, 30, 18, 22, 10, 14, 12, 8, 27, 16, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint16 mask =
        (uint16)(16, 20, 19, 21, 18, 31, 10, 24, 19, 13, 20, 15, 12, 19, 29, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint16 mask =
        (uint16)(2, 15, 7, 6, 7, 1, 18, 12, 27, 12, 11, 23, 5, 18, 31, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint16 mask =
        (uint16)(0, 13, 30, 17, 24, 13, 23, 23, 0, 30, 20, 21, 11, 30, 4, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint16 mask =
        (uint16)(17, 8, 18, 10, 15, 5, 12, 20, 18, 25, 0, 2, 13, 18, 1, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint16 mask =
        (uint16)(25, 10, 5, 0, 25, 28, 0, 14, 24, 25, 30, 2, 8, 26, 11, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint16 mask =
        (uint16)(19, 29, 25, 4, 9, 12, 29, 26, 7, 16, 1, 29, 30, 22, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint16 mask =
        (uint16)(1, 5, 9, 15, 16, 26, 10, 15, 12, 22, 0, 27, 26, 13, 23, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint16 mask =
        (uint16)(6, 9, 20, 5, 15, 13, 31, 31, 4, 19, 7, 14, 24, 5, 25, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint16 mask =
        (uint16)(20, 10, 7, 13, 17, 2, 2, 29, 25, 28, 30, 0, 3, 31, 23, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint16 mask =
        (uint16)(2, 9, 26, 4, 28, 29, 0, 0, 14, 19, 4, 30, 25, 29, 22, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint16 mask =
        (uint16)(27, 15, 25, 19, 17, 18, 3, 25, 26, 29, 15, 30, 14, 12, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint16 mask =
        (uint16)(20, 29, 6, 20, 22, 2, 12, 13, 21, 28, 29, 6, 20, 23, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint16 mask =
        (uint16)(24, 3, 24, 5, 3, 26, 6, 1, 2, 7, 2, 29, 20, 26, 30, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint16 mask = (uint16)(17, 7, 9, 15, 7, 2, 6, 0, 6, 19, 0, 28, 1, 16, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint16 mask =
        (uint16)(13, 5, 18, 0, 18, 21, 11, 27, 7, 28, 4, 28, 30, 12, 27, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
