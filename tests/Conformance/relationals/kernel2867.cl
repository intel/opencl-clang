// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *secondSource, __global int16 *source,
                          __global int4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 , src2;
  int4 tmp;
  tmp = (int4)((int)0);
  {
    int16 src1 = source[0];
    int16 src2 = secondSource[0];
    uint4 mask = (uint4)(25, 20, 18, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint4 mask = (uint4)(27, 11, 14, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint4 mask = (uint4)(9, 2, 30, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint4 mask = (uint4)(5, 22, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint4 mask = (uint4)(28, 19, 3, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint4 mask = (uint4)(24, 4, 5, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint4 mask = (uint4)(17, 24, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint4 mask = (uint4)(2, 31, 27, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint4 mask = (uint4)(9, 11, 16, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint4 mask = (uint4)(12, 18, 10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint4 mask = (uint4)(7, 2, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint4 mask = (uint4)(2, 23, 29, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint4 mask = (uint4)(8, 1, 3, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint4 mask = (uint4)(0, 1, 7, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint4 mask = (uint4)(23, 22, 12, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint4 mask = (uint4)(30, 6, 16, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint4 mask = (uint4)(25, 10, 28, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint4 mask = (uint4)(0, 29, 6, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint4 mask = (uint4)(22, 14, 28, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint4 mask = (uint4)(1, 8, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint4 mask = (uint4)(24, 22, 14, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint4 mask = (uint4)(2, 8, 12, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint4 mask = (uint4)(17, 23, 17, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint4 mask = (uint4)(12, 24, 12, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint4 mask = (uint4)(24, 10, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint4 mask = (uint4)(30, 27, 30, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint4 mask = (uint4)(5, 0, 17, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint4 mask = (uint4)(16, 4, 5, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint4 mask = (uint4)(7, 16, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint4 mask = (uint4)(18, 22, 21, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint4 mask = (uint4)(22, 8, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint4 mask = (uint4)(8, 10, 9, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
