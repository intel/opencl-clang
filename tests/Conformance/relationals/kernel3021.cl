// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *secondSource,
                          __global double8 *source, __global double8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double8 src1 , src2;
  double8 tmp;
  tmp = (double8)((double)0);
  {
    double8 src1 = source[0];
    double8 src2 = secondSource[0];
    ulong8 mask = (ulong8)(4, 5, 11, 8, 13, 4, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[1];
    double8 src2 = secondSource[1];
    ulong8 mask = (ulong8)(15, 9, 5, 11, 5, 1, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[2];
    double8 src2 = secondSource[2];
    ulong8 mask = (ulong8)(0, 4, 11, 13, 5, 4, 14, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[3];
    double8 src2 = secondSource[3];
    ulong8 mask = (ulong8)(7, 13, 15, 8, 11, 3, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[4];
    double8 src2 = secondSource[4];
    ulong8 mask = (ulong8)(3, 2, 11, 15, 6, 10, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[5];
    double8 src2 = secondSource[5];
    ulong8 mask = (ulong8)(12, 8, 14, 0, 13, 9, 11, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[6];
    double8 src2 = secondSource[6];
    ulong8 mask = (ulong8)(9, 2, 9, 12, 0, 2, 8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[7];
    double8 src2 = secondSource[7];
    ulong8 mask = (ulong8)(1, 7, 13, 0, 0, 9, 7, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[8];
    double8 src2 = secondSource[8];
    ulong8 mask = (ulong8)(15, 12, 6, 8, 8, 4, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[9];
    double8 src2 = secondSource[9];
    ulong8 mask = (ulong8)(6, 10, 13, 1, 1, 12, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[10];
    double8 src2 = secondSource[10];
    ulong8 mask = (ulong8)(13, 10, 11, 10, 15, 1, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[11];
    double8 src2 = secondSource[11];
    ulong8 mask = (ulong8)(13, 6, 4, 9, 15, 4, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[12];
    double8 src2 = secondSource[12];
    ulong8 mask = (ulong8)(9, 11, 12, 8, 6, 7, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[13];
    double8 src2 = secondSource[13];
    ulong8 mask = (ulong8)(2, 8, 7, 13, 3, 12, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[14];
    double8 src2 = secondSource[14];
    ulong8 mask = (ulong8)(0, 3, 11, 13, 6, 8, 10, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[15];
    double8 src2 = secondSource[15];
    ulong8 mask = (ulong8)(15, 7, 13, 4, 1, 6, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[16];
    double8 src2 = secondSource[16];
    ulong8 mask = (ulong8)(10, 4, 7, 8, 3, 12, 9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[17];
    double8 src2 = secondSource[17];
    ulong8 mask = (ulong8)(10, 13, 14, 3, 15, 4, 14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[18];
    double8 src2 = secondSource[18];
    ulong8 mask = (ulong8)(11, 11, 1, 4, 9, 13, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[19];
    double8 src2 = secondSource[19];
    ulong8 mask = (ulong8)(1, 0, 5, 12, 14, 15, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[20];
    double8 src2 = secondSource[20];
    ulong8 mask = (ulong8)(7, 2, 6, 7, 14, 4, 8, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[21];
    double8 src2 = secondSource[21];
    ulong8 mask = (ulong8)(11, 12, 4, 2, 0, 0, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[22];
    double8 src2 = secondSource[22];
    ulong8 mask = (ulong8)(0, 0, 7, 0, 9, 7, 12, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[23];
    double8 src2 = secondSource[23];
    ulong8 mask = (ulong8)(10, 13, 14, 7, 8, 2, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[24];
    double8 src2 = secondSource[24];
    ulong8 mask = (ulong8)(1, 4, 8, 0, 4, 4, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[25];
    double8 src2 = secondSource[25];
    ulong8 mask = (ulong8)(0, 1, 13, 0, 9, 12, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[26];
    double8 src2 = secondSource[26];
    ulong8 mask = (ulong8)(11, 5, 0, 1, 13, 15, 13, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[27];
    double8 src2 = secondSource[27];
    ulong8 mask = (ulong8)(4, 11, 14, 11, 15, 11, 6, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[28];
    double8 src2 = secondSource[28];
    ulong8 mask = (ulong8)(3, 4, 14, 7, 15, 14, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[29];
    double8 src2 = secondSource[29];
    ulong8 mask = (ulong8)(13, 5, 10, 4, 15, 13, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[30];
    double8 src2 = secondSource[30];
    ulong8 mask = (ulong8)(2, 11, 1, 7, 1, 1, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[31];
    double8 src2 = secondSource[31];
    ulong8 mask = (ulong8)(7, 14, 5, 9, 14, 2, 12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
