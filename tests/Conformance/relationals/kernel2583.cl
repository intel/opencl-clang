// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *source, __global uint16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 /*, src2*/;
  uint16 tmp;
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[0];
    uint16 mask =
        (uint16)(4, 14, 1, 6, 11, 6, 9, 15, 15, 14, 10, 14, 0, 15, 7, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[1];
    uint16 mask =
        (uint16)(0, 12, 5, 15, 8, 5, 15, 9, 0, 13, 15, 9, 14, 12, 10, 14);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[2];
    uint16 mask = (uint16)(1, 7, 15, 8, 9, 1, 0, 9, 13, 5, 3, 5, 4, 5, 9, 14);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[3];
    uint16 mask =
        (uint16)(1, 5, 14, 11, 10, 1, 5, 0, 11, 7, 13, 6, 13, 15, 9, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[4];
    uint16 mask =
        (uint16)(12, 13, 2, 12, 10, 1, 5, 10, 4, 9, 2, 9, 0, 1, 0, 14);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[5];
    uint16 mask = (uint16)(14, 11, 10, 9, 10, 2, 9, 4, 6, 13, 5, 7, 4, 3, 5, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[6];
    uint16 mask = (uint16)(11, 1, 7, 14, 12, 4, 1, 7, 7, 15, 6, 6, 0, 9, 2, 9);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[7];
    uint16 mask =
        (uint16)(1, 3, 5, 14, 11, 12, 10, 11, 9, 5, 7, 9, 1, 10, 8, 5);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[8];
    uint16 mask =
        (uint16)(3, 15, 13, 2, 3, 8, 13, 11, 8, 9, 6, 10, 4, 14, 8, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[9];
    uint16 mask =
        (uint16)(9, 12, 2, 2, 15, 3, 2, 5, 11, 8, 15, 10, 15, 1, 12, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[10];
    uint16 mask =
        (uint16)(14, 13, 12, 13, 10, 9, 3, 15, 1, 10, 0, 3, 6, 8, 9, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[11];
    uint16 mask =
        (uint16)(6, 13, 11, 3, 8, 3, 4, 15, 15, 4, 6, 13, 1, 1, 12, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[12];
    uint16 mask =
        (uint16)(3, 5, 1, 11, 10, 5, 12, 3, 0, 5, 10, 15, 11, 14, 10, 9);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[13];
    uint16 mask =
        (uint16)(13, 2, 0, 14, 15, 10, 10, 9, 7, 7, 1, 12, 0, 7, 14, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[14];
    uint16 mask =
        (uint16)(8, 0, 2, 14, 4, 14, 8, 5, 12, 3, 6, 13, 14, 11, 2, 6);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[15];
    uint16 mask = (uint16)(12, 14, 3, 6, 5, 13, 14, 6, 9, 2, 1, 6, 3, 7, 0, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[16];
    uint16 mask =
        (uint16)(5, 15, 8, 5, 9, 7, 15, 14, 13, 6, 13, 4, 12, 15, 8, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[17];
    uint16 mask =
        (uint16)(10, 14, 9, 9, 8, 2, 11, 9, 15, 15, 7, 0, 5, 10, 15, 4);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[18];
    uint16 mask = (uint16)(12, 10, 15, 1, 6, 3, 15, 5, 9, 4, 6, 9, 6, 7, 5, 9);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[19];
    uint16 mask =
        (uint16)(6, 12, 7, 1, 14, 0, 9, 10, 9, 15, 8, 11, 1, 3, 4, 14);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[20];
    uint16 mask = (uint16)(14, 2, 4, 13, 3, 7, 0, 5, 9, 8, 0, 8, 12, 3, 8, 13);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[21];
    uint16 mask =
        (uint16)(6, 13, 12, 15, 12, 10, 6, 12, 6, 10, 3, 14, 0, 4, 3, 12);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[22];
    uint16 mask =
        (uint16)(4, 12, 11, 10, 14, 6, 4, 3, 14, 9, 3, 15, 5, 13, 14, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[23];
    uint16 mask = (uint16)(4, 2, 2, 9, 14, 9, 9, 10, 8, 12, 12, 5, 0, 6, 1, 15);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[24];
    uint16 mask =
        (uint16)(5, 14, 7, 3, 0, 11, 12, 10, 2, 12, 6, 11, 9, 11, 13, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[25];
    uint16 mask = (uint16)(8, 1, 6, 14, 11, 5, 7, 3, 15, 0, 12, 5, 6, 2, 7, 9);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[26];
    uint16 mask = (uint16)(13, 5, 6, 8, 11, 5, 6, 12, 11, 1, 6, 4, 4, 7, 3, 8);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[27];
    uint16 mask =
        (uint16)(4, 15, 1, 13, 6, 12, 5, 15, 0, 7, 3, 15, 2, 11, 8, 12);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[28];
    uint16 mask =
        (uint16)(10, 10, 10, 3, 12, 8, 1, 0, 15, 11, 1, 14, 15, 4, 1, 11);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[29];
    uint16 mask =
        (uint16)(9, 0, 12, 14, 13, 4, 7, 8, 6, 2, 10, 10, 4, 14, 12, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[30];
    uint16 mask =
        (uint16)(7, 8, 10, 4, 10, 14, 13, 15, 11, 9, 0, 6, 5, 11, 14, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[31];
    uint16 mask = (uint16)(3, 1, 12, 2, 7, 3, 3, 14, 0, 3, 8, 5, 2, 4, 13, 10);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
