// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar2 *secondSource,
                          __global uchar2 *source, __global uchar4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar2 src1 , src2;
  uchar4 tmp;
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[0];
    uchar2 src2 = secondSource[0];
    uchar4 mask = (uchar4)(0, 2, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[1];
    uchar2 src2 = secondSource[1];
    uchar4 mask = (uchar4)(1, 2, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[2];
    uchar2 src2 = secondSource[2];
    uchar4 mask = (uchar4)(2, 3, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[3];
    uchar2 src2 = secondSource[3];
    uchar4 mask = (uchar4)(0, 2, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[4];
    uchar2 src2 = secondSource[4];
    uchar4 mask = (uchar4)(2, 3, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[5];
    uchar2 src2 = secondSource[5];
    uchar4 mask = (uchar4)(0, 3, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[6];
    uchar2 src2 = secondSource[6];
    uchar4 mask = (uchar4)(1, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[7];
    uchar2 src2 = secondSource[7];
    uchar4 mask = (uchar4)(2, 0, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[8];
    uchar2 src2 = secondSource[8];
    uchar4 mask = (uchar4)(0, 0, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[9];
    uchar2 src2 = secondSource[9];
    uchar4 mask = (uchar4)(0, 2, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[10];
    uchar2 src2 = secondSource[10];
    uchar4 mask = (uchar4)(1, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[11];
    uchar2 src2 = secondSource[11];
    uchar4 mask = (uchar4)(1, 1, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[12];
    uchar2 src2 = secondSource[12];
    uchar4 mask = (uchar4)(0, 2, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[13];
    uchar2 src2 = secondSource[13];
    uchar4 mask = (uchar4)(0, 3, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[14];
    uchar2 src2 = secondSource[14];
    uchar4 mask = (uchar4)(1, 2, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[15];
    uchar2 src2 = secondSource[15];
    uchar4 mask = (uchar4)(3, 1, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[16];
    uchar2 src2 = secondSource[16];
    uchar4 mask = (uchar4)(1, 0, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[17];
    uchar2 src2 = secondSource[17];
    uchar4 mask = (uchar4)(0, 0, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[18];
    uchar2 src2 = secondSource[18];
    uchar4 mask = (uchar4)(0, 2, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[19];
    uchar2 src2 = secondSource[19];
    uchar4 mask = (uchar4)(0, 1, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[20];
    uchar2 src2 = secondSource[20];
    uchar4 mask = (uchar4)(2, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[21];
    uchar2 src2 = secondSource[21];
    uchar4 mask = (uchar4)(0, 3, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[22];
    uchar2 src2 = secondSource[22];
    uchar4 mask = (uchar4)(3, 0, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[23];
    uchar2 src2 = secondSource[23];
    uchar4 mask = (uchar4)(2, 3, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[24];
    uchar2 src2 = secondSource[24];
    uchar4 mask = (uchar4)(0, 0, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[25];
    uchar2 src2 = secondSource[25];
    uchar4 mask = (uchar4)(3, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[26];
    uchar2 src2 = secondSource[26];
    uchar4 mask = (uchar4)(2, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[27];
    uchar2 src2 = secondSource[27];
    uchar4 mask = (uchar4)(2, 1, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[28];
    uchar2 src2 = secondSource[28];
    uchar4 mask = (uchar4)(2, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[29];
    uchar2 src2 = secondSource[29];
    uchar4 mask = (uchar4)(3, 0, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[30];
    uchar2 src2 = secondSource[30];
    uchar4 mask = (uchar4)(1, 1, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar4)((uchar)0);
  {
    uchar2 src1 = source[31];
    uchar2 src2 = secondSource[31];
    uchar4 mask = (uchar4)(2, 1, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
