// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong8 *source, __global ulong16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong8 src1 /*, src2*/;
  ulong16 tmp;
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[0];
    ulong16 mask = (ulong16)(1, 6, 6, 5, 4, 6, 0, 7, 4, 2, 1, 5, 1, 7, 7, 3);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[1];
    ulong16 mask = (ulong16)(1, 5, 0, 2, 7, 2, 3, 4, 4, 0, 1, 1, 0, 7, 3, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[2];
    ulong16 mask = (ulong16)(6, 7, 2, 1, 5, 6, 6, 4, 7, 4, 4, 0, 3, 6, 2, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[3];
    ulong16 mask = (ulong16)(7, 1, 5, 1, 1, 1, 1, 5, 1, 2, 7, 3, 4, 1, 6, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[4];
    ulong16 mask = (ulong16)(2, 0, 1, 4, 1, 1, 0, 2, 2, 5, 6, 0, 0, 6, 1, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[5];
    ulong16 mask = (ulong16)(5, 0, 2, 7, 4, 6, 5, 4, 6, 3, 3, 0, 7, 0, 0, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[6];
    ulong16 mask = (ulong16)(0, 0, 1, 3, 0, 6, 4, 0, 3, 2, 7, 6, 3, 4, 7, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[7];
    ulong16 mask = (ulong16)(6, 4, 7, 3, 7, 6, 0, 4, 1, 1, 5, 3, 4, 2, 6, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[8];
    ulong16 mask = (ulong16)(0, 7, 4, 3, 7, 4, 1, 2, 2, 7, 4, 6, 4, 4, 7, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[9];
    ulong16 mask = (ulong16)(4, 0, 7, 5, 0, 1, 7, 5, 5, 3, 6, 7, 1, 5, 3, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[10];
    ulong16 mask = (ulong16)(0, 4, 6, 5, 6, 3, 2, 3, 1, 2, 5, 3, 2, 2, 5, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[11];
    ulong16 mask = (ulong16)(0, 6, 3, 4, 2, 4, 7, 7, 0, 2, 3, 5, 7, 6, 4, 6);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[12];
    ulong16 mask = (ulong16)(4, 0, 5, 2, 3, 6, 7, 0, 3, 1, 5, 7, 7, 5, 7, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[13];
    ulong16 mask = (ulong16)(5, 3, 0, 1, 7, 3, 1, 7, 2, 6, 0, 0, 4, 7, 6, 3);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[14];
    ulong16 mask = (ulong16)(0, 7, 6, 4, 4, 1, 5, 5, 2, 2, 7, 1, 2, 2, 4, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[15];
    ulong16 mask = (ulong16)(1, 7, 0, 5, 2, 5, 6, 6, 6, 2, 5, 6, 0, 7, 6, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[16];
    ulong16 mask = (ulong16)(6, 7, 7, 6, 6, 6, 7, 1, 4, 6, 2, 4, 0, 3, 6, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[17];
    ulong16 mask = (ulong16)(3, 7, 5, 0, 7, 0, 3, 7, 3, 1, 6, 6, 0, 4, 1, 4);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[18];
    ulong16 mask = (ulong16)(3, 3, 6, 4, 1, 5, 5, 3, 6, 2, 7, 3, 4, 0, 2, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[19];
    ulong16 mask = (ulong16)(0, 6, 1, 0, 0, 1, 4, 7, 7, 0, 7, 1, 0, 3, 6, 4);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[20];
    ulong16 mask = (ulong16)(3, 6, 0, 1, 2, 5, 3, 7, 7, 2, 4, 5, 5, 4, 2, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[21];
    ulong16 mask = (ulong16)(5, 7, 5, 1, 5, 6, 2, 1, 6, 3, 2, 2, 5, 4, 1, 6);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[22];
    ulong16 mask = (ulong16)(0, 4, 4, 2, 1, 1, 2, 3, 0, 4, 7, 4, 4, 1, 3, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[23];
    ulong16 mask = (ulong16)(4, 7, 3, 6, 7, 1, 0, 0, 3, 7, 1, 5, 3, 1, 1, 4);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[24];
    ulong16 mask = (ulong16)(3, 3, 1, 4, 1, 2, 7, 6, 4, 4, 5, 0, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[25];
    ulong16 mask = (ulong16)(7, 7, 6, 2, 2, 5, 7, 6, 6, 1, 6, 0, 7, 7, 3, 5);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[26];
    ulong16 mask = (ulong16)(6, 6, 7, 3, 5, 6, 5, 7, 6, 4, 4, 6, 3, 6, 1, 6);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[27];
    ulong16 mask = (ulong16)(6, 6, 1, 6, 2, 4, 4, 2, 0, 6, 5, 5, 3, 4, 6, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[28];
    ulong16 mask = (ulong16)(0, 2, 3, 4, 4, 7, 0, 3, 6, 5, 2, 6, 1, 2, 2, 4);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[29];
    ulong16 mask = (ulong16)(1, 0, 5, 5, 5, 3, 7, 4, 1, 4, 0, 6, 7, 0, 7, 5);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[30];
    ulong16 mask = (ulong16)(1, 5, 0, 7, 3, 4, 1, 6, 6, 3, 3, 0, 3, 3, 6, 5);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong8 src1 = source[31];
    ulong16 mask = (ulong16)(3, 5, 0, 6, 3, 7, 2, 0, 4, 2, 6, 2, 3, 1, 4, 5);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
