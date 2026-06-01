// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *secondSource,
                          __global double16 *source, __global double4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 , src2;
  double4 tmp;
  tmp = (double4)((double)0);
  {
    double16 src1 = source[0];
    double16 src2 = secondSource[0];
    ulong4 mask = (ulong4)(7, 21, 0, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong4 mask = (ulong4)(3, 29, 22, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong4 mask = (ulong4)(7, 8, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong4 mask = (ulong4)(12, 4, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong4 mask = (ulong4)(21, 13, 23, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong4 mask = (ulong4)(4, 4, 15, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong4 mask = (ulong4)(5, 2, 20, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong4 mask = (ulong4)(21, 29, 11, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong4 mask = (ulong4)(24, 31, 13, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong4 mask = (ulong4)(2, 9, 17, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong4 mask = (ulong4)(30, 6, 27, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong4 mask = (ulong4)(14, 12, 6, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong4 mask = (ulong4)(5, 12, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong4 mask = (ulong4)(17, 20, 29, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong4 mask = (ulong4)(0, 7, 27, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong4 mask = (ulong4)(8, 8, 19, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong4 mask = (ulong4)(12, 9, 10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong4 mask = (ulong4)(17, 25, 11, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong4 mask = (ulong4)(1, 31, 3, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong4 mask = (ulong4)(16, 13, 0, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong4 mask = (ulong4)(8, 5, 2, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong4 mask = (ulong4)(20, 20, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong4 mask = (ulong4)(22, 31, 0, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong4 mask = (ulong4)(9, 22, 20, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong4 mask = (ulong4)(2, 31, 20, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong4 mask = (ulong4)(10, 5, 9, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong4 mask = (ulong4)(5, 19, 17, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong4 mask = (ulong4)(0, 25, 28, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong4 mask = (ulong4)(12, 14, 30, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong4 mask = (ulong4)(3, 3, 25, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong4 mask = (ulong4)(26, 2, 0, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong4 mask = (ulong4)(12, 4, 3, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
