// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *secondSource,
                          __global uchar8 *source, __global uchar2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar8 src1 , src2;
  uchar2 tmp;
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[0];
    uchar8 src2 = secondSource[0];
    uchar2 mask = (uchar2)(5, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[1];
    uchar8 src2 = secondSource[1];
    uchar2 mask = (uchar2)(15, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[2];
    uchar8 src2 = secondSource[2];
    uchar2 mask = (uchar2)(13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[3];
    uchar8 src2 = secondSource[3];
    uchar2 mask = (uchar2)(4, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[4];
    uchar8 src2 = secondSource[4];
    uchar2 mask = (uchar2)(3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[5];
    uchar8 src2 = secondSource[5];
    uchar2 mask = (uchar2)(5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[6];
    uchar8 src2 = secondSource[6];
    uchar2 mask = (uchar2)(5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[7];
    uchar8 src2 = secondSource[7];
    uchar2 mask = (uchar2)(2, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[8];
    uchar8 src2 = secondSource[8];
    uchar2 mask = (uchar2)(14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[9];
    uchar8 src2 = secondSource[9];
    uchar2 mask = (uchar2)(14, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[10];
    uchar8 src2 = secondSource[10];
    uchar2 mask = (uchar2)(13, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[11];
    uchar8 src2 = secondSource[11];
    uchar2 mask = (uchar2)(7, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[12];
    uchar8 src2 = secondSource[12];
    uchar2 mask = (uchar2)(12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[13];
    uchar8 src2 = secondSource[13];
    uchar2 mask = (uchar2)(5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[14];
    uchar8 src2 = secondSource[14];
    uchar2 mask = (uchar2)(13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[15];
    uchar8 src2 = secondSource[15];
    uchar2 mask = (uchar2)(14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[16];
    uchar8 src2 = secondSource[16];
    uchar2 mask = (uchar2)(8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[17];
    uchar8 src2 = secondSource[17];
    uchar2 mask = (uchar2)(7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[18];
    uchar8 src2 = secondSource[18];
    uchar2 mask = (uchar2)(8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[19];
    uchar8 src2 = secondSource[19];
    uchar2 mask = (uchar2)(3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[20];
    uchar8 src2 = secondSource[20];
    uchar2 mask = (uchar2)(1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[21];
    uchar8 src2 = secondSource[21];
    uchar2 mask = (uchar2)(6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[22];
    uchar8 src2 = secondSource[22];
    uchar2 mask = (uchar2)(12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[23];
    uchar8 src2 = secondSource[23];
    uchar2 mask = (uchar2)(10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[24];
    uchar8 src2 = secondSource[24];
    uchar2 mask = (uchar2)(13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[25];
    uchar8 src2 = secondSource[25];
    uchar2 mask = (uchar2)(7, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[26];
    uchar8 src2 = secondSource[26];
    uchar2 mask = (uchar2)(1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[27];
    uchar8 src2 = secondSource[27];
    uchar2 mask = (uchar2)(8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[28];
    uchar8 src2 = secondSource[28];
    uchar2 mask = (uchar2)(0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[29];
    uchar8 src2 = secondSource[29];
    uchar2 mask = (uchar2)(6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[30];
    uchar8 src2 = secondSource[30];
    uchar2 mask = (uchar2)(3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar2)((uchar)0);
  {
    uchar8 src1 = source[31];
    uchar8 src2 = secondSource[31];
    uchar2 mask = (uchar2)(13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
