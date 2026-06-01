// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float8 *secondSource,
                          __global float8 *source, __global float16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // float8 src1 , src2;
  float16 tmp;
  tmp = (float16)((float)0);
  {
    float8 src1 = source[0];
    float8 src2 = secondSource[0];
    uint16 mask =
        (uint16)(0, 15, 13, 0, 10, 5, 5, 14, 6, 11, 11, 11, 11, 7, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[1];
    float8 src2 = secondSource[1];
    uint16 mask =
        (uint16)(7, 14, 13, 7, 15, 8, 5, 8, 13, 3, 10, 9, 6, 9, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[2];
    float8 src2 = secondSource[2];
    uint16 mask = (uint16)(10, 2, 1, 4, 11, 13, 8, 5, 11, 11, 0, 4, 5, 9, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[3];
    float8 src2 = secondSource[3];
    uint16 mask = (uint16)(4, 8, 11, 8, 14, 2, 5, 5, 1, 4, 12, 0, 5, 2, 11, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[4];
    float8 src2 = secondSource[4];
    uint16 mask =
        (uint16)(4, 0, 10, 14, 5, 7, 13, 14, 14, 0, 13, 1, 14, 8, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[5];
    float8 src2 = secondSource[5];
    uint16 mask =
        (uint16)(1, 13, 14, 0, 14, 9, 8, 6, 6, 3, 10, 11, 1, 0, 5, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[6];
    float8 src2 = secondSource[6];
    uint16 mask =
        (uint16)(11, 8, 14, 12, 12, 10, 1, 11, 0, 8, 7, 15, 7, 7, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[7];
    float8 src2 = secondSource[7];
    uint16 mask = (uint16)(8, 4, 3, 12, 11, 13, 5, 1, 3, 4, 1, 5, 2, 12, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[8];
    float8 src2 = secondSource[8];
    uint16 mask =
        (uint16)(10, 3, 4, 10, 1, 7, 12, 2, 6, 12, 10, 4, 15, 5, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[9];
    float8 src2 = secondSource[9];
    uint16 mask = (uint16)(3, 4, 10, 4, 10, 4, 4, 0, 13, 1, 0, 7, 2, 0, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[10];
    float8 src2 = secondSource[10];
    uint16 mask = (uint16)(7, 10, 6, 10, 0, 3, 5, 8, 9, 9, 12, 5, 8, 13, 12, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[11];
    float8 src2 = secondSource[11];
    uint16 mask = (uint16)(2, 7, 3, 4, 10, 13, 0, 10, 8, 11, 5, 14, 6, 5, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[12];
    float8 src2 = secondSource[12];
    uint16 mask =
        (uint16)(4, 11, 1, 15, 0, 10, 3, 11, 8, 10, 6, 5, 3, 4, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[13];
    float8 src2 = secondSource[13];
    uint16 mask = (uint16)(13, 14, 4, 12, 9, 5, 0, 5, 8, 11, 4, 9, 15, 6, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[14];
    float8 src2 = secondSource[14];
    uint16 mask =
        (uint16)(1, 11, 1, 8, 12, 9, 9, 1, 3, 13, 8, 2, 12, 14, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[15];
    float8 src2 = secondSource[15];
    uint16 mask =
        (uint16)(3, 6, 6, 12, 13, 5, 8, 10, 10, 12, 12, 9, 2, 4, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[16];
    float8 src2 = secondSource[16];
    uint16 mask =
        (uint16)(2, 1, 8, 14, 12, 3, 2, 4, 15, 13, 3, 4, 11, 11, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[17];
    float8 src2 = secondSource[17];
    uint16 mask =
        (uint16)(8, 14, 2, 14, 11, 5, 14, 11, 1, 12, 14, 6, 8, 6, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[18];
    float8 src2 = secondSource[18];
    uint16 mask = (uint16)(11, 6, 10, 9, 6, 4, 15, 12, 3, 8, 7, 0, 8, 2, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[19];
    float8 src2 = secondSource[19];
    uint16 mask = (uint16)(7, 12, 12, 2, 5, 6, 2, 9, 10, 1, 2, 6, 9, 6, 6, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[20];
    float8 src2 = secondSource[20];
    uint16 mask =
        (uint16)(3, 1, 11, 6, 11, 2, 2, 4, 7, 11, 14, 12, 12, 11, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[21];
    float8 src2 = secondSource[21];
    uint16 mask = (uint16)(1, 10, 0, 5, 1, 11, 12, 3, 10, 6, 1, 8, 5, 9, 3, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[22];
    float8 src2 = secondSource[22];
    uint16 mask = (uint16)(1, 2, 4, 7, 11, 9, 13, 3, 10, 3, 5, 5, 15, 9, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[23];
    float8 src2 = secondSource[23];
    uint16 mask =
        (uint16)(12, 5, 5, 10, 11, 9, 0, 2, 4, 6, 1, 3, 15, 12, 14, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[24];
    float8 src2 = secondSource[24];
    uint16 mask = (uint16)(9, 12, 15, 0, 9, 1, 14, 4, 9, 10, 7, 0, 8, 6, 4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[25];
    float8 src2 = secondSource[25];
    uint16 mask = (uint16)(1, 8, 1, 5, 9, 2, 1, 13, 9, 6, 14, 6, 13, 9, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[26];
    float8 src2 = secondSource[26];
    uint16 mask = (uint16)(2, 3, 11, 0, 3, 2, 14, 5, 5, 11, 11, 9, 6, 14, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[27];
    float8 src2 = secondSource[27];
    uint16 mask =
        (uint16)(0, 14, 12, 0, 7, 13, 3, 6, 3, 11, 14, 5, 1, 10, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[28];
    float8 src2 = secondSource[28];
    uint16 mask = (uint16)(6, 8, 7, 10, 2, 12, 0, 3, 8, 1, 1, 4, 11, 4, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[29];
    float8 src2 = secondSource[29];
    uint16 mask = (uint16)(1, 15, 3, 3, 6, 7, 8, 1, 0, 10, 9, 13, 11, 10, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[30];
    float8 src2 = secondSource[30];
    uint16 mask = (uint16)(8, 7, 12, 8, 4, 1, 12, 3, 3, 5, 15, 6, 7, 2, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[31];
    float8 src2 = secondSource[31];
    uint16 mask =
        (uint16)(12, 5, 10, 13, 0, 10, 15, 12, 6, 8, 13, 15, 5, 15, 14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
