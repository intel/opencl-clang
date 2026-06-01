// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *source, __global uchar4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar8 src1 /*, src2*/;
  uchar4 tmp;
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[0];
    uchar4 mask = (uchar4)(1, 1, 3, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar4 mask = (uchar4)(3, 3, 6, 5);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar4 mask = (uchar4)(4, 5, 3, 2);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar4 mask = (uchar4)(4, 7, 1, 4);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar4 mask = (uchar4)(4, 2, 2, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar4 mask = (uchar4)(0, 6, 6, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar4 mask = (uchar4)(2, 7, 2, 7);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar4 mask = (uchar4)(0, 6, 0, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar4 mask = (uchar4)(2, 5, 2, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar4 mask = (uchar4)(5, 3, 2, 4);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar4 mask = (uchar4)(6, 6, 4, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar4 mask = (uchar4)(2, 3, 1, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar4 mask = (uchar4)(0, 0, 3, 4);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar4 mask = (uchar4)(3, 4, 2, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar4 mask = (uchar4)(6, 6, 0, 5);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar4 mask = (uchar4)(0, 3, 1, 6);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar4 mask = (uchar4)(4, 2, 5, 5);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar4 mask = (uchar4)(7, 1, 2, 7);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar4 mask = (uchar4)(1, 4, 4, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar4 mask = (uchar4)(2, 5, 7, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar4 mask = (uchar4)(0, 3, 1, 2);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar4 mask = (uchar4)(6, 5, 3, 1);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar4 mask = (uchar4)(4, 2, 6, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar4 mask = (uchar4)(5, 1, 4, 5);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar4 mask = (uchar4)(5, 5, 0, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar4 mask = (uchar4)(0, 3, 4, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar4 mask = (uchar4)(2, 3, 7, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar4 mask = (uchar4)(6, 1, 7, 7);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar4 mask = (uchar4)(1, 0, 4, 2);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar4 mask = (uchar4)(0, 2, 5, 7);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar4 mask = (uchar4)(0, 1, 5, 4);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar4 mask = (uchar4)(1, 7, 4, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
