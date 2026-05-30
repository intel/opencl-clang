// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *source, __global int16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int16 src1 /*, src2*/;
  int16 tmp;
  tmp = (int16)((int)0);
  {
    int16 src1 = source[0];
    uint16 mask =
        (uint16)(15, 9, 0, 11, 8, 10, 14, 12, 10, 4, 4, 14, 4, 5, 4, 3);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[1];
    uint16 mask = (uint16)(0, 3, 1, 7, 15, 11, 8, 2, 1, 3, 8, 9, 4, 5, 12, 5);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[2];
    uint16 mask = (uint16)(0, 4, 6, 15, 10, 5, 6, 3, 11, 14, 9, 15, 8, 8, 2, 7);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[3];
    uint16 mask =
        (uint16)(5, 11, 12, 11, 1, 11, 12, 1, 3, 14, 6, 6, 7, 9, 3, 7);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[4];
    uint16 mask =
        (uint16)(14, 14, 11, 8, 0, 9, 12, 14, 3, 0, 6, 6, 13, 14, 14, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[5];
    uint16 mask = (uint16)(14, 4, 9, 3, 5, 8, 13, 5, 8, 4, 14, 5, 8, 7, 3, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[6];
    uint16 mask = (uint16)(9, 4, 8, 4, 11, 2, 6, 0, 15, 8, 5, 13, 0, 0, 12, 0);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[7];
    uint16 mask = (uint16)(7, 5, 11, 14, 3, 8, 5, 0, 1, 7, 7, 15, 0, 1, 10, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[8];
    uint16 mask = (uint16)(9, 0, 9, 11, 7, 7, 11, 7, 5, 5, 11, 3, 1, 5, 1, 8);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[9];
    uint16 mask =
        (uint16)(6, 2, 5, 11, 15, 11, 13, 1, 3, 4, 15, 2, 10, 3, 9, 11);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[10];
    uint16 mask =
        (uint16)(11, 9, 0, 0, 11, 15, 13, 8, 0, 4, 8, 10, 13, 2, 14, 12);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[11];
    uint16 mask =
        (uint16)(2, 4, 3, 0, 3, 2, 12, 10, 11, 14, 7, 10, 10, 8, 0, 12);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[12];
    uint16 mask =
        (uint16)(13, 0, 12, 3, 0, 12, 4, 14, 5, 14, 13, 13, 11, 8, 13, 7);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[13];
    uint16 mask = (uint16)(2, 1, 9, 15, 4, 8, 4, 9, 15, 10, 7, 10, 0, 1, 0, 8);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[14];
    uint16 mask = (uint16)(7, 6, 13, 0, 1, 15, 11, 10, 4, 8, 6, 2, 13, 1, 5, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[15];
    uint16 mask =
        (uint16)(12, 1, 13, 6, 10, 6, 14, 14, 10, 11, 12, 1, 2, 12, 11, 7);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[16];
    uint16 mask = (uint16)(10, 0, 0, 5, 15, 3, 5, 4, 1, 2, 2, 11, 4, 5, 5, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[17];
    uint16 mask =
        (uint16)(11, 13, 12, 13, 15, 9, 2, 2, 4, 8, 14, 6, 12, 12, 14, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[18];
    uint16 mask =
        (uint16)(14, 11, 6, 8, 15, 11, 13, 9, 14, 12, 9, 11, 11, 8, 14, 13);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[19];
    uint16 mask =
        (uint16)(8, 0, 2, 2, 12, 11, 8, 13, 0, 2, 15, 12, 2, 7, 15, 2);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[20];
    uint16 mask = (uint16)(14, 13, 8, 7, 0, 4, 1, 11, 5, 8, 7, 6, 14, 0, 6, 7);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[21];
    uint16 mask =
        (uint16)(12, 14, 0, 15, 8, 6, 1, 13, 14, 7, 9, 11, 3, 11, 8, 7);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[22];
    uint16 mask =
        (uint16)(10, 2, 4, 1, 6, 13, 1, 15, 12, 8, 9, 3, 15, 7, 14, 6);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[23];
    uint16 mask =
        (uint16)(11, 6, 10, 2, 7, 15, 3, 15, 7, 14, 2, 0, 13, 10, 12, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[24];
    uint16 mask =
        (uint16)(11, 6, 9, 4, 4, 13, 14, 6, 15, 2, 2, 9, 4, 5, 10, 11);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[25];
    uint16 mask =
        (uint16)(11, 3, 7, 6, 5, 9, 11, 14, 7, 9, 10, 14, 10, 9, 8, 6);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[26];
    uint16 mask =
        (uint16)(6, 0, 7, 2, 5, 13, 9, 3, 3, 15, 15, 10, 6, 13, 1, 12);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[27];
    uint16 mask =
        (uint16)(11, 0, 0, 12, 1, 14, 8, 10, 8, 7, 4, 15, 15, 3, 1, 9);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[28];
    uint16 mask =
        (uint16)(10, 4, 9, 15, 15, 11, 11, 12, 5, 9, 0, 1, 6, 1, 15, 14);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[29];
    uint16 mask = (uint16)(10, 7, 4, 5, 0, 1, 0, 6, 12, 15, 11, 8, 3, 6, 3, 0);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[30];
    uint16 mask =
        (uint16)(2, 2, 14, 5, 11, 13, 11, 14, 14, 9, 15, 2, 10, 13, 9, 15);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[31];
    uint16 mask =
        (uint16)(8, 5, 2, 13, 14, 15, 3, 12, 10, 15, 12, 0, 9, 4, 10, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
