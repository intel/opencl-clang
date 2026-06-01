// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar4 *secondSource,
                          __global uchar4 *source, __global uchar16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uchar4 src1 , src2;
  uchar16 tmp;
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[0];
    uchar4 src2 = secondSource[0];
    uchar16 mask = (uchar16)(5, 0, 6, 1, 0, 4, 3, 0, 2, 6, 1, 0, 5, 1, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[1];
    uchar4 src2 = secondSource[1];
    uchar16 mask = (uchar16)(4, 3, 1, 3, 6, 5, 4, 2, 6, 1, 7, 7, 3, 2, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[2];
    uchar4 src2 = secondSource[2];
    uchar16 mask = (uchar16)(2, 6, 5, 5, 7, 4, 2, 5, 3, 6, 4, 4, 7, 0, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[3];
    uchar4 src2 = secondSource[3];
    uchar16 mask = (uchar16)(7, 1, 4, 6, 5, 1, 6, 7, 1, 5, 7, 2, 7, 1, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[4];
    uchar4 src2 = secondSource[4];
    uchar16 mask = (uchar16)(6, 1, 2, 3, 6, 3, 7, 0, 2, 5, 1, 0, 6, 6, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[5];
    uchar4 src2 = secondSource[5];
    uchar16 mask = (uchar16)(0, 4, 3, 6, 2, 2, 5, 7, 3, 4, 5, 0, 6, 2, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[6];
    uchar4 src2 = secondSource[6];
    uchar16 mask = (uchar16)(4, 5, 7, 1, 1, 3, 4, 0, 6, 1, 1, 6, 1, 4, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[7];
    uchar4 src2 = secondSource[7];
    uchar16 mask = (uchar16)(6, 0, 7, 0, 3, 6, 5, 0, 1, 6, 2, 5, 5, 4, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[8];
    uchar4 src2 = secondSource[8];
    uchar16 mask = (uchar16)(7, 7, 1, 1, 6, 6, 2, 6, 5, 5, 3, 7, 5, 7, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[9];
    uchar4 src2 = secondSource[9];
    uchar16 mask = (uchar16)(4, 1, 1, 5, 7, 3, 4, 0, 1, 6, 3, 2, 5, 7, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[10];
    uchar4 src2 = secondSource[10];
    uchar16 mask = (uchar16)(7, 6, 1, 6, 6, 3, 4, 0, 3, 7, 3, 7, 6, 3, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[11];
    uchar4 src2 = secondSource[11];
    uchar16 mask = (uchar16)(5, 3, 0, 7, 6, 3, 0, 7, 3, 0, 3, 2, 4, 4, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[12];
    uchar4 src2 = secondSource[12];
    uchar16 mask = (uchar16)(3, 0, 6, 0, 2, 6, 6, 4, 0, 1, 1, 3, 7, 1, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[13];
    uchar4 src2 = secondSource[13];
    uchar16 mask = (uchar16)(0, 6, 4, 3, 3, 7, 0, 5, 2, 2, 4, 0, 5, 5, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[14];
    uchar4 src2 = secondSource[14];
    uchar16 mask = (uchar16)(3, 2, 0, 5, 0, 0, 3, 6, 1, 1, 7, 0, 1, 7, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[15];
    uchar4 src2 = secondSource[15];
    uchar16 mask = (uchar16)(4, 0, 2, 5, 5, 7, 4, 4, 7, 6, 6, 7, 4, 7, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[16];
    uchar4 src2 = secondSource[16];
    uchar16 mask = (uchar16)(4, 6, 4, 6, 2, 7, 1, 6, 4, 5, 2, 2, 3, 2, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[17];
    uchar4 src2 = secondSource[17];
    uchar16 mask = (uchar16)(5, 3, 0, 6, 5, 3, 1, 5, 1, 7, 4, 1, 7, 2, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[18];
    uchar4 src2 = secondSource[18];
    uchar16 mask = (uchar16)(6, 6, 0, 6, 4, 6, 5, 2, 3, 0, 1, 1, 0, 1, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[19];
    uchar4 src2 = secondSource[19];
    uchar16 mask = (uchar16)(5, 4, 7, 1, 3, 3, 2, 4, 2, 6, 0, 4, 3, 3, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[20];
    uchar4 src2 = secondSource[20];
    uchar16 mask = (uchar16)(4, 4, 0, 6, 5, 3, 5, 0, 4, 4, 7, 6, 2, 2, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[21];
    uchar4 src2 = secondSource[21];
    uchar16 mask = (uchar16)(1, 3, 2, 2, 1, 0, 7, 2, 6, 6, 3, 6, 3, 6, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[22];
    uchar4 src2 = secondSource[22];
    uchar16 mask = (uchar16)(5, 6, 7, 6, 6, 6, 1, 1, 2, 5, 3, 7, 3, 1, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[23];
    uchar4 src2 = secondSource[23];
    uchar16 mask = (uchar16)(6, 7, 6, 5, 5, 2, 0, 5, 7, 7, 2, 7, 0, 6, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[24];
    uchar4 src2 = secondSource[24];
    uchar16 mask = (uchar16)(5, 4, 5, 7, 3, 5, 6, 0, 2, 2, 4, 3, 7, 3, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[25];
    uchar4 src2 = secondSource[25];
    uchar16 mask = (uchar16)(0, 1, 6, 5, 7, 1, 6, 0, 3, 3, 6, 6, 0, 6, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[26];
    uchar4 src2 = secondSource[26];
    uchar16 mask = (uchar16)(6, 2, 0, 7, 3, 0, 6, 0, 3, 0, 0, 2, 3, 6, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[27];
    uchar4 src2 = secondSource[27];
    uchar16 mask = (uchar16)(2, 7, 7, 2, 7, 3, 1, 0, 0, 4, 2, 0, 3, 3, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[28];
    uchar4 src2 = secondSource[28];
    uchar16 mask = (uchar16)(1, 1, 7, 1, 5, 2, 4, 6, 5, 7, 0, 7, 1, 1, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[29];
    uchar4 src2 = secondSource[29];
    uchar16 mask = (uchar16)(5, 3, 6, 4, 4, 2, 4, 6, 3, 7, 6, 7, 6, 2, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[30];
    uchar4 src2 = secondSource[30];
    uchar16 mask = (uchar16)(3, 4, 0, 7, 6, 3, 5, 0, 3, 5, 4, 1, 7, 2, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (uchar16)((uchar)0);
  {
    uchar4 src1 = source[31];
    uchar4 src2 = secondSource[31];
    uchar16 mask = (uchar16)(1, 7, 6, 1, 4, 6, 0, 0, 2, 0, 5, 3, 7, 4, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
