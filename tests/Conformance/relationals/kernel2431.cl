// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar2 *source, __global uchar16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar2 src1 /*, src2*/;
  uchar16 tmp;
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[0];
    uchar16 mask = (uchar16)(1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[1];
    uchar16 mask = (uchar16)(0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[2];
    uchar16 mask = (uchar16)(0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[3];
    uchar16 mask = (uchar16)(1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[4];
    uchar16 mask = (uchar16)(0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[5];
    uchar16 mask = (uchar16)(1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[6];
    uchar16 mask = (uchar16)(1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[7];
    uchar16 mask = (uchar16)(0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[8];
    uchar16 mask = (uchar16)(0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[9];
    uchar16 mask = (uchar16)(0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[10];
    uchar16 mask = (uchar16)(1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[11];
    uchar16 mask = (uchar16)(1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[12];
    uchar16 mask = (uchar16)(0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[13];
    uchar16 mask = (uchar16)(1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[14];
    uchar16 mask = (uchar16)(0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[15];
    uchar16 mask = (uchar16)(1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[16];
    uchar16 mask = (uchar16)(0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[17];
    uchar16 mask = (uchar16)(1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[18];
    uchar16 mask = (uchar16)(0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[19];
    uchar16 mask = (uchar16)(0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[20];
    uchar16 mask = (uchar16)(1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[21];
    uchar16 mask = (uchar16)(1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[22];
    uchar16 mask = (uchar16)(1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[23];
    uchar16 mask = (uchar16)(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[24];
    uchar16 mask = (uchar16)(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[25];
    uchar16 mask = (uchar16)(0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[26];
    uchar16 mask = (uchar16)(1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[27];
    uchar16 mask = (uchar16)(0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[28];
    uchar16 mask = (uchar16)(0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[29];
    uchar16 mask = (uchar16)(0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[30];
    uchar16 mask = (uchar16)(0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar2 src1 = source[31];
    uchar16 mask = (uchar16)(0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
