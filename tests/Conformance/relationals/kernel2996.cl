// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float16 *secondSource,
                          __global float16 *source, __global float8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float16 src1 , src2;
  float8 tmp;
  tmp = (float8)((float)0);
  {
    float16 src1 = source[0];
    float16 src2 = secondSource[0];
    uint8 mask = (uint8)(7, 6, 3, 22, 2, 25, 29, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint8 mask = (uint8)(2, 25, 27, 2, 24, 2, 30, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint8 mask = (uint8)(0, 18, 22, 25, 27, 15, 17, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint8 mask = (uint8)(22, 10, 25, 11, 11, 6, 31, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint8 mask = (uint8)(29, 26, 9, 29, 14, 16, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint8 mask = (uint8)(9, 22, 6, 11, 25, 27, 25, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint8 mask = (uint8)(3, 14, 9, 3, 30, 31, 30, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint8 mask = (uint8)(18, 13, 28, 14, 5, 8, 30, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint8 mask = (uint8)(4, 28, 21, 7, 14, 23, 25, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint8 mask = (uint8)(6, 12, 19, 15, 13, 18, 13, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint8 mask = (uint8)(17, 2, 9, 5, 29, 6, 31, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint8 mask = (uint8)(19, 24, 18, 21, 28, 27, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint8 mask = (uint8)(9, 22, 4, 13, 23, 10, 26, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint8 mask = (uint8)(18, 23, 7, 16, 10, 11, 29, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint8 mask = (uint8)(9, 1, 17, 12, 30, 1, 28, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint8 mask = (uint8)(13, 22, 11, 31, 14, 5, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint8 mask = (uint8)(12, 14, 21, 26, 11, 2, 27, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint8 mask = (uint8)(1, 20, 21, 4, 11, 20, 25, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint8 mask = (uint8)(5, 13, 3, 9, 26, 9, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint8 mask = (uint8)(10, 21, 26, 4, 28, 0, 8, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint8 mask = (uint8)(10, 26, 2, 13, 10, 12, 8, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint8 mask = (uint8)(4, 19, 12, 3, 8, 9, 18, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint8 mask = (uint8)(27, 3, 13, 4, 10, 21, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint8 mask = (uint8)(2, 21, 24, 28, 4, 25, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint8 mask = (uint8)(12, 29, 25, 26, 29, 28, 3, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint8 mask = (uint8)(27, 0, 24, 12, 8, 27, 16, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint8 mask = (uint8)(27, 18, 30, 26, 22, 4, 15, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint8 mask = (uint8)(30, 7, 3, 29, 16, 31, 30, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint8 mask = (uint8)(15, 19, 3, 6, 9, 12, 11, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint8 mask = (uint8)(3, 16, 2, 17, 27, 10, 30, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint8 mask = (uint8)(7, 27, 16, 7, 5, 7, 11, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint8 mask = (uint8)(0, 30, 23, 8, 20, 2, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
