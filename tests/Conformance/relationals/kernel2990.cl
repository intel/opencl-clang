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
        (uint16)(10, 11, 11, 15, 8, 8, 2, 11, 4, 3, 1, 8, 5, 10, 2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[1];
    float8 src2 = secondSource[1];
    uint16 mask =
        (uint16)(7, 15, 5, 5, 2, 14, 5, 1, 14, 12, 4, 14, 6, 0, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[2];
    float8 src2 = secondSource[2];
    uint16 mask =
        (uint16)(12, 15, 9, 9, 0, 13, 7, 11, 15, 4, 14, 3, 15, 15, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[3];
    float8 src2 = secondSource[3];
    uint16 mask = (uint16)(10, 5, 5, 3, 12, 1, 0, 0, 7, 7, 14, 12, 4, 2, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[4];
    float8 src2 = secondSource[4];
    uint16 mask = (uint16)(1, 0, 6, 4, 12, 10, 7, 9, 8, 1, 9, 14, 5, 3, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[5];
    float8 src2 = secondSource[5];
    uint16 mask = (uint16)(1, 14, 10, 4, 3, 10, 4, 4, 15, 3, 9, 0, 13, 2, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[6];
    float8 src2 = secondSource[6];
    uint16 mask =
        (uint16)(10, 5, 5, 10, 12, 0, 0, 11, 12, 3, 13, 9, 13, 1, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[7];
    float8 src2 = secondSource[7];
    uint16 mask =
        (uint16)(14, 9, 8, 13, 10, 2, 5, 12, 7, 8, 5, 13, 9, 12, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[8];
    float8 src2 = secondSource[8];
    uint16 mask = (uint16)(5, 14, 0, 1, 7, 13, 3, 5, 3, 6, 1, 8, 5, 6, 5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[9];
    float8 src2 = secondSource[9];
    uint16 mask = (uint16)(12, 9, 0, 6, 3, 1, 9, 1, 9, 2, 4, 9, 15, 13, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[10];
    float8 src2 = secondSource[10];
    uint16 mask =
        (uint16)(6, 4, 3, 4, 11, 6, 15, 13, 14, 14, 6, 13, 7, 0, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[11];
    float8 src2 = secondSource[11];
    uint16 mask =
        (uint16)(11, 2, 5, 7, 12, 8, 12, 5, 6, 13, 11, 12, 9, 7, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[12];
    float8 src2 = secondSource[12];
    uint16 mask =
        (uint16)(12, 5, 0, 13, 8, 13, 12, 9, 8, 15, 6, 13, 9, 0, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[13];
    float8 src2 = secondSource[13];
    uint16 mask = (uint16)(14, 2, 0, 0, 4, 2, 0, 12, 6, 9, 3, 7, 0, 14, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[14];
    float8 src2 = secondSource[14];
    uint16 mask =
        (uint16)(7, 0, 11, 14, 4, 0, 2, 5, 10, 3, 14, 7, 15, 9, 15, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[15];
    float8 src2 = secondSource[15];
    uint16 mask =
        (uint16)(1, 15, 13, 11, 0, 0, 13, 15, 1, 4, 7, 11, 14, 15, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[16];
    float8 src2 = secondSource[16];
    uint16 mask = (uint16)(13, 3, 13, 10, 8, 7, 6, 11, 12, 1, 7, 0, 9, 2, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[17];
    float8 src2 = secondSource[17];
    uint16 mask =
        (uint16)(4, 12, 10, 12, 11, 1, 9, 9, 13, 0, 13, 8, 4, 14, 15, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[18];
    float8 src2 = secondSource[18];
    uint16 mask = (uint16)(13, 8, 7, 8, 9, 14, 4, 0, 3, 1, 15, 1, 3, 5, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[19];
    float8 src2 = secondSource[19];
    uint16 mask =
        (uint16)(13, 2, 9, 10, 15, 7, 1, 11, 3, 10, 14, 2, 7, 0, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[20];
    float8 src2 = secondSource[20];
    uint16 mask =
        (uint16)(2, 11, 11, 15, 6, 14, 14, 8, 7, 5, 13, 1, 13, 10, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[21];
    float8 src2 = secondSource[21];
    uint16 mask =
        (uint16)(3, 7, 12, 5, 9, 5, 14, 15, 1, 13, 2, 1, 11, 13, 14, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[22];
    float8 src2 = secondSource[22];
    uint16 mask =
        (uint16)(7, 14, 14, 1, 15, 8, 3, 10, 8, 11, 11, 11, 10, 5, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[23];
    float8 src2 = secondSource[23];
    uint16 mask =
        (uint16)(6, 7, 6, 10, 13, 15, 8, 9, 14, 9, 2, 12, 14, 1, 12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[24];
    float8 src2 = secondSource[24];
    uint16 mask = (uint16)(14, 1, 8, 7, 14, 2, 9, 6, 5, 7, 5, 3, 5, 1, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[25];
    float8 src2 = secondSource[25];
    uint16 mask =
        (uint16)(10, 10, 13, 5, 8, 12, 4, 4, 5, 11, 8, 8, 13, 14, 5, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[26];
    float8 src2 = secondSource[26];
    uint16 mask =
        (uint16)(12, 7, 8, 2, 7, 12, 0, 14, 4, 13, 11, 15, 14, 10, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[27];
    float8 src2 = secondSource[27];
    uint16 mask =
        (uint16)(3, 13, 1, 9, 7, 14, 6, 5, 7, 0, 9, 15, 15, 11, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[28];
    float8 src2 = secondSource[28];
    uint16 mask =
        (uint16)(1, 2, 13, 14, 0, 8, 0, 14, 9, 12, 1, 6, 13, 11, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[29];
    float8 src2 = secondSource[29];
    uint16 mask =
        (uint16)(9, 13, 6, 15, 14, 3, 8, 10, 0, 4, 0, 1, 10, 10, 8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[30];
    float8 src2 = secondSource[30];
    uint16 mask =
        (uint16)(4, 5, 9, 7, 2, 5, 3, 12, 11, 9, 14, 11, 3, 14, 10, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (float16)((float)0);
  {
    float8 src1 = source[31];
    float8 src2 = secondSource[31];
    uint16 mask = (uint16)(4, 15, 5, 4, 8, 4, 2, 8, 11, 6, 7, 0, 4, 5, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
