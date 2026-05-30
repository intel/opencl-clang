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
    ulong4 mask = (ulong4)(22, 25, 7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong4 mask = (ulong4)(8, 19, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong4 mask = (ulong4)(31, 31, 22, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong4 mask = (ulong4)(2, 30, 17, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong4 mask = (ulong4)(8, 3, 24, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong4 mask = (ulong4)(27, 12, 15, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong4 mask = (ulong4)(3, 17, 31, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong4 mask = (ulong4)(12, 25, 5, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong4 mask = (ulong4)(18, 15, 16, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong4 mask = (ulong4)(27, 10, 31, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong4 mask = (ulong4)(14, 7, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong4 mask = (ulong4)(1, 14, 17, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong4 mask = (ulong4)(11, 28, 14, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong4 mask = (ulong4)(11, 20, 9, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong4 mask = (ulong4)(2, 29, 28, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong4 mask = (ulong4)(12, 5, 21, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong4 mask = (ulong4)(8, 7, 14, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong4 mask = (ulong4)(8, 31, 3, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong4 mask = (ulong4)(31, 7, 24, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong4 mask = (ulong4)(15, 19, 29, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong4 mask = (ulong4)(10, 21, 20, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong4 mask = (ulong4)(25, 2, 8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong4 mask = (ulong4)(2, 24, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong4 mask = (ulong4)(13, 8, 31, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong4 mask = (ulong4)(27, 25, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong4 mask = (ulong4)(5, 0, 26, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong4 mask = (ulong4)(16, 4, 14, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong4 mask = (ulong4)(31, 24, 3, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong4 mask = (ulong4)(26, 26, 10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong4 mask = (ulong4)(11, 16, 30, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong4 mask = (ulong4)(30, 21, 19, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong4 mask = (ulong4)(24, 18, 28, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
