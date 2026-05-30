// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *source, __global int8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 /*, src2*/;
  int8 tmp;
  tmp = (int8)((int)0);
  {
    int16 src1 = source[0];
    uint8 mask = (uint8)(1, 1, 15, 3, 9, 13, 2, 7);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[1];
    uint8 mask = (uint8)(7, 2, 2, 8, 13, 13, 11, 8);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[2];
    uint8 mask = (uint8)(14, 0, 15, 11, 2, 12, 12, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[3];
    uint8 mask = (uint8)(4, 14, 15, 8, 3, 11, 5, 15);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[4];
    uint8 mask = (uint8)(4, 7, 11, 5, 5, 14, 3, 9);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[5];
    uint8 mask = (uint8)(2, 3, 2, 11, 15, 13, 14, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[6];
    uint8 mask = (uint8)(10, 3, 14, 7, 15, 7, 5, 9);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[7];
    uint8 mask = (uint8)(12, 3, 9, 12, 1, 9, 5, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[8];
    uint8 mask = (uint8)(0, 4, 15, 7, 5, 12, 10, 1);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[9];
    uint8 mask = (uint8)(15, 2, 15, 10, 7, 2, 0, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[10];
    uint8 mask = (uint8)(15, 1, 0, 0, 12, 5, 0, 12);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[11];
    uint8 mask = (uint8)(12, 10, 5, 9, 8, 8, 0, 10);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[12];
    uint8 mask = (uint8)(1, 13, 3, 3, 8, 15, 13, 5);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[13];
    uint8 mask = (uint8)(0, 11, 14, 1, 2, 1, 5, 12);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[14];
    uint8 mask = (uint8)(11, 10, 14, 4, 3, 12, 6, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[15];
    uint8 mask = (uint8)(4, 7, 10, 0, 12, 10, 9, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[16];
    uint8 mask = (uint8)(3, 0, 2, 2, 1, 13, 13, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[17];
    uint8 mask = (uint8)(1, 15, 14, 6, 5, 11, 9, 13);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[18];
    uint8 mask = (uint8)(11, 15, 10, 3, 4, 8, 12, 7);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[19];
    uint8 mask = (uint8)(4, 13, 3, 14, 5, 8, 10, 11);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[20];
    uint8 mask = (uint8)(9, 1, 14, 6, 3, 1, 12, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[21];
    uint8 mask = (uint8)(1, 14, 9, 5, 15, 4, 15, 6);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[22];
    uint8 mask = (uint8)(2, 2, 0, 11, 7, 8, 6, 13);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[23];
    uint8 mask = (uint8)(9, 1, 15, 5, 2, 13, 2, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[24];
    uint8 mask = (uint8)(9, 7, 10, 13, 5, 12, 10, 10);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[25];
    uint8 mask = (uint8)(13, 14, 11, 11, 0, 15, 6, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[26];
    uint8 mask = (uint8)(0, 3, 2, 1, 9, 6, 8, 10);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[27];
    uint8 mask = (uint8)(1, 2, 0, 9, 7, 10, 3, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[28];
    uint8 mask = (uint8)(14, 8, 1, 14, 2, 4, 1, 12);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[29];
    uint8 mask = (uint8)(6, 15, 15, 11, 7, 1, 4, 0);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[30];
    uint8 mask = (uint8)(4, 3, 12, 10, 0, 15, 5, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int8)((int)0);
  {
    int16 src1 = source[31];
    uint8 mask = (uint8)(6, 14, 11, 1, 12, 1, 9, 13);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
