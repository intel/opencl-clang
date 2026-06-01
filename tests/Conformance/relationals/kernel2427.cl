// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar2 *source, __global uchar4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar2 src1 /*, src2*/;
  uchar4 tmp;
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[0];
    uchar4 mask = (uchar4)(0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[1];
    uchar4 mask = (uchar4)(0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[2];
    uchar4 mask = (uchar4)(1, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[3];
    uchar4 mask = (uchar4)(0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[4];
    uchar4 mask = (uchar4)(1, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[5];
    uchar4 mask = (uchar4)(0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[6];
    uchar4 mask = (uchar4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[7];
    uchar4 mask = (uchar4)(1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[8];
    uchar4 mask = (uchar4)(0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[9];
    uchar4 mask = (uchar4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[10];
    uchar4 mask = (uchar4)(0, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[11];
    uchar4 mask = (uchar4)(0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[12];
    uchar4 mask = (uchar4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[13];
    uchar4 mask = (uchar4)(0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[14];
    uchar4 mask = (uchar4)(0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[15];
    uchar4 mask = (uchar4)(1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[16];
    uchar4 mask = (uchar4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[17];
    uchar4 mask = (uchar4)(0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[18];
    uchar4 mask = (uchar4)(0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[19];
    uchar4 mask = (uchar4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[20];
    uchar4 mask = (uchar4)(1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[21];
    uchar4 mask = (uchar4)(0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[22];
    uchar4 mask = (uchar4)(1, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[23];
    uchar4 mask = (uchar4)(1, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[24];
    uchar4 mask = (uchar4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[25];
    uchar4 mask = (uchar4)(1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[26];
    uchar4 mask = (uchar4)(1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[27];
    uchar4 mask = (uchar4)(1, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[28];
    uchar4 mask = (uchar4)(1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[29];
    uchar4 mask = (uchar4)(1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[30];
    uchar4 mask = (uchar4)(0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[31];
    uchar4 mask = (uchar4)(1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
