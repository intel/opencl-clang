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
    uint8 mask = (uint8)(25, 0, 10, 26, 16, 19, 2, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[1];
    float16 src2 = secondSource[1];
    uint8 mask = (uint8)(7, 22, 16, 5, 11, 0, 7, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[2];
    float16 src2 = secondSource[2];
    uint8 mask = (uint8)(21, 5, 18, 18, 23, 3, 27, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[3];
    float16 src2 = secondSource[3];
    uint8 mask = (uint8)(27, 22, 15, 4, 25, 12, 9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[4];
    float16 src2 = secondSource[4];
    uint8 mask = (uint8)(2, 22, 9, 9, 27, 3, 29, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[5];
    float16 src2 = secondSource[5];
    uint8 mask = (uint8)(9, 22, 1, 12, 10, 26, 24, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[6];
    float16 src2 = secondSource[6];
    uint8 mask = (uint8)(5, 22, 21, 0, 10, 23, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[7];
    float16 src2 = secondSource[7];
    uint8 mask = (uint8)(17, 30, 1, 3, 26, 8, 20, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[8];
    float16 src2 = secondSource[8];
    uint8 mask = (uint8)(5, 15, 0, 12, 25, 8, 16, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[9];
    float16 src2 = secondSource[9];
    uint8 mask = (uint8)(1, 2, 5, 19, 19, 20, 13, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[10];
    float16 src2 = secondSource[10];
    uint8 mask = (uint8)(27, 0, 30, 4, 9, 8, 0, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[11];
    float16 src2 = secondSource[11];
    uint8 mask = (uint8)(15, 12, 2, 19, 8, 30, 25, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[12];
    float16 src2 = secondSource[12];
    uint8 mask = (uint8)(23, 1, 23, 2, 0, 7, 14, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[13];
    float16 src2 = secondSource[13];
    uint8 mask = (uint8)(5, 27, 28, 12, 25, 10, 2, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[14];
    float16 src2 = secondSource[14];
    uint8 mask = (uint8)(22, 17, 18, 24, 8, 5, 25, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[15];
    float16 src2 = secondSource[15];
    uint8 mask = (uint8)(30, 24, 1, 11, 15, 13, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[16];
    float16 src2 = secondSource[16];
    uint8 mask = (uint8)(30, 18, 17, 8, 13, 0, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[17];
    float16 src2 = secondSource[17];
    uint8 mask = (uint8)(9, 0, 2, 29, 19, 24, 23, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[18];
    float16 src2 = secondSource[18];
    uint8 mask = (uint8)(18, 10, 29, 14, 18, 21, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[19];
    float16 src2 = secondSource[19];
    uint8 mask = (uint8)(9, 9, 10, 25, 7, 1, 24, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[20];
    float16 src2 = secondSource[20];
    uint8 mask = (uint8)(5, 13, 5, 28, 2, 1, 10, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[21];
    float16 src2 = secondSource[21];
    uint8 mask = (uint8)(11, 15, 18, 29, 23, 3, 18, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[22];
    float16 src2 = secondSource[22];
    uint8 mask = (uint8)(18, 27, 28, 6, 11, 10, 30, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[23];
    float16 src2 = secondSource[23];
    uint8 mask = (uint8)(5, 25, 1, 24, 21, 22, 4, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[24];
    float16 src2 = secondSource[24];
    uint8 mask = (uint8)(22, 1, 18, 26, 6, 6, 12, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[25];
    float16 src2 = secondSource[25];
    uint8 mask = (uint8)(16, 18, 12, 9, 30, 10, 28, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[26];
    float16 src2 = secondSource[26];
    uint8 mask = (uint8)(21, 10, 8, 30, 0, 25, 31, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[27];
    float16 src2 = secondSource[27];
    uint8 mask = (uint8)(31, 9, 10, 18, 28, 9, 17, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[28];
    float16 src2 = secondSource[28];
    uint8 mask = (uint8)(26, 0, 30, 31, 10, 4, 25, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[29];
    float16 src2 = secondSource[29];
    uint8 mask = (uint8)(22, 12, 21, 8, 5, 23, 31, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[30];
    float16 src2 = secondSource[30];
    uint8 mask = (uint8)(10, 4, 27, 21, 18, 17, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float16 src1 = source[31];
    float16 src2 = secondSource[31];
    uint8 mask = (uint8)(12, 9, 0, 6, 27, 19, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
