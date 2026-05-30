// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *source, __global uchar16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar8 src1 /*, src2*/;
  uchar16 tmp;
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[0];
    uchar16 mask = (uchar16)(3, 6, 2, 4, 4, 3, 0, 2, 2, 1, 6, 0, 5, 1, 0, 2);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar16 mask = (uchar16)(4, 6, 1, 6, 7, 3, 6, 0, 1, 3, 3, 7, 3, 5, 1, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar16 mask = (uchar16)(5, 5, 6, 4, 0, 6, 1, 3, 2, 1, 7, 6, 3, 6, 1, 5);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar16 mask = (uchar16)(0, 0, 7, 3, 6, 1, 4, 3, 4, 7, 6, 1, 2, 3, 5, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar16 mask = (uchar16)(5, 0, 4, 1, 1, 3, 7, 6, 6, 2, 3, 4, 4, 3, 6, 4);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar16 mask = (uchar16)(3, 3, 5, 5, 6, 2, 3, 7, 1, 4, 4, 1, 4, 5, 4, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar16 mask = (uchar16)(0, 0, 6, 2, 4, 6, 3, 3, 6, 3, 1, 7, 2, 5, 5, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar16 mask = (uchar16)(3, 4, 2, 3, 2, 2, 3, 4, 6, 7, 6, 3, 6, 0, 7, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar16 mask = (uchar16)(0, 1, 7, 2, 3, 4, 1, 0, 7, 0, 6, 4, 7, 6, 4, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar16 mask = (uchar16)(5, 1, 4, 7, 4, 5, 7, 5, 5, 6, 4, 4, 3, 7, 1, 2);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar16 mask = (uchar16)(0, 7, 2, 1, 5, 1, 1, 2, 1, 2, 0, 3, 6, 0, 1, 7);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar16 mask = (uchar16)(1, 7, 3, 1, 5, 5, 4, 5, 7, 2, 5, 7, 4, 5, 5, 2);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar16 mask = (uchar16)(5, 4, 6, 2, 4, 1, 6, 2, 7, 4, 5, 5, 2, 6, 2, 5);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar16 mask = (uchar16)(5, 2, 5, 2, 0, 4, 5, 6, 1, 4, 0, 6, 1, 4, 5, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar16 mask = (uchar16)(4, 6, 6, 3, 0, 5, 6, 6, 5, 5, 1, 0, 5, 3, 5, 4);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar16 mask = (uchar16)(0, 2, 2, 4, 5, 7, 3, 4, 6, 0, 4, 4, 6, 2, 0, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar16 mask = (uchar16)(5, 5, 3, 0, 4, 0, 2, 7, 2, 1, 1, 6, 2, 2, 1, 4);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar16 mask = (uchar16)(1, 2, 7, 1, 3, 3, 5, 6, 2, 6, 4, 5, 3, 7, 4, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar16 mask = (uchar16)(5, 3, 5, 1, 6, 2, 1, 1, 0, 0, 2, 7, 3, 6, 1, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar16 mask = (uchar16)(6, 5, 5, 0, 7, 6, 5, 4, 0, 1, 5, 3, 3, 0, 2, 4);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar16 mask = (uchar16)(4, 2, 2, 5, 4, 7, 4, 0, 4, 2, 0, 3, 2, 5, 6, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar16 mask = (uchar16)(2, 1, 4, 1, 2, 1, 1, 2, 1, 7, 5, 0, 5, 2, 7, 3);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar16 mask = (uchar16)(3, 7, 5, 2, 3, 2, 3, 4, 6, 0, 3, 0, 7, 1, 4, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar16 mask = (uchar16)(0, 4, 0, 4, 7, 6, 3, 3, 4, 5, 3, 5, 1, 7, 1, 2);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar16 mask = (uchar16)(1, 2, 4, 5, 4, 2, 2, 6, 0, 0, 2, 5, 3, 1, 6, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar16 mask = (uchar16)(5, 4, 1, 5, 1, 4, 5, 4, 5, 4, 4, 6, 0, 2, 2, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar16 mask = (uchar16)(0, 0, 6, 1, 6, 5, 7, 5, 0, 5, 7, 0, 7, 6, 7, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar16 mask = (uchar16)(6, 1, 2, 4, 2, 3, 5, 5, 5, 3, 5, 0, 2, 5, 4, 5);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar16 mask = (uchar16)(2, 5, 4, 7, 6, 2, 5, 1, 3, 4, 4, 6, 6, 5, 1, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar16 mask = (uchar16)(1, 1, 3, 1, 3, 3, 0, 7, 4, 3, 3, 7, 4, 3, 7, 0);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar16 mask = (uchar16)(2, 2, 0, 0, 1, 1, 2, 3, 6, 3, 4, 7, 7, 1, 2, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar16 mask = (uchar16)(0, 0, 2, 2, 7, 5, 5, 4, 7, 2, 4, 5, 2, 5, 7, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
