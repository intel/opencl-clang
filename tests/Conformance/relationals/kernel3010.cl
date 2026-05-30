// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double4 *secondSource,
                          __global double4 *source, __global double4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double4 src1 , src2;
  double4 tmp;
  tmp = (double4)((double)0);
  {
    double4 src1 = source[0];
    double4 src2 = secondSource[0];
    ulong4 mask = (ulong4)(2, 4, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[1];
    double4 src2 = secondSource[1];
    ulong4 mask = (ulong4)(3, 0, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[2];
    double4 src2 = secondSource[2];
    ulong4 mask = (ulong4)(4, 4, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[3];
    double4 src2 = secondSource[3];
    ulong4 mask = (ulong4)(7, 7, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[4];
    double4 src2 = secondSource[4];
    ulong4 mask = (ulong4)(1, 2, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[5];
    double4 src2 = secondSource[5];
    ulong4 mask = (ulong4)(0, 7, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[6];
    double4 src2 = secondSource[6];
    ulong4 mask = (ulong4)(3, 3, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[7];
    double4 src2 = secondSource[7];
    ulong4 mask = (ulong4)(0, 6, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[8];
    double4 src2 = secondSource[8];
    ulong4 mask = (ulong4)(4, 0, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[9];
    double4 src2 = secondSource[9];
    ulong4 mask = (ulong4)(3, 7, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[10];
    double4 src2 = secondSource[10];
    ulong4 mask = (ulong4)(4, 6, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[11];
    double4 src2 = secondSource[11];
    ulong4 mask = (ulong4)(4, 4, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[12];
    double4 src2 = secondSource[12];
    ulong4 mask = (ulong4)(0, 4, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[13];
    double4 src2 = secondSource[13];
    ulong4 mask = (ulong4)(7, 2, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[14];
    double4 src2 = secondSource[14];
    ulong4 mask = (ulong4)(7, 1, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[15];
    double4 src2 = secondSource[15];
    ulong4 mask = (ulong4)(3, 7, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[16];
    double4 src2 = secondSource[16];
    ulong4 mask = (ulong4)(3, 7, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[17];
    double4 src2 = secondSource[17];
    ulong4 mask = (ulong4)(5, 2, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[18];
    double4 src2 = secondSource[18];
    ulong4 mask = (ulong4)(2, 3, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[19];
    double4 src2 = secondSource[19];
    ulong4 mask = (ulong4)(2, 1, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[20];
    double4 src2 = secondSource[20];
    ulong4 mask = (ulong4)(0, 2, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[21];
    double4 src2 = secondSource[21];
    ulong4 mask = (ulong4)(1, 2, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[22];
    double4 src2 = secondSource[22];
    ulong4 mask = (ulong4)(4, 5, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[23];
    double4 src2 = secondSource[23];
    ulong4 mask = (ulong4)(2, 4, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[24];
    double4 src2 = secondSource[24];
    ulong4 mask = (ulong4)(7, 0, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[25];
    double4 src2 = secondSource[25];
    ulong4 mask = (ulong4)(2, 6, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[26];
    double4 src2 = secondSource[26];
    ulong4 mask = (ulong4)(2, 2, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[27];
    double4 src2 = secondSource[27];
    ulong4 mask = (ulong4)(4, 6, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[28];
    double4 src2 = secondSource[28];
    ulong4 mask = (ulong4)(1, 6, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[29];
    double4 src2 = secondSource[29];
    ulong4 mask = (ulong4)(0, 3, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[30];
    double4 src2 = secondSource[30];
    ulong4 mask = (ulong4)(5, 1, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double4)((double)0);
  {
    double4 src1 = source[31];
    double4 src2 = secondSource[31];
    ulong4 mask = (ulong4)(4, 1, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
