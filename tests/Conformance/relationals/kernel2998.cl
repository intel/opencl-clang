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
        (uint16)(0, 24, 24, 25, 8, 10, 17, 14, 4, 16, 30, 7, 13, 1, 11, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint16 mask =
        (uint16)(15, 15, 16, 11, 27, 14, 24, 20, 29, 17, 11, 2, 28, 10, 23, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint16 mask =
        (uint16)(17, 18, 22, 14, 13, 25, 28, 22, 5, 4, 19, 21, 26, 13, 18, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint16 mask =
        (uint16)(8, 21, 27, 28, 14, 5, 2, 0, 19, 25, 15, 19, 22, 12, 1, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint16 mask =
        (uint16)(24, 9, 17, 3, 6, 1, 0, 28, 30, 14, 19, 22, 1, 2, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint16 mask =
        (uint16)(29, 15, 16, 28, 10, 15, 2, 17, 7, 28, 18, 26, 8, 29, 29, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint16 mask =
        (uint16)(14, 8, 20, 9, 13, 30, 16, 19, 15, 19, 23, 0, 14, 1, 6, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint16 mask =
        (uint16)(19, 23, 27, 11, 29, 26, 21, 21, 9, 20, 20, 15, 6, 24, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint16 mask =
        (uint16)(12, 25, 19, 11, 8, 24, 16, 3, 21, 25, 18, 24, 23, 29, 29, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint16 mask =
        (uint16)(7, 7, 3, 30, 5, 25, 25, 11, 11, 19, 9, 7, 26, 19, 20, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint16 mask =
        (uint16)(17, 21, 13, 21, 15, 0, 21, 7, 12, 20, 19, 1, 27, 22, 28, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint16 mask =
        (uint16)(6, 1, 4, 21, 18, 8, 2, 17, 4, 0, 15, 21, 5, 9, 9, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint16 mask =
        (uint16)(14, 26, 15, 11, 15, 5, 5, 25, 19, 14, 23, 3, 20, 26, 10, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint16 mask =
        (uint16)(29, 2, 21, 17, 20, 19, 10, 7, 2, 26, 1, 18, 31, 11, 30, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint16 mask =
        (uint16)(10, 28, 12, 13, 29, 2, 10, 2, 16, 29, 9, 6, 12, 30, 18, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint16 mask =
        (uint16)(1, 14, 5, 19, 29, 18, 2, 22, 20, 16, 9, 21, 3, 13, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint16 mask =
        (uint16)(11, 13, 28, 10, 15, 12, 8, 8, 24, 4, 14, 6, 24, 16, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint16 mask =
        (uint16)(20, 3, 12, 11, 20, 11, 16, 23, 18, 19, 23, 24, 20, 6, 20, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint16 mask =
        (uint16)(4, 0, 30, 17, 16, 28, 9, 10, 11, 23, 4, 4, 15, 25, 29, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint16 mask =
        (uint16)(25, 30, 25, 5, 20, 7, 29, 31, 2, 0, 28, 22, 1, 0, 27, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint16 mask =
        (uint16)(15, 28, 18, 3, 31, 5, 29, 0, 6, 21, 18, 25, 19, 25, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint16 mask =
        (uint16)(8, 29, 28, 19, 15, 14, 1, 17, 26, 30, 15, 28, 26, 11, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint16 mask =
        (uint16)(13, 18, 13, 5, 4, 26, 19, 12, 20, 18, 31, 6, 24, 26, 31, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint16 mask =
        (uint16)(13, 4, 21, 0, 24, 15, 0, 2, 20, 29, 15, 18, 8, 15, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint16 mask =
        (uint16)(12, 4, 31, 1, 6, 26, 5, 14, 14, 20, 20, 12, 8, 29, 23, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint16 mask =
        (uint16)(0, 21, 28, 9, 2, 0, 25, 11, 12, 9, 9, 14, 0, 26, 23, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint16 mask =
        (uint16)(28, 19, 7, 23, 24, 24, 0, 30, 15, 22, 12, 5, 13, 8, 19, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint16 mask =
        (uint16)(23, 7, 1, 2, 15, 2, 18, 27, 30, 16, 27, 4, 27, 31, 4, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint16 mask =
        (uint16)(18, 15, 14, 0, 6, 3, 17, 3, 1, 13, 27, 14, 9, 1, 25, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint16 mask =
        (uint16)(23, 12, 27, 3, 6, 16, 0, 1, 5, 21, 0, 2, 12, 7, 25, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint16 mask =
        (uint16)(22, 14, 19, 20, 5, 8, 26, 13, 15, 9, 22, 28, 30, 21, 19, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint16 mask =
        (uint16)(8, 19, 8, 8, 25, 11, 19, 13, 14, 21, 21, 25, 27, 28, 27, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
