// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *source, __global int4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 /*, src2*/;
  int4 tmp;
  tmp = (int4)((int)0);
  {
    int16 src1 = source[0];
    uint4 mask = (uint4)(12, 10, 9, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[1];
    uint4 mask = (uint4)(13, 5, 7, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[2];
    uint4 mask = (uint4)(4, 1, 15, 12);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[3];
    uint4 mask = (uint4)(2, 11, 0, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[4];
    uint4 mask = (uint4)(14, 9, 1, 11);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[5];
    uint4 mask = (uint4)(12, 2, 2, 9);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[6];
    uint4 mask = (uint4)(8, 12, 5, 5);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[7];
    uint4 mask = (uint4)(1, 15, 13, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[8];
    uint4 mask = (uint4)(4, 5, 8, 15);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[9];
    uint4 mask = (uint4)(6, 9, 5, 7);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[10];
    uint4 mask = (uint4)(3, 1, 1, 5);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[11];
    uint4 mask = (uint4)(1, 11, 14, 11);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[12];
    uint4 mask = (uint4)(4, 0, 1, 10);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[13];
    uint4 mask = (uint4)(0, 0, 3, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[14];
    uint4 mask = (uint4)(11, 11, 6, 11);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[15];
    uint4 mask = (uint4)(15, 3, 8, 3);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[16];
    uint4 mask = (uint4)(12, 5, 14, 11);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[17];
    uint4 mask = (uint4)(0, 14, 3, 12);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[18];
    uint4 mask = (uint4)(11, 7, 14, 12);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[19];
    uint4 mask = (uint4)(0, 4, 4, 2);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[20];
    uint4 mask = (uint4)(12, 11, 7, 8);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[21];
    uint4 mask = (uint4)(1, 4, 6, 10);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[22];
    uint4 mask = (uint4)(8, 11, 8, 9);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[23];
    uint4 mask = (uint4)(6, 12, 6, 10);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[24];
    uint4 mask = (uint4)(12, 5, 1, 2);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[25];
    uint4 mask = (uint4)(15, 13, 15, 12);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[26];
    uint4 mask = (uint4)(2, 0, 8, 8);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[27];
    uint4 mask = (uint4)(8, 2, 2, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[28];
    uint4 mask = (uint4)(3, 8, 6, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[29];
    uint4 mask = (uint4)(9, 11, 10, 7);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[30];
    uint4 mask = (uint4)(11, 4, 0, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int16 src1 = source[31];
    uint4 mask = (uint4)(4, 5, 4, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
