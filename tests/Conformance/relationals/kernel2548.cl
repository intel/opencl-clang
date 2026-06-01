// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *source, __global int8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 /*, src2*/;
  int8 tmp;
  tmp = (int8)((int)0);
  {
    int16 src1 = source[0];
    uint8 mask = (uint8)(9, 0, 4, 9, 0, 6, 12, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[1];
    uint8 mask = (uint8)(13, 10, 2, 7, 3, 10, 0, 7);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[2];
    uint8 mask = (uint8)(12, 15, 6, 6, 9, 14, 8, 3);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[3];
    uint8 mask = (uint8)(11, 11, 13, 3, 14, 10, 1, 11);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[4];
    uint8 mask = (uint8)(13, 5, 12, 15, 14, 7, 14, 15);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[5];
    uint8 mask = (uint8)(15, 1, 1, 5, 5, 7, 11, 6);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[6];
    uint8 mask = (uint8)(4, 8, 14, 1, 4, 0, 3, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[7];
    uint8 mask = (uint8)(14, 15, 4, 12, 4, 10, 5, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[8];
    uint8 mask = (uint8)(15, 3, 2, 8, 7, 9, 5, 8);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[9];
    uint8 mask = (uint8)(2, 5, 6, 7, 10, 11, 7, 11);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[10];
    uint8 mask = (uint8)(4, 0, 14, 9, 4, 11, 0, 14);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[11];
    uint8 mask = (uint8)(8, 14, 1, 11, 13, 8, 7, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[12];
    uint8 mask = (uint8)(1, 6, 7, 13, 6, 15, 6, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[13];
    uint8 mask = (uint8)(10, 1, 14, 11, 10, 15, 3, 10);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[14];
    uint8 mask = (uint8)(2, 7, 3, 8, 8, 5, 6, 4);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[15];
    uint8 mask = (uint8)(2, 3, 7, 6, 0, 10, 9, 15);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[16];
    uint8 mask = (uint8)(7, 14, 15, 13, 2, 13, 7, 10);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[17];
    uint8 mask = (uint8)(0, 0, 2, 14, 15, 9, 15, 12);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[18];
    uint8 mask = (uint8)(0, 13, 12, 11, 6, 11, 12, 12);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[19];
    uint8 mask = (uint8)(7, 8, 14, 6, 2, 9, 3, 14);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[20];
    uint8 mask = (uint8)(4, 0, 14, 2, 5, 3, 15, 12);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[21];
    uint8 mask = (uint8)(10, 9, 13, 8, 13, 13, 2, 15);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[22];
    uint8 mask = (uint8)(3, 5, 15, 11, 1, 13, 11, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[23];
    uint8 mask = (uint8)(14, 15, 8, 9, 5, 15, 6, 10);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[24];
    uint8 mask = (uint8)(3, 4, 15, 14, 6, 3, 0, 10);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[25];
    uint8 mask = (uint8)(2, 10, 2, 14, 3, 14, 2, 2);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[26];
    uint8 mask = (uint8)(5, 0, 3, 1, 12, 7, 14, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[27];
    uint8 mask = (uint8)(3, 10, 10, 4, 9, 3, 9, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[28];
    uint8 mask = (uint8)(0, 13, 3, 4, 4, 6, 1, 13);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[29];
    uint8 mask = (uint8)(15, 8, 12, 1, 2, 11, 1, 4);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[30];
    uint8 mask = (uint8)(12, 2, 8, 0, 1, 8, 4, 11);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[31];
    uint8 mask = (uint8)(2, 5, 8, 1, 8, 2, 15, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
