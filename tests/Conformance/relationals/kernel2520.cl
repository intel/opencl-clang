// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int2 *source, __global int2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int2 src1 /*, src2*/;
  int2 tmp;
  tmp = (int2)((int)0);
  {
    int2 src1 = source[0];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[1];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[2];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[3];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[4];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[5];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[6];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[7];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[8];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[9];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[10];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[11];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[12];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[13];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[14];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[15];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[16];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[17];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[18];
    uint2 mask = (uint2)(0, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[19];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[20];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[21];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[22];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[23];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[24];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[25];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[26];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[27];
    uint2 mask = (uint2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[28];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[29];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[30];
    uint2 mask = (uint2)(0, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int2)((int)0);
  {
    int2 src1 = source[31];
    uint2 mask = (uint2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
