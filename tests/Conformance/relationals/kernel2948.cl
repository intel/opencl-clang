// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong4 *secondSource,
                          __global ulong4 *source, __global ulong8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong4 src1 , src2;
  ulong8 tmp;
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[0];
    ulong4 src2 = secondSource[0];
    ulong8 mask = (ulong8)(6, 7, 4, 5, 5, 5, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[1];
    ulong4 src2 = secondSource[1];
    ulong8 mask = (ulong8)(7, 7, 3, 4, 6, 4, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[2];
    ulong4 src2 = secondSource[2];
    ulong8 mask = (ulong8)(1, 4, 4, 0, 4, 2, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[3];
    ulong4 src2 = secondSource[3];
    ulong8 mask = (ulong8)(3, 5, 1, 3, 0, 3, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[4];
    ulong4 src2 = secondSource[4];
    ulong8 mask = (ulong8)(5, 1, 2, 5, 0, 7, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[5];
    ulong4 src2 = secondSource[5];
    ulong8 mask = (ulong8)(7, 4, 0, 7, 1, 1, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[6];
    ulong4 src2 = secondSource[6];
    ulong8 mask = (ulong8)(6, 0, 2, 0, 3, 6, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[7];
    ulong4 src2 = secondSource[7];
    ulong8 mask = (ulong8)(6, 6, 2, 1, 0, 2, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[8];
    ulong4 src2 = secondSource[8];
    ulong8 mask = (ulong8)(3, 1, 1, 6, 0, 2, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[9];
    ulong4 src2 = secondSource[9];
    ulong8 mask = (ulong8)(4, 1, 6, 3, 3, 3, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[10];
    ulong4 src2 = secondSource[10];
    ulong8 mask = (ulong8)(4, 5, 6, 2, 6, 5, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[11];
    ulong4 src2 = secondSource[11];
    ulong8 mask = (ulong8)(4, 5, 0, 0, 6, 3, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[12];
    ulong4 src2 = secondSource[12];
    ulong8 mask = (ulong8)(0, 6, 4, 5, 0, 7, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[13];
    ulong4 src2 = secondSource[13];
    ulong8 mask = (ulong8)(5, 4, 0, 4, 3, 3, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[14];
    ulong4 src2 = secondSource[14];
    ulong8 mask = (ulong8)(3, 2, 5, 0, 2, 3, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[15];
    ulong4 src2 = secondSource[15];
    ulong8 mask = (ulong8)(4, 4, 2, 7, 0, 5, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[16];
    ulong4 src2 = secondSource[16];
    ulong8 mask = (ulong8)(2, 0, 7, 7, 4, 6, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[17];
    ulong4 src2 = secondSource[17];
    ulong8 mask = (ulong8)(1, 0, 5, 7, 1, 5, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[18];
    ulong4 src2 = secondSource[18];
    ulong8 mask = (ulong8)(3, 4, 3, 3, 6, 2, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[19];
    ulong4 src2 = secondSource[19];
    ulong8 mask = (ulong8)(6, 2, 7, 2, 6, 7, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[20];
    ulong4 src2 = secondSource[20];
    ulong8 mask = (ulong8)(3, 6, 4, 2, 0, 6, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[21];
    ulong4 src2 = secondSource[21];
    ulong8 mask = (ulong8)(3, 6, 0, 2, 2, 6, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[22];
    ulong4 src2 = secondSource[22];
    ulong8 mask = (ulong8)(6, 7, 3, 2, 1, 0, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[23];
    ulong4 src2 = secondSource[23];
    ulong8 mask = (ulong8)(1, 0, 0, 6, 2, 5, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[24];
    ulong4 src2 = secondSource[24];
    ulong8 mask = (ulong8)(5, 5, 2, 5, 2, 2, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[25];
    ulong4 src2 = secondSource[25];
    ulong8 mask = (ulong8)(1, 0, 2, 3, 0, 2, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[26];
    ulong4 src2 = secondSource[26];
    ulong8 mask = (ulong8)(0, 7, 6, 4, 2, 4, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[27];
    ulong4 src2 = secondSource[27];
    ulong8 mask = (ulong8)(3, 3, 6, 5, 7, 1, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[28];
    ulong4 src2 = secondSource[28];
    ulong8 mask = (ulong8)(4, 1, 3, 3, 1, 6, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[29];
    ulong4 src2 = secondSource[29];
    ulong8 mask = (ulong8)(4, 5, 1, 3, 4, 4, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[30];
    ulong4 src2 = secondSource[30];
    ulong8 mask = (ulong8)(0, 3, 3, 2, 0, 1, 6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong8)((ulong)0);
  {
    ulong4 src1 = source[31];
    ulong4 src2 = secondSource[31];
    ulong8 mask = (ulong8)(5, 0, 1, 3, 2, 3, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
