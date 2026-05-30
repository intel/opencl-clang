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
        (uint16)(8, 10, 14, 15, 6, 3, 15, 7, 11, 3, 1, 10, 5, 14, 13, 6);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[1];
    uint16 mask =
        (uint16)(7, 9, 15, 1, 3, 10, 15, 13, 10, 14, 14, 8, 3, 4, 11, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[2];
    uint16 mask = (uint16)(10, 9, 5, 8, 5, 8, 0, 14, 3, 7, 14, 14, 5, 4, 10, 9);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[3];
    uint16 mask =
        (uint16)(6, 14, 9, 8, 14, 13, 9, 10, 12, 14, 0, 12, 4, 5, 15, 11);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[4];
    uint16 mask =
        (uint16)(9, 11, 4, 9, 12, 8, 11, 6, 15, 13, 15, 3, 12, 3, 0, 15);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[5];
    uint16 mask =
        (uint16)(0, 0, 13, 10, 12, 7, 15, 3, 8, 11, 1, 2, 0, 7, 8, 10);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[6];
    uint16 mask =
        (uint16)(1, 6, 14, 13, 3, 6, 11, 1, 11, 12, 2, 1, 10, 0, 3, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[7];
    uint16 mask = (uint16)(6, 6, 10, 12, 13, 9, 1, 5, 0, 12, 5, 1, 11, 3, 3, 4);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[8];
    uint16 mask =
        (uint16)(7, 8, 1, 5, 12, 14, 10, 3, 14, 10, 14, 4, 11, 5, 8, 9);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[9];
    uint16 mask =
        (uint16)(15, 14, 15, 15, 6, 2, 1, 14, 8, 0, 9, 3, 15, 4, 12, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[10];
    uint16 mask = (uint16)(2, 6, 15, 5, 5, 1, 14, 4, 9, 10, 9, 1, 13, 2, 12, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[11];
    uint16 mask = (uint16)(12, 7, 11, 8, 8, 14, 0, 8, 9, 2, 12, 6, 1, 7, 13, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[12];
    uint16 mask = (uint16)(0, 3, 5, 1, 8, 4, 12, 5, 4, 6, 2, 15, 0, 5, 8, 13);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[13];
    uint16 mask =
        (uint16)(1, 10, 8, 15, 14, 11, 4, 7, 9, 3, 0, 9, 13, 9, 14, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[14];
    uint16 mask = (uint16)(12, 7, 14, 2, 6, 4, 5, 2, 0, 15, 2, 3, 9, 1, 12, 14);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[15];
    uint16 mask = (uint16)(11, 4, 4, 13, 3, 0, 3, 9, 7, 3, 14, 15, 3, 4, 4, 11);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[16];
    uint16 mask = (uint16)(0, 2, 5, 7, 15, 4, 5, 15, 0, 7, 6, 0, 13, 8, 1, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[17];
    uint16 mask = (uint16)(8, 1, 14, 4, 4, 15, 5, 13, 8, 4, 5, 12, 2, 7, 5, 8);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[18];
    uint16 mask = (uint16)(4, 6, 9, 0, 4, 10, 9, 1, 0, 0, 10, 5, 3, 5, 6, 8);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[19];
    uint16 mask =
        (uint16)(7, 3, 12, 0, 14, 2, 13, 12, 4, 0, 13, 7, 10, 13, 13, 13);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[20];
    uint16 mask =
        (uint16)(2, 9, 15, 1, 2, 11, 10, 2, 0, 7, 14, 2, 3, 5, 13, 12);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[21];
    uint16 mask =
        (uint16)(12, 7, 6, 5, 9, 0, 5, 15, 12, 4, 5, 13, 10, 12, 9, 11);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[22];
    uint16 mask =
        (uint16)(11, 14, 0, 12, 12, 1, 3, 10, 10, 4, 4, 2, 0, 10, 11, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[23];
    uint16 mask =
        (uint16)(1, 10, 9, 11, 8, 15, 1, 3, 12, 6, 12, 3, 6, 12, 7, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[24];
    uint16 mask = (uint16)(1, 7, 6, 0, 7, 2, 11, 9, 14, 14, 13, 7, 5, 0, 12, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[25];
    uint16 mask =
        (uint16)(13, 9, 1, 14, 4, 7, 10, 14, 14, 9, 12, 10, 3, 13, 5, 7);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[26];
    uint16 mask = (uint16)(5, 3, 7, 4, 6, 3, 5, 7, 9, 15, 15, 10, 10, 4, 6, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[27];
    uint16 mask =
        (uint16)(11, 13, 9, 14, 14, 5, 13, 13, 3, 2, 7, 13, 6, 6, 7, 10);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[28];
    uint16 mask =
        (uint16)(0, 14, 6, 9, 1, 13, 12, 2, 14, 1, 11, 4, 10, 12, 12, 15);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[29];
    uint16 mask = (uint16)(7, 9, 5, 5, 1, 1, 12, 2, 13, 8, 6, 3, 4, 13, 5, 11);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[30];
    uint16 mask =
        (uint16)(1, 11, 4, 2, 15, 12, 1, 3, 14, 7, 0, 13, 11, 3, 6, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int16 src1 = source[31];
    uint16 mask =
        (uint16)(3, 1, 3, 15, 12, 0, 4, 7, 11, 3, 12, 4, 2, 14, 10, 10);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
