// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int2 *secondSource, __global int2 *source,
                          __global int8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int2 src1 , src2;
  int8 tmp;
  tmp = (int8)((int)0);
  {
    int2 src1 = source[0];
    int2 src2 = secondSource[0];
    uint8 mask = (uint8)(0, 2, 3, 0, 2, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[1];
    int2 src2 = secondSource[1];
    uint8 mask = (uint8)(2, 1, 1, 2, 1, 3, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[2];
    int2 src2 = secondSource[2];
    uint8 mask = (uint8)(3, 0, 0, 2, 1, 1, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[3];
    int2 src2 = secondSource[3];
    uint8 mask = (uint8)(3, 3, 0, 3, 0, 1, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[4];
    int2 src2 = secondSource[4];
    uint8 mask = (uint8)(1, 0, 1, 3, 3, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[5];
    int2 src2 = secondSource[5];
    uint8 mask = (uint8)(2, 3, 3, 0, 0, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[6];
    int2 src2 = secondSource[6];
    uint8 mask = (uint8)(0, 1, 2, 3, 1, 3, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[7];
    int2 src2 = secondSource[7];
    uint8 mask = (uint8)(1, 2, 1, 2, 2, 3, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[8];
    int2 src2 = secondSource[8];
    uint8 mask = (uint8)(2, 0, 2, 2, 0, 3, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[9];
    int2 src2 = secondSource[9];
    uint8 mask = (uint8)(2, 3, 3, 0, 3, 0, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[10];
    int2 src2 = secondSource[10];
    uint8 mask = (uint8)(1, 1, 0, 2, 1, 2, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[11];
    int2 src2 = secondSource[11];
    uint8 mask = (uint8)(1, 1, 0, 3, 0, 3, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[12];
    int2 src2 = secondSource[12];
    uint8 mask = (uint8)(2, 3, 1, 2, 1, 0, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[13];
    int2 src2 = secondSource[13];
    uint8 mask = (uint8)(0, 1, 1, 3, 1, 3, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[14];
    int2 src2 = secondSource[14];
    uint8 mask = (uint8)(0, 0, 0, 0, 0, 0, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[15];
    int2 src2 = secondSource[15];
    uint8 mask = (uint8)(3, 1, 1, 0, 3, 2, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[16];
    int2 src2 = secondSource[16];
    uint8 mask = (uint8)(0, 1, 1, 0, 1, 2, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[17];
    int2 src2 = secondSource[17];
    uint8 mask = (uint8)(1, 0, 3, 3, 0, 1, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[18];
    int2 src2 = secondSource[18];
    uint8 mask = (uint8)(2, 1, 1, 3, 3, 0, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[19];
    int2 src2 = secondSource[19];
    uint8 mask = (uint8)(1, 3, 3, 1, 1, 2, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[20];
    int2 src2 = secondSource[20];
    uint8 mask = (uint8)(0, 0, 2, 0, 1, 0, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[21];
    int2 src2 = secondSource[21];
    uint8 mask = (uint8)(2, 2, 3, 1, 0, 1, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[22];
    int2 src2 = secondSource[22];
    uint8 mask = (uint8)(3, 2, 1, 1, 0, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[23];
    int2 src2 = secondSource[23];
    uint8 mask = (uint8)(3, 1, 1, 1, 0, 0, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[24];
    int2 src2 = secondSource[24];
    uint8 mask = (uint8)(1, 3, 3, 0, 1, 0, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[25];
    int2 src2 = secondSource[25];
    uint8 mask = (uint8)(3, 1, 1, 3, 0, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[26];
    int2 src2 = secondSource[26];
    uint8 mask = (uint8)(3, 3, 3, 0, 2, 3, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[27];
    int2 src2 = secondSource[27];
    uint8 mask = (uint8)(2, 0, 1, 1, 1, 3, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[28];
    int2 src2 = secondSource[28];
    uint8 mask = (uint8)(0, 2, 0, 0, 3, 2, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[29];
    int2 src2 = secondSource[29];
    uint8 mask = (uint8)(0, 3, 1, 2, 3, 3, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[30];
    int2 src2 = secondSource[30];
    uint8 mask = (uint8)(1, 3, 0, 0, 1, 3, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int2 src1 = source[31];
    int2 src2 = secondSource[31];
    uint8 mask = (uint8)(2, 2, 3, 2, 0, 2, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
