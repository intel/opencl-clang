// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *source, __global uchar2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar8 src1 /*, src2*/;
  uchar2 tmp;
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[0];
    uchar2 mask = (uchar2)(2, 5);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar2 mask = (uchar2)(7, 6);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar2 mask = (uchar2)(6, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar2 mask = (uchar2)(2, 6);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar2 mask = (uchar2)(1, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar2 mask = (uchar2)(2, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar2 mask = (uchar2)(1, 5);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar2 mask = (uchar2)(7, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar2 mask = (uchar2)(7, 0);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar2 mask = (uchar2)(6, 4);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar2 mask = (uchar2)(3, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar2 mask = (uchar2)(6, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar2 mask = (uchar2)(2, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar2 mask = (uchar2)(6, 6);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar2 mask = (uchar2)(7, 5);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar2 mask = (uchar2)(4, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar2 mask = (uchar2)(3, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar2 mask = (uchar2)(4, 4);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar2 mask = (uchar2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar2 mask = (uchar2)(0, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar2 mask = (uchar2)(3, 1);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar2 mask = (uchar2)(6, 6);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar2 mask = (uchar2)(5, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar2 mask = (uchar2)(6, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar2 mask = (uchar2)(3, 6);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar2 mask = (uchar2)(0, 6);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar2 mask = (uchar2)(4, 3);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar2 mask = (uchar2)(0, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar2 mask = (uchar2)(3, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar2 mask = (uchar2)(1, 3);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar2 mask = (uchar2)(6, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
