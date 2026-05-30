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
        (uint16)(14, 5, 9, 4, 1, 6, 11, 2, 11, 3, 10, 13, 4, 11, 10, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[1];
    uint16 mask = (uint16)(2, 3, 11, 9, 9, 4, 0, 6, 8, 4, 4, 6, 8, 6, 9, 2);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[2];
    uint16 mask =
        (uint16)(10, 6, 1, 3, 3, 14, 12, 15, 1, 4, 13, 4, 11, 14, 1, 10);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[3];
    uint16 mask = (uint16)(7, 13, 3, 3, 2, 1, 7, 3, 3, 3, 15, 11, 5, 3, 2, 8);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[4];
    uint16 mask = (uint16)(4, 12, 3, 15, 12, 8, 3, 9, 2, 8, 8, 11, 7, 15, 4, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[5];
    uint16 mask = (uint16)(2, 9, 14, 10, 5, 9, 9, 11, 3, 9, 4, 6, 7, 9, 6, 12);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[6];
    uint16 mask = (uint16)(6, 8, 8, 3, 11, 3, 0, 5, 1, 14, 5, 10, 4, 0, 14, 13);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[7];
    uint16 mask =
        (uint16)(14, 6, 15, 7, 5, 0, 13, 0, 10, 13, 6, 14, 0, 5, 5, 12);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[8];
    uint16 mask = (uint16)(6, 10, 1, 15, 1, 4, 2, 13, 0, 9, 5, 6, 8, 14, 9, 10);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[9];
    uint16 mask =
        (uint16)(4, 3, 12, 4, 12, 0, 11, 14, 10, 12, 4, 1, 1, 8, 2, 8);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[10];
    uint16 mask = (uint16)(0, 6, 4, 11, 0, 11, 8, 9, 7, 2, 1, 4, 1, 6, 12, 5);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[11];
    uint16 mask = (uint16)(5, 12, 14, 4, 0, 8, 5, 5, 6, 7, 14, 2, 0, 0, 2, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[12];
    uint16 mask =
        (uint16)(9, 5, 5, 12, 1, 15, 12, 13, 4, 9, 10, 7, 8, 11, 2, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[13];
    uint16 mask =
        (uint16)(4, 6, 4, 11, 8, 11, 12, 9, 9, 4, 8, 11, 15, 15, 6, 4);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[14];
    uint16 mask = (uint16)(14, 0, 3, 6, 2, 3, 12, 0, 2, 15, 7, 3, 0, 12, 5, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[15];
    uint16 mask =
        (uint16)(6, 3, 5, 12, 2, 14, 15, 13, 9, 4, 12, 3, 15, 4, 10, 9);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[16];
    uint16 mask =
        (uint16)(12, 3, 10, 9, 14, 9, 5, 3, 14, 10, 4, 10, 8, 12, 5, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[17];
    uint16 mask =
        (uint16)(12, 9, 2, 3, 13, 8, 8, 15, 15, 11, 7, 10, 4, 5, 14, 9);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[18];
    uint16 mask = (uint16)(9, 0, 2, 13, 8, 11, 4, 2, 11, 15, 8, 8, 1, 12, 7, 8);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[19];
    uint16 mask = (uint16)(11, 6, 2, 9, 9, 3, 0, 6, 8, 10, 0, 14, 5, 2, 5, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[20];
    uint16 mask = (uint16)(7, 9, 14, 4, 2, 15, 9, 3, 4, 14, 14, 8, 0, 9, 2, 12);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[21];
    uint16 mask =
        (uint16)(11, 0, 13, 9, 10, 1, 15, 10, 7, 13, 5, 12, 0, 3, 10, 3);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[22];
    uint16 mask = (uint16)(8, 3, 3, 0, 12, 4, 2, 5, 3, 1, 3, 12, 9, 3, 0, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[23];
    uint16 mask =
        (uint16)(6, 10, 15, 4, 12, 15, 12, 8, 14, 10, 6, 6, 4, 0, 15, 0);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[24];
    uint16 mask =
        (uint16)(10, 8, 2, 14, 15, 8, 10, 11, 12, 7, 4, 5, 7, 5, 2, 9);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[25];
    uint16 mask = (uint16)(5, 0, 8, 11, 6, 9, 1, 12, 11, 2, 12, 3, 6, 11, 3, 3);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[26];
    uint16 mask = (uint16)(10, 2, 9, 9, 10, 10, 6, 12, 9, 13, 6, 0, 8, 4, 4, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[27];
    uint16 mask =
        (uint16)(6, 11, 4, 6, 10, 13, 2, 14, 9, 7, 9, 10, 13, 7, 12, 3);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[28];
    uint16 mask =
        (uint16)(0, 5, 9, 7, 1, 15, 1, 6, 13, 7, 4, 11, 11, 14, 15, 15);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[29];
    uint16 mask =
        (uint16)(15, 9, 11, 7, 9, 6, 12, 3, 2, 11, 15, 7, 3, 15, 11, 9);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[30];
    uint16 mask = (uint16)(1, 9, 2, 2, 3, 12, 6, 7, 3, 0, 11, 2, 4, 14, 5, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uint16)((uint)0);
  {
    uint16 src1 = source[31];
    uint16 mask = (uint16)(10, 3, 0, 9, 15, 4, 6, 5, 3, 3, 12, 6, 5, 7, 5, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
