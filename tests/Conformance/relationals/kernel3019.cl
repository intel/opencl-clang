// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *secondSource,
                          __global double8 *source, __global double4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double8 src1 , src2;
  double4 tmp;
  tmp = (double4)((double)0);
  {
    double8 src1 = source[0];
    double8 src2 = secondSource[0];
    ulong4 mask = (ulong4)(3, 9, 8, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[1];
    double8 src2 = secondSource[1];
    ulong4 mask = (ulong4)(10, 7, 8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[2];
    double8 src2 = secondSource[2];
    ulong4 mask = (ulong4)(5, 15, 13, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[3];
    double8 src2 = secondSource[3];
    ulong4 mask = (ulong4)(2, 5, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[4];
    double8 src2 = secondSource[4];
    ulong4 mask = (ulong4)(9, 0, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[5];
    double8 src2 = secondSource[5];
    ulong4 mask = (ulong4)(15, 1, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[6];
    double8 src2 = secondSource[6];
    ulong4 mask = (ulong4)(5, 10, 13, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[7];
    double8 src2 = secondSource[7];
    ulong4 mask = (ulong4)(1, 4, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[8];
    double8 src2 = secondSource[8];
    ulong4 mask = (ulong4)(8, 1, 8, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[9];
    double8 src2 = secondSource[9];
    ulong4 mask = (ulong4)(6, 0, 12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[10];
    double8 src2 = secondSource[10];
    ulong4 mask = (ulong4)(1, 15, 14, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[11];
    double8 src2 = secondSource[11];
    ulong4 mask = (ulong4)(0, 2, 12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[12];
    double8 src2 = secondSource[12];
    ulong4 mask = (ulong4)(8, 12, 10, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[13];
    double8 src2 = secondSource[13];
    ulong4 mask = (ulong4)(1, 15, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[14];
    double8 src2 = secondSource[14];
    ulong4 mask = (ulong4)(11, 6, 10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[15];
    double8 src2 = secondSource[15];
    ulong4 mask = (ulong4)(12, 9, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[16];
    double8 src2 = secondSource[16];
    ulong4 mask = (ulong4)(3, 0, 1, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[17];
    double8 src2 = secondSource[17];
    ulong4 mask = (ulong4)(8, 0, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[18];
    double8 src2 = secondSource[18];
    ulong4 mask = (ulong4)(10, 11, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[19];
    double8 src2 = secondSource[19];
    ulong4 mask = (ulong4)(7, 0, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[20];
    double8 src2 = secondSource[20];
    ulong4 mask = (ulong4)(3, 7, 8, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[21];
    double8 src2 = secondSource[21];
    ulong4 mask = (ulong4)(0, 14, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[22];
    double8 src2 = secondSource[22];
    ulong4 mask = (ulong4)(6, 8, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[23];
    double8 src2 = secondSource[23];
    ulong4 mask = (ulong4)(8, 5, 2, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[24];
    double8 src2 = secondSource[24];
    ulong4 mask = (ulong4)(13, 8, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[25];
    double8 src2 = secondSource[25];
    ulong4 mask = (ulong4)(5, 15, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[26];
    double8 src2 = secondSource[26];
    ulong4 mask = (ulong4)(4, 15, 13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[27];
    double8 src2 = secondSource[27];
    ulong4 mask = (ulong4)(12, 9, 15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[28];
    double8 src2 = secondSource[28];
    ulong4 mask = (ulong4)(2, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[29];
    double8 src2 = secondSource[29];
    ulong4 mask = (ulong4)(7, 5, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[30];
    double8 src2 = secondSource[30];
    ulong4 mask = (ulong4)(7, 0, 12, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double8 src1 = source[31];
    double8 src2 = secondSource[31];
    ulong4 mask = (ulong4)(4, 4, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
