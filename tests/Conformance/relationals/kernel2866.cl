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
    uint4 mask = (uint4)(9, 27, 31, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[1];
    int16 src2 = secondSource[1];
    uint4 mask = (uint4)(8, 12, 29, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[2];
    int16 src2 = secondSource[2];
    uint4 mask = (uint4)(10, 15, 23, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[3];
    int16 src2 = secondSource[3];
    uint4 mask = (uint4)(8, 4, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[4];
    int16 src2 = secondSource[4];
    uint4 mask = (uint4)(29, 28, 25, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[5];
    int16 src2 = secondSource[5];
    uint4 mask = (uint4)(28, 2, 20, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[6];
    int16 src2 = secondSource[6];
    uint4 mask = (uint4)(13, 8, 26, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[7];
    int16 src2 = secondSource[7];
    uint4 mask = (uint4)(2, 28, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[8];
    int16 src2 = secondSource[8];
    uint4 mask = (uint4)(22, 15, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[9];
    int16 src2 = secondSource[9];
    uint4 mask = (uint4)(1, 10, 26, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[10];
    int16 src2 = secondSource[10];
    uint4 mask = (uint4)(8, 16, 19, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[11];
    int16 src2 = secondSource[11];
    uint4 mask = (uint4)(31, 5, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[12];
    int16 src2 = secondSource[12];
    uint4 mask = (uint4)(28, 16, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[13];
    int16 src2 = secondSource[13];
    uint4 mask = (uint4)(24, 18, 28, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[14];
    int16 src2 = secondSource[14];
    uint4 mask = (uint4)(4, 13, 28, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[15];
    int16 src2 = secondSource[15];
    uint4 mask = (uint4)(13, 28, 26, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[16];
    int16 src2 = secondSource[16];
    uint4 mask = (uint4)(11, 30, 27, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[17];
    int16 src2 = secondSource[17];
    uint4 mask = (uint4)(22, 29, 28, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[18];
    int16 src2 = secondSource[18];
    uint4 mask = (uint4)(5, 10, 30, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[19];
    int16 src2 = secondSource[19];
    uint4 mask = (uint4)(6, 9, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[20];
    int16 src2 = secondSource[20];
    uint4 mask = (uint4)(7, 13, 14, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[21];
    int16 src2 = secondSource[21];
    uint4 mask = (uint4)(28, 25, 11, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[22];
    int16 src2 = secondSource[22];
    uint4 mask = (uint4)(5, 2, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[23];
    int16 src2 = secondSource[23];
    uint4 mask = (uint4)(28, 29, 26, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[24];
    int16 src2 = secondSource[24];
    uint4 mask = (uint4)(5, 22, 22, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[25];
    int16 src2 = secondSource[25];
    uint4 mask = (uint4)(5, 17, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[26];
    int16 src2 = secondSource[26];
    uint4 mask = (uint4)(28, 4, 21, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[27];
    int16 src2 = secondSource[27];
    uint4 mask = (uint4)(30, 2, 4, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[28];
    int16 src2 = secondSource[28];
    uint4 mask = (uint4)(29, 6, 28, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[29];
    int16 src2 = secondSource[29];
    uint4 mask = (uint4)(9, 29, 21, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[30];
    int16 src2 = secondSource[30];
    uint4 mask = (uint4)(23, 0, 24, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[31];
    int16 src2 = secondSource[31];
    uint4 mask = (uint4)(30, 17, 11, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
