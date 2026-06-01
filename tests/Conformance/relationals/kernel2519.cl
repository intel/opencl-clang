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
        (ushort16)(3, 13, 9, 9, 7, 5, 10, 9, 4, 4, 0, 5, 6, 2, 3, 14);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort16 mask =
        (ushort16)(5, 8, 15, 13, 15, 11, 4, 2, 4, 10, 2, 5, 14, 8, 3, 11);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort16 mask =
        (ushort16)(6, 2, 11, 12, 11, 8, 15, 14, 2, 0, 6, 7, 9, 1, 12, 13);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort16 mask =
        (ushort16)(5, 15, 14, 0, 15, 6, 15, 4, 2, 4, 2, 7, 5, 8, 6, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort16 mask =
        (ushort16)(15, 8, 12, 0, 10, 0, 11, 13, 5, 2, 10, 2, 0, 2, 4, 15);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort16 mask =
        (ushort16)(15, 10, 8, 6, 12, 7, 9, 4, 12, 10, 7, 8, 15, 9, 14, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort16 mask =
        (ushort16)(13, 4, 1, 12, 0, 3, 5, 0, 8, 0, 5, 9, 10, 15, 3, 9);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort16 mask =
        (ushort16)(6, 1, 11, 9, 5, 12, 15, 5, 8, 15, 12, 9, 9, 13, 10, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort16 mask =
        (ushort16)(10, 5, 0, 12, 12, 6, 3, 0, 4, 11, 2, 9, 7, 5, 7, 11);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort16 mask =
        (ushort16)(4, 11, 15, 1, 14, 2, 1, 8, 11, 2, 5, 8, 10, 12, 13, 14);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort16 mask =
        (ushort16)(11, 10, 0, 5, 14, 14, 9, 13, 13, 1, 15, 3, 12, 8, 8, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort16 mask =
        (ushort16)(2, 9, 12, 9, 8, 3, 14, 12, 14, 6, 1, 0, 10, 4, 10, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort16 mask =
        (ushort16)(8, 15, 3, 9, 4, 6, 9, 7, 14, 8, 15, 14, 11, 0, 0, 12);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort16 mask =
        (ushort16)(2, 8, 0, 0, 1, 15, 5, 8, 3, 1, 11, 5, 1, 15, 13, 8);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort16 mask =
        (ushort16)(2, 9, 7, 9, 15, 7, 0, 10, 14, 15, 14, 10, 9, 1, 12, 11);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort16 mask =
        (ushort16)(3, 6, 7, 10, 15, 9, 8, 15, 15, 8, 9, 10, 4, 7, 8, 9);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort16 mask =
        (ushort16)(5, 3, 4, 14, 10, 0, 14, 8, 3, 13, 5, 6, 2, 15, 1, 13);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort16 mask =
        (ushort16)(6, 9, 14, 9, 7, 11, 7, 1, 15, 11, 15, 3, 8, 6, 11, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort16 mask =
        (ushort16)(10, 6, 5, 14, 13, 12, 8, 10, 10, 4, 6, 6, 0, 0, 5, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort16 mask =
        (ushort16)(4, 7, 2, 8, 2, 1, 14, 7, 10, 11, 7, 2, 13, 3, 5, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort16 mask =
        (ushort16)(4, 13, 13, 10, 7, 2, 1, 5, 0, 5, 11, 15, 10, 15, 12, 2);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort16 mask =
        (ushort16)(0, 13, 4, 4, 10, 0, 10, 0, 7, 15, 1, 2, 6, 11, 8, 14);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort16 mask =
        (ushort16)(15, 15, 6, 9, 10, 9, 13, 15, 7, 2, 2, 11, 12, 5, 15, 10);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort16 mask =
        (ushort16)(10, 12, 9, 5, 14, 8, 14, 1, 4, 13, 13, 13, 3, 12, 3, 2);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort16 mask =
        (ushort16)(6, 7, 3, 3, 12, 5, 9, 1, 15, 2, 5, 4, 12, 13, 14, 2);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort16 mask =
        (ushort16)(10, 5, 10, 0, 6, 9, 7, 8, 9, 11, 3, 11, 0, 11, 1, 7);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort16 mask =
        (ushort16)(15, 15, 9, 5, 0, 11, 1, 14, 12, 9, 5, 5, 11, 1, 11, 15);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort16 mask =
        (ushort16)(11, 6, 0, 1, 4, 8, 4, 7, 1, 6, 7, 13, 14, 15, 1, 15);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort16 mask =
        (ushort16)(3, 3, 7, 9, 6, 1, 10, 0, 3, 13, 6, 5, 13, 1, 9, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort16 mask =
        (ushort16)(7, 11, 9, 2, 8, 11, 8, 3, 0, 4, 15, 8, 0, 7, 5, 11);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort16 mask =
        (ushort16)(15, 6, 8, 3, 7, 12, 11, 9, 1, 5, 13, 0, 9, 9, 14, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort16 mask =
        (ushort16)(15, 0, 14, 5, 15, 1, 5, 5, 9, 12, 14, 6, 3, 9, 1, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
