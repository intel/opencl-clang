// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *source, __global ushort16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 /*, src2*/;
  ushort16 tmp;
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort16 mask =
        (ushort16)(1, 6, 2, 13, 4, 6, 10, 3, 4, 3, 10, 4, 0, 14, 3, 12);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 mask =
        (ushort16)(7, 7, 7, 5, 7, 2, 8, 0, 6, 8, 14, 15, 12, 15, 6, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 mask =
        (ushort16)(13, 12, 12, 15, 8, 0, 9, 15, 7, 13, 8, 12, 8, 12, 4, 12);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 mask =
        (ushort16)(5, 8, 15, 13, 15, 2, 1, 13, 13, 3, 13, 12, 10, 3, 14, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 mask =
        (ushort16)(15, 8, 5, 4, 14, 13, 6, 2, 6, 5, 8, 15, 14, 1, 5, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 mask =
        (ushort16)(10, 4, 6, 0, 10, 1, 13, 14, 5, 8, 3, 15, 14, 13, 6, 13);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 mask =
        (ushort16)(11, 15, 9, 0, 12, 15, 0, 12, 1, 0, 7, 15, 2, 13, 8, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 mask =
        (ushort16)(5, 9, 11, 4, 12, 11, 11, 10, 3, 0, 4, 6, 0, 11, 13, 10);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 mask =
        (ushort16)(8, 1, 4, 2, 10, 1, 15, 14, 1, 8, 11, 13, 6, 14, 5, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 mask =
        (ushort16)(6, 14, 3, 3, 3, 13, 5, 7, 14, 9, 0, 8, 4, 4, 3, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 mask =
        (ushort16)(9, 6, 3, 8, 0, 14, 2, 9, 5, 9, 12, 4, 13, 0, 10, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 mask =
        (ushort16)(6, 5, 10, 2, 3, 2, 12, 14, 7, 0, 15, 12, 4, 2, 10, 2);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 mask =
        (ushort16)(13, 12, 3, 10, 0, 12, 6, 3, 8, 1, 3, 14, 12, 7, 11, 15);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 mask =
        (ushort16)(9, 9, 15, 0, 9, 14, 6, 11, 2, 15, 15, 7, 7, 15, 5, 15);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 mask =
        (ushort16)(12, 15, 12, 9, 1, 10, 1, 10, 1, 6, 0, 3, 8, 3, 2, 8);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 mask =
        (ushort16)(10, 3, 13, 3, 8, 14, 13, 14, 5, 7, 12, 2, 13, 6, 3, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 mask =
        (ushort16)(15, 9, 11, 15, 0, 10, 2, 5, 13, 13, 9, 14, 7, 12, 8, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 mask =
        (ushort16)(4, 8, 9, 12, 0, 5, 15, 5, 15, 0, 3, 6, 5, 12, 5, 7);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 mask =
        (ushort16)(3, 8, 1, 4, 11, 2, 5, 6, 3, 3, 8, 6, 5, 11, 1, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 mask =
        (ushort16)(6, 1, 11, 7, 9, 5, 7, 2, 15, 12, 11, 11, 15, 15, 12, 10);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 mask =
        (ushort16)(2, 15, 3, 15, 1, 2, 6, 2, 7, 0, 15, 4, 14, 10, 3, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 mask =
        (ushort16)(6, 12, 8, 7, 9, 6, 3, 2, 4, 13, 9, 14, 5, 5, 11, 10);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 mask =
        (ushort16)(4, 0, 3, 7, 8, 8, 1, 7, 14, 4, 3, 9, 7, 12, 11, 13);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 mask =
        (ushort16)(9, 14, 4, 1, 14, 15, 7, 11, 10, 5, 2, 1, 4, 15, 2, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 mask =
        (ushort16)(9, 13, 1, 14, 6, 5, 6, 7, 2, 3, 2, 4, 5, 9, 8, 10);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 mask =
        (ushort16)(9, 3, 11, 9, 12, 6, 6, 5, 6, 5, 8, 3, 12, 13, 9, 6);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 mask =
        (ushort16)(2, 4, 2, 3, 1, 7, 0, 4, 12, 1, 2, 15, 0, 12, 11, 12);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 mask =
        (ushort16)(6, 8, 12, 5, 10, 3, 6, 8, 15, 2, 1, 1, 0, 8, 5, 3);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 mask =
        (ushort16)(15, 15, 0, 12, 0, 0, 14, 11, 14, 8, 13, 6, 10, 0, 14, 12);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 mask =
        (ushort16)(10, 4, 5, 5, 14, 14, 2, 3, 12, 3, 0, 12, 5, 10, 15, 3);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 mask =
        (ushort16)(1, 7, 10, 11, 14, 5, 3, 3, 3, 6, 12, 8, 2, 13, 13, 7);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 mask =
        (ushort16)(10, 4, 13, 5, 15, 12, 10, 2, 14, 13, 11, 14, 0, 2, 0, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
