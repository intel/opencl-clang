// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint4 *secondSource, __global uint4 *source,
                          __global uint8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint4 src1 , src2;
  uint8 tmp;
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[0];
    uint4 src2 = secondSource[0];
    uint8 mask = (uint8)(5, 5, 4, 6, 2, 5, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[1];
    uint4 src2 = secondSource[1];
    uint8 mask = (uint8)(2, 3, 7, 3, 4, 2, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[2];
    uint4 src2 = secondSource[2];
    uint8 mask = (uint8)(2, 2, 6, 7, 0, 0, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[3];
    uint4 src2 = secondSource[3];
    uint8 mask = (uint8)(7, 0, 2, 3, 3, 2, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[4];
    uint4 src2 = secondSource[4];
    uint8 mask = (uint8)(0, 1, 0, 3, 4, 3, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[5];
    uint4 src2 = secondSource[5];
    uint8 mask = (uint8)(6, 5, 4, 3, 0, 3, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[6];
    uint4 src2 = secondSource[6];
    uint8 mask = (uint8)(0, 0, 3, 7, 3, 7, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[7];
    uint4 src2 = secondSource[7];
    uint8 mask = (uint8)(5, 3, 1, 0, 3, 3, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[8];
    uint4 src2 = secondSource[8];
    uint8 mask = (uint8)(7, 7, 3, 5, 4, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[9];
    uint4 src2 = secondSource[9];
    uint8 mask = (uint8)(0, 3, 2, 7, 7, 5, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[10];
    uint4 src2 = secondSource[10];
    uint8 mask = (uint8)(2, 4, 4, 2, 6, 3, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[11];
    uint4 src2 = secondSource[11];
    uint8 mask = (uint8)(7, 0, 5, 0, 6, 2, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[12];
    uint4 src2 = secondSource[12];
    uint8 mask = (uint8)(6, 1, 4, 2, 4, 0, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[13];
    uint4 src2 = secondSource[13];
    uint8 mask = (uint8)(4, 1, 7, 5, 6, 3, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[14];
    uint4 src2 = secondSource[14];
    uint8 mask = (uint8)(4, 1, 2, 7, 7, 6, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[15];
    uint4 src2 = secondSource[15];
    uint8 mask = (uint8)(2, 2, 7, 7, 1, 1, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[16];
    uint4 src2 = secondSource[16];
    uint8 mask = (uint8)(1, 2, 6, 5, 4, 1, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[17];
    uint4 src2 = secondSource[17];
    uint8 mask = (uint8)(3, 1, 0, 1, 3, 5, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[18];
    uint4 src2 = secondSource[18];
    uint8 mask = (uint8)(7, 7, 5, 7, 5, 5, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[19];
    uint4 src2 = secondSource[19];
    uint8 mask = (uint8)(4, 4, 5, 6, 1, 0, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[20];
    uint4 src2 = secondSource[20];
    uint8 mask = (uint8)(0, 1, 3, 5, 4, 1, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[21];
    uint4 src2 = secondSource[21];
    uint8 mask = (uint8)(1, 3, 0, 4, 0, 6, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[22];
    uint4 src2 = secondSource[22];
    uint8 mask = (uint8)(0, 4, 1, 6, 4, 3, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[23];
    uint4 src2 = secondSource[23];
    uint8 mask = (uint8)(4, 0, 0, 2, 5, 3, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[24];
    uint4 src2 = secondSource[24];
    uint8 mask = (uint8)(3, 4, 0, 0, 7, 7, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[25];
    uint4 src2 = secondSource[25];
    uint8 mask = (uint8)(0, 2, 6, 2, 3, 5, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[26];
    uint4 src2 = secondSource[26];
    uint8 mask = (uint8)(4, 1, 7, 2, 3, 0, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[27];
    uint4 src2 = secondSource[27];
    uint8 mask = (uint8)(4, 5, 1, 5, 3, 5, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[28];
    uint4 src2 = secondSource[28];
    uint8 mask = (uint8)(3, 2, 5, 7, 0, 1, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[29];
    uint4 src2 = secondSource[29];
    uint8 mask = (uint8)(1, 4, 2, 5, 4, 1, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[30];
    uint4 src2 = secondSource[30];
    uint8 mask = (uint8)(3, 4, 7, 0, 1, 5, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint4 src1 = source[31];
    uint4 src2 = secondSource[31];
    uint8 mask = (uint8)(3, 7, 2, 2, 3, 0, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
