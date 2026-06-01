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
    ulong8 mask = (ulong8)(5, 12, 3, 15, 14, 7, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[1];
    double8 src2 = secondSource[1];
    ulong8 mask = (ulong8)(7, 4, 8, 15, 4, 6, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[2];
    double8 src2 = secondSource[2];
    ulong8 mask = (ulong8)(10, 3, 13, 13, 4, 2, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[3];
    double8 src2 = secondSource[3];
    ulong8 mask = (ulong8)(7, 9, 7, 0, 6, 2, 2, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[4];
    double8 src2 = secondSource[4];
    ulong8 mask = (ulong8)(3, 0, 3, 9, 7, 7, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[5];
    double8 src2 = secondSource[5];
    ulong8 mask = (ulong8)(14, 4, 1, 15, 9, 11, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[6];
    double8 src2 = secondSource[6];
    ulong8 mask = (ulong8)(5, 15, 7, 11, 14, 8, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[7];
    double8 src2 = secondSource[7];
    ulong8 mask = (ulong8)(8, 1, 3, 6, 13, 8, 11, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[8];
    double8 src2 = secondSource[8];
    ulong8 mask = (ulong8)(12, 8, 8, 6, 15, 1, 0, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[9];
    double8 src2 = secondSource[9];
    ulong8 mask = (ulong8)(6, 14, 14, 4, 6, 10, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[10];
    double8 src2 = secondSource[10];
    ulong8 mask = (ulong8)(7, 1, 12, 1, 15, 12, 12, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[11];
    double8 src2 = secondSource[11];
    ulong8 mask = (ulong8)(6, 8, 5, 12, 13, 14, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[12];
    double8 src2 = secondSource[12];
    ulong8 mask = (ulong8)(14, 13, 14, 8, 8, 9, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[13];
    double8 src2 = secondSource[13];
    ulong8 mask = (ulong8)(0, 14, 15, 7, 11, 0, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[14];
    double8 src2 = secondSource[14];
    ulong8 mask = (ulong8)(0, 0, 2, 15, 4, 9, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[15];
    double8 src2 = secondSource[15];
    ulong8 mask = (ulong8)(14, 1, 7, 2, 1, 10, 2, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[16];
    double8 src2 = secondSource[16];
    ulong8 mask = (ulong8)(10, 1, 2, 5, 1, 5, 2, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[17];
    double8 src2 = secondSource[17];
    ulong8 mask = (ulong8)(11, 1, 8, 9, 15, 7, 15, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[18];
    double8 src2 = secondSource[18];
    ulong8 mask = (ulong8)(9, 15, 13, 3, 8, 7, 12, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[19];
    double8 src2 = secondSource[19];
    ulong8 mask = (ulong8)(7, 8, 14, 4, 7, 9, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[20];
    double8 src2 = secondSource[20];
    ulong8 mask = (ulong8)(11, 11, 14, 3, 11, 11, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[21];
    double8 src2 = secondSource[21];
    ulong8 mask = (ulong8)(5, 11, 3, 14, 4, 13, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[22];
    double8 src2 = secondSource[22];
    ulong8 mask = (ulong8)(4, 12, 1, 0, 2, 7, 13, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[23];
    double8 src2 = secondSource[23];
    ulong8 mask = (ulong8)(3, 11, 14, 11, 6, 7, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[24];
    double8 src2 = secondSource[24];
    ulong8 mask = (ulong8)(13, 6, 10, 6, 5, 1, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[25];
    double8 src2 = secondSource[25];
    ulong8 mask = (ulong8)(9, 0, 4, 14, 10, 10, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[26];
    double8 src2 = secondSource[26];
    ulong8 mask = (ulong8)(14, 2, 0, 10, 10, 1, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[27];
    double8 src2 = secondSource[27];
    ulong8 mask = (ulong8)(7, 4, 2, 13, 5, 11, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[28];
    double8 src2 = secondSource[28];
    ulong8 mask = (ulong8)(0, 4, 7, 15, 11, 11, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[29];
    double8 src2 = secondSource[29];
    ulong8 mask = (ulong8)(1, 13, 15, 9, 6, 2, 15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[30];
    double8 src2 = secondSource[30];
    ulong8 mask = (ulong8)(10, 13, 14, 0, 6, 9, 5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double8 src1 = source[31];
    double8 src2 = secondSource[31];
    ulong8 mask = (ulong8)(10, 9, 12, 0, 0, 15, 9, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
