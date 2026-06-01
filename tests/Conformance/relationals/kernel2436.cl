// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar4 *source, __global uchar8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar4 src1 /*, src2*/;
  uchar8 tmp;
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[0];
    uchar8 mask = (uchar8)(0, 0, 0, 0, 2, 2, 0, 3);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[1];
    uchar8 mask = (uchar8)(0, 1, 0, 0, 1, 3, 3, 1);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[2];
    uchar8 mask = (uchar8)(1, 2, 1, 0, 0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[3];
    uchar8 mask = (uchar8)(0, 3, 3, 3, 0, 3, 0, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[4];
    uchar8 mask = (uchar8)(1, 3, 1, 2, 3, 3, 3, 2);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[5];
    uchar8 mask = (uchar8)(2, 0, 1, 3, 1, 0, 2, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[6];
    uchar8 mask = (uchar8)(2, 2, 1, 1, 2, 3, 3, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[7];
    uchar8 mask = (uchar8)(2, 1, 2, 3, 0, 3, 0, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[8];
    uchar8 mask = (uchar8)(0, 2, 2, 0, 0, 3, 0, 2);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[9];
    uchar8 mask = (uchar8)(1, 0, 2, 2, 2, 1, 3, 2);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[10];
    uchar8 mask = (uchar8)(2, 0, 2, 3, 1, 0, 0, 3);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[11];
    uchar8 mask = (uchar8)(2, 1, 2, 1, 0, 1, 2, 3);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[12];
    uchar8 mask = (uchar8)(0, 0, 2, 1, 0, 1, 0, 3);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[13];
    uchar8 mask = (uchar8)(0, 2, 3, 2, 2, 3, 1, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[14];
    uchar8 mask = (uchar8)(0, 0, 2, 3, 0, 3, 3, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[15];
    uchar8 mask = (uchar8)(1, 3, 2, 3, 1, 0, 2, 0);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[16];
    uchar8 mask = (uchar8)(2, 1, 2, 3, 3, 0, 2, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[17];
    uchar8 mask = (uchar8)(2, 3, 1, 3, 3, 2, 2, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[18];
    uchar8 mask = (uchar8)(1, 1, 2, 3, 0, 3, 1, 3);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[19];
    uchar8 mask = (uchar8)(1, 3, 2, 2, 2, 3, 1, 3);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[20];
    uchar8 mask = (uchar8)(0, 1, 2, 3, 3, 2, 1, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[21];
    uchar8 mask = (uchar8)(1, 3, 1, 1, 3, 1, 0, 3);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[22];
    uchar8 mask = (uchar8)(0, 3, 3, 2, 2, 1, 2, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[23];
    uchar8 mask = (uchar8)(3, 3, 3, 0, 0, 1, 3, 2);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[24];
    uchar8 mask = (uchar8)(1, 1, 2, 2, 2, 3, 3, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[25];
    uchar8 mask = (uchar8)(0, 2, 0, 2, 2, 3, 2, 2);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[26];
    uchar8 mask = (uchar8)(2, 3, 3, 0, 1, 0, 1, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[27];
    uchar8 mask = (uchar8)(3, 0, 1, 1, 2, 3, 3, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[28];
    uchar8 mask = (uchar8)(0, 2, 0, 2, 1, 0, 3, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[29];
    uchar8 mask = (uchar8)(2, 3, 3, 1, 2, 3, 1, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[30];
    uchar8 mask = (uchar8)(3, 2, 2, 3, 3, 3, 2, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar8)((uchar)0);
  {
    uchar4 src1 = source[31];
    uchar8 mask = (uchar8)(1, 1, 1, 1, 0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
