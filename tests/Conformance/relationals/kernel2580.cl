// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *source, __global uint8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 /*, src2*/;
  uint8 tmp;
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[0];
    uint8 mask = (uint8)(8, 9, 15, 14, 4, 11, 0, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[1];
    uint8 mask = (uint8)(4, 9, 10, 6, 13, 13, 2, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[2];
    uint8 mask = (uint8)(4, 8, 15, 12, 14, 3, 2, 12);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[3];
    uint8 mask = (uint8)(3, 7, 5, 8, 2, 3, 14, 7);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[4];
    uint8 mask = (uint8)(7, 2, 0, 7, 0, 13, 2, 8);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[5];
    uint8 mask = (uint8)(14, 7, 1, 12, 5, 0, 3, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[6];
    uint8 mask = (uint8)(13, 13, 14, 0, 13, 9, 7, 8);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[7];
    uint8 mask = (uint8)(3, 7, 3, 6, 10, 7, 7, 14);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[8];
    uint8 mask = (uint8)(8, 9, 13, 12, 15, 11, 14, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[9];
    uint8 mask = (uint8)(3, 0, 6, 7, 9, 8, 7, 9);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[10];
    uint8 mask = (uint8)(4, 9, 3, 13, 4, 3, 9, 8);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[11];
    uint8 mask = (uint8)(8, 8, 11, 15, 3, 0, 14, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[12];
    uint8 mask = (uint8)(3, 1, 10, 4, 9, 7, 1, 13);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[13];
    uint8 mask = (uint8)(3, 2, 13, 13, 14, 7, 6, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[14];
    uint8 mask = (uint8)(14, 9, 0, 12, 8, 13, 13, 12);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[15];
    uint8 mask = (uint8)(9, 9, 13, 3, 2, 10, 4, 8);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[16];
    uint8 mask = (uint8)(1, 2, 1, 0, 11, 8, 1, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[17];
    uint8 mask = (uint8)(11, 14, 11, 8, 0, 15, 1, 9);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[18];
    uint8 mask = (uint8)(4, 0, 1, 11, 13, 5, 7, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[19];
    uint8 mask = (uint8)(0, 8, 12, 0, 6, 4, 7, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[20];
    uint8 mask = (uint8)(13, 10, 7, 10, 12, 4, 6, 14);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[21];
    uint8 mask = (uint8)(1, 11, 5, 7, 1, 5, 3, 13);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[22];
    uint8 mask = (uint8)(12, 12, 3, 4, 1, 13, 5, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[23];
    uint8 mask = (uint8)(9, 14, 4, 6, 12, 7, 15, 11);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[24];
    uint8 mask = (uint8)(10, 6, 10, 14, 2, 8, 13, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[25];
    uint8 mask = (uint8)(0, 8, 14, 10, 5, 1, 4, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[26];
    uint8 mask = (uint8)(1, 3, 8, 7, 0, 6, 7, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[27];
    uint8 mask = (uint8)(13, 2, 12, 12, 1, 14, 7, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[28];
    uint8 mask = (uint8)(13, 4, 11, 2, 0, 12, 3, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[29];
    uint8 mask = (uint8)(14, 4, 10, 10, 12, 7, 8, 9);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[30];
    uint8 mask = (uint8)(1, 8, 7, 12, 8, 11, 7, 15);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uint8)((uint)0);
  {
    uint16 src1 = source[31];
    uint8 mask = (uint8)(15, 8, 4, 7, 4, 13, 7, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
