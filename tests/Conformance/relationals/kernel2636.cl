// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong8 *source, __global ulong8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong8 src1 /*, src2*/;
  ulong8 tmp;
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[0];
    ulong8 mask = (ulong8)(4, 3, 4, 1, 7, 1, 5, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[1];
    ulong8 mask = (ulong8)(6, 2, 3, 3, 5, 5, 7, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[2];
    ulong8 mask = (ulong8)(3, 1, 1, 5, 5, 4, 1, 5);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[3];
    ulong8 mask = (ulong8)(0, 2, 7, 0, 1, 7, 1, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[4];
    ulong8 mask = (ulong8)(3, 0, 1, 3, 1, 0, 5, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[5];
    ulong8 mask = (ulong8)(1, 7, 0, 1, 7, 0, 1, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[6];
    ulong8 mask = (ulong8)(1, 3, 6, 2, 6, 7, 7, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[7];
    ulong8 mask = (ulong8)(6, 4, 2, 3, 0, 4, 4, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[8];
    ulong8 mask = (ulong8)(1, 1, 0, 3, 3, 1, 7, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[9];
    ulong8 mask = (ulong8)(0, 4, 3, 5, 7, 6, 0, 0);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[10];
    ulong8 mask = (ulong8)(7, 0, 7, 3, 5, 6, 5, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[11];
    ulong8 mask = (ulong8)(7, 4, 5, 3, 6, 0, 0, 4);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[12];
    ulong8 mask = (ulong8)(7, 0, 7, 5, 2, 6, 2, 2);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[13];
    ulong8 mask = (ulong8)(4, 3, 3, 4, 3, 4, 0, 4);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[14];
    ulong8 mask = (ulong8)(2, 0, 0, 2, 5, 4, 4, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[15];
    ulong8 mask = (ulong8)(3, 4, 1, 4, 6, 3, 3, 0);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[16];
    ulong8 mask = (ulong8)(6, 5, 4, 1, 4, 7, 1, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[17];
    ulong8 mask = (ulong8)(6, 3, 0, 2, 2, 1, 4, 4);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[18];
    ulong8 mask = (ulong8)(6, 1, 4, 1, 0, 5, 5, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[19];
    ulong8 mask = (ulong8)(0, 0, 3, 1, 7, 2, 1, 2);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[20];
    ulong8 mask = (ulong8)(4, 7, 2, 0, 1, 7, 5, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[21];
    ulong8 mask = (ulong8)(7, 4, 2, 2, 0, 4, 7, 2);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[22];
    ulong8 mask = (ulong8)(5, 5, 1, 0, 1, 2, 3, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[23];
    ulong8 mask = (ulong8)(3, 5, 3, 7, 2, 3, 2, 7);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[24];
    ulong8 mask = (ulong8)(0, 0, 1, 5, 2, 3, 1, 6);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[25];
    ulong8 mask = (ulong8)(1, 6, 7, 4, 1, 6, 3, 5);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[26];
    ulong8 mask = (ulong8)(7, 5, 5, 4, 7, 5, 0, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[27];
    ulong8 mask = (ulong8)(3, 3, 7, 7, 5, 0, 6, 2);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[28];
    ulong8 mask = (ulong8)(2, 4, 4, 7, 3, 3, 7, 4);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[29];
    ulong8 mask = (ulong8)(5, 7, 2, 0, 2, 2, 6, 2);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[30];
    ulong8 mask = (ulong8)(4, 3, 0, 7, 6, 0, 0, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong8 src1 = source[31];
    ulong8 mask = (ulong8)(2, 7, 1, 2, 7, 2, 6, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
