// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float8 *secondSource,
                          __global float8 *source, __global float8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float8 src1 , src2;
  float8 tmp;
  tmp = (float8)((float)0);
  {
    float8 src1 = source[0];
    float8 src2 = secondSource[0];
    uint8 mask = (uint8)(10, 3, 14, 3, 6, 5, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[1];
    float8 src2 = secondSource[1];
    uint8 mask = (uint8)(3, 15, 6, 13, 9, 2, 9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[2];
    float8 src2 = secondSource[2];
    uint8 mask = (uint8)(14, 12, 6, 5, 9, 3, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[3];
    float8 src2 = secondSource[3];
    uint8 mask = (uint8)(3, 4, 11, 1, 0, 10, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[4];
    float8 src2 = secondSource[4];
    uint8 mask = (uint8)(11, 3, 11, 8, 10, 11, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[5];
    float8 src2 = secondSource[5];
    uint8 mask = (uint8)(5, 0, 4, 2, 3, 5, 8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[6];
    float8 src2 = secondSource[6];
    uint8 mask = (uint8)(2, 13, 15, 11, 11, 12, 7, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[7];
    float8 src2 = secondSource[7];
    uint8 mask = (uint8)(6, 12, 1, 4, 8, 10, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[8];
    float8 src2 = secondSource[8];
    uint8 mask = (uint8)(10, 0, 0, 10, 15, 11, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[9];
    float8 src2 = secondSource[9];
    uint8 mask = (uint8)(13, 6, 4, 8, 5, 2, 8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[10];
    float8 src2 = secondSource[10];
    uint8 mask = (uint8)(6, 11, 12, 0, 15, 14, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[11];
    float8 src2 = secondSource[11];
    uint8 mask = (uint8)(1, 0, 1, 9, 15, 13, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[12];
    float8 src2 = secondSource[12];
    uint8 mask = (uint8)(7, 0, 10, 0, 6, 6, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[13];
    float8 src2 = secondSource[13];
    uint8 mask = (uint8)(5, 10, 2, 4, 12, 6, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[14];
    float8 src2 = secondSource[14];
    uint8 mask = (uint8)(13, 13, 3, 4, 6, 2, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[15];
    float8 src2 = secondSource[15];
    uint8 mask = (uint8)(1, 12, 4, 6, 4, 4, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[16];
    float8 src2 = secondSource[16];
    uint8 mask = (uint8)(3, 13, 12, 14, 6, 5, 8, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[17];
    float8 src2 = secondSource[17];
    uint8 mask = (uint8)(6, 15, 6, 4, 10, 11, 8, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[18];
    float8 src2 = secondSource[18];
    uint8 mask = (uint8)(14, 7, 15, 7, 13, 14, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[19];
    float8 src2 = secondSource[19];
    uint8 mask = (uint8)(3, 8, 13, 13, 11, 6, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[20];
    float8 src2 = secondSource[20];
    uint8 mask = (uint8)(13, 6, 9, 4, 8, 15, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[21];
    float8 src2 = secondSource[21];
    uint8 mask = (uint8)(3, 10, 3, 3, 3, 4, 8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[22];
    float8 src2 = secondSource[22];
    uint8 mask = (uint8)(9, 4, 9, 14, 2, 1, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[23];
    float8 src2 = secondSource[23];
    uint8 mask = (uint8)(8, 12, 13, 3, 3, 3, 12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[24];
    float8 src2 = secondSource[24];
    uint8 mask = (uint8)(7, 12, 1, 8, 2, 12, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[25];
    float8 src2 = secondSource[25];
    uint8 mask = (uint8)(6, 12, 11, 6, 2, 1, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[26];
    float8 src2 = secondSource[26];
    uint8 mask = (uint8)(9, 0, 12, 2, 5, 2, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[27];
    float8 src2 = secondSource[27];
    uint8 mask = (uint8)(0, 7, 12, 8, 13, 15, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[28];
    float8 src2 = secondSource[28];
    uint8 mask = (uint8)(13, 15, 10, 0, 7, 4, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[29];
    float8 src2 = secondSource[29];
    uint8 mask = (uint8)(14, 6, 7, 14, 11, 5, 11, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[30];
    float8 src2 = secondSource[30];
    uint8 mask = (uint8)(9, 2, 15, 13, 5, 5, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float8)((float)0);
  {
    float8 src1 = source[31];
    float8 src2 = secondSource[31];
    uint8 mask = (uint8)(7, 8, 5, 14, 14, 8, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
