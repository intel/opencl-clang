// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int2 *source, __global int4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int2 src1 /*, src2*/;
  int4 tmp;
  tmp = (int4)((int)0);
  {
    int2 src1 = source[0];
    uint4 mask = (uint4)(1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[1];
    uint4 mask = (uint4)(0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[2];
    uint4 mask = (uint4)(0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[3];
    uint4 mask = (uint4)(0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[4];
    uint4 mask = (uint4)(0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[5];
    uint4 mask = (uint4)(0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[6];
    uint4 mask = (uint4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[7];
    uint4 mask = (uint4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[8];
    uint4 mask = (uint4)(1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[9];
    uint4 mask = (uint4)(1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[10];
    uint4 mask = (uint4)(0, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[11];
    uint4 mask = (uint4)(0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[12];
    uint4 mask = (uint4)(1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[13];
    uint4 mask = (uint4)(1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[14];
    uint4 mask = (uint4)(1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[15];
    uint4 mask = (uint4)(0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[16];
    uint4 mask = (uint4)(1, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[17];
    uint4 mask = (uint4)(1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[18];
    uint4 mask = (uint4)(1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[19];
    uint4 mask = (uint4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[20];
    uint4 mask = (uint4)(0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[21];
    uint4 mask = (uint4)(0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[22];
    uint4 mask = (uint4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[23];
    uint4 mask = (uint4)(0, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[24];
    uint4 mask = (uint4)(0, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[25];
    uint4 mask = (uint4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[26];
    uint4 mask = (uint4)(1, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[27];
    uint4 mask = (uint4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[28];
    uint4 mask = (uint4)(1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[29];
    uint4 mask = (uint4)(1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[30];
    uint4 mask = (uint4)(0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int4)((int)0);
  {
    int2 src1 = source[31];
    uint4 mask = (uint4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
