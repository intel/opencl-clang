// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint4 *secondSource, __global uint4 *source,
                          __global uint4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint4 src1 , src2;
  uint4 tmp;
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[0];
    uint4 src2 = secondSource[0];
    uint4 mask = (uint4)(4, 7, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[1];
    uint4 src2 = secondSource[1];
    uint4 mask = (uint4)(3, 2, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[2];
    uint4 src2 = secondSource[2];
    uint4 mask = (uint4)(4, 3, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[3];
    uint4 src2 = secondSource[3];
    uint4 mask = (uint4)(7, 6, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[4];
    uint4 src2 = secondSource[4];
    uint4 mask = (uint4)(2, 5, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[5];
    uint4 src2 = secondSource[5];
    uint4 mask = (uint4)(0, 6, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[6];
    uint4 src2 = secondSource[6];
    uint4 mask = (uint4)(7, 4, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[7];
    uint4 src2 = secondSource[7];
    uint4 mask = (uint4)(7, 3, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[8];
    uint4 src2 = secondSource[8];
    uint4 mask = (uint4)(4, 6, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[9];
    uint4 src2 = secondSource[9];
    uint4 mask = (uint4)(4, 4, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[10];
    uint4 src2 = secondSource[10];
    uint4 mask = (uint4)(5, 6, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[11];
    uint4 src2 = secondSource[11];
    uint4 mask = (uint4)(7, 5, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[12];
    uint4 src2 = secondSource[12];
    uint4 mask = (uint4)(6, 4, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[13];
    uint4 src2 = secondSource[13];
    uint4 mask = (uint4)(4, 0, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[14];
    uint4 src2 = secondSource[14];
    uint4 mask = (uint4)(0, 3, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[15];
    uint4 src2 = secondSource[15];
    uint4 mask = (uint4)(3, 6, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[16];
    uint4 src2 = secondSource[16];
    uint4 mask = (uint4)(1, 0, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[17];
    uint4 src2 = secondSource[17];
    uint4 mask = (uint4)(0, 7, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[18];
    uint4 src2 = secondSource[18];
    uint4 mask = (uint4)(1, 3, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[19];
    uint4 src2 = secondSource[19];
    uint4 mask = (uint4)(4, 4, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[20];
    uint4 src2 = secondSource[20];
    uint4 mask = (uint4)(1, 7, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[21];
    uint4 src2 = secondSource[21];
    uint4 mask = (uint4)(2, 7, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[22];
    uint4 src2 = secondSource[22];
    uint4 mask = (uint4)(0, 1, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[23];
    uint4 src2 = secondSource[23];
    uint4 mask = (uint4)(1, 3, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[24];
    uint4 src2 = secondSource[24];
    uint4 mask = (uint4)(2, 7, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[25];
    uint4 src2 = secondSource[25];
    uint4 mask = (uint4)(4, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[26];
    uint4 src2 = secondSource[26];
    uint4 mask = (uint4)(6, 3, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[27];
    uint4 src2 = secondSource[27];
    uint4 mask = (uint4)(6, 0, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[28];
    uint4 src2 = secondSource[28];
    uint4 mask = (uint4)(2, 4, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[29];
    uint4 src2 = secondSource[29];
    uint4 mask = (uint4)(5, 4, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[30];
    uint4 src2 = secondSource[30];
    uint4 mask = (uint4)(7, 3, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint4 src1 = source[31];
    uint4 src2 = secondSource[31];
    uint4 mask = (uint4)(2, 5, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
