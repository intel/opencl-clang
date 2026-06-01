// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *source, __global uint8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 /*, src2*/;
  uint8 tmp;
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[0];
    uint8 mask = (uint8)(8, 6, 5, 8, 15, 11, 1, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[1];
    uint8 mask = (uint8)(15, 12, 14, 6, 14, 11, 6, 6);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[2];
    uint8 mask = (uint8)(9, 12, 9, 12, 9, 6, 0, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[3];
    uint8 mask = (uint8)(13, 7, 5, 0, 14, 7, 2, 12);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[4];
    uint8 mask = (uint8)(9, 1, 9, 11, 0, 9, 3, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[5];
    uint8 mask = (uint8)(7, 15, 9, 10, 1, 2, 4, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[6];
    uint8 mask = (uint8)(8, 13, 10, 3, 13, 7, 12, 13);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[7];
    uint8 mask = (uint8)(12, 11, 4, 12, 5, 13, 10, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[8];
    uint8 mask = (uint8)(2, 5, 14, 9, 11, 7, 0, 8);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[9];
    uint8 mask = (uint8)(12, 11, 8, 10, 15, 4, 8, 9);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[10];
    uint8 mask = (uint8)(9, 11, 13, 5, 14, 4, 14, 15);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[11];
    uint8 mask = (uint8)(9, 2, 10, 6, 0, 7, 9, 13);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[12];
    uint8 mask = (uint8)(2, 14, 9, 8, 15, 9, 5, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[13];
    uint8 mask = (uint8)(11, 5, 7, 6, 10, 9, 13, 11);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[14];
    uint8 mask = (uint8)(11, 12, 4, 3, 13, 1, 15, 5);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[15];
    uint8 mask = (uint8)(14, 11, 9, 15, 14, 7, 2, 5);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[16];
    uint8 mask = (uint8)(3, 9, 4, 12, 12, 2, 3, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[17];
    uint8 mask = (uint8)(11, 11, 13, 7, 3, 9, 8, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[18];
    uint8 mask = (uint8)(13, 3, 1, 2, 9, 9, 3, 13);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[19];
    uint8 mask = (uint8)(14, 4, 14, 10, 9, 4, 5, 13);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[20];
    uint8 mask = (uint8)(12, 11, 4, 13, 13, 10, 3, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[21];
    uint8 mask = (uint8)(2, 9, 11, 11, 11, 2, 4, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[22];
    uint8 mask = (uint8)(3, 11, 14, 9, 0, 2, 9, 13);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[23];
    uint8 mask = (uint8)(12, 5, 15, 1, 11, 1, 12, 9);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[24];
    uint8 mask = (uint8)(14, 11, 7, 0, 1, 4, 3, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[25];
    uint8 mask = (uint8)(15, 13, 3, 5, 3, 9, 6, 4);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[26];
    uint8 mask = (uint8)(13, 13, 12, 13, 9, 5, 8, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[27];
    uint8 mask = (uint8)(11, 10, 2, 9, 9, 13, 8, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[28];
    uint8 mask = (uint8)(9, 4, 12, 2, 10, 11, 14, 14);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[29];
    uint8 mask = (uint8)(9, 8, 4, 14, 6, 8, 5, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[30];
    uint8 mask = (uint8)(11, 2, 10, 6, 4, 2, 14, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[31];
    uint8 mask = (uint8)(0, 2, 13, 0, 6, 0, 15, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
