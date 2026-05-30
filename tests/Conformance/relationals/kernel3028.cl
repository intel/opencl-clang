// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *secondSource,
                          __global double16 *source, __global double8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 , src2;
  double8 tmp;
  tmp = (double8)((double)0);
  {
    double16 src1 = source[0];
    double16 src2 = secondSource[0];
    ulong8 mask = (ulong8)(20, 29, 13, 28, 28, 25, 3, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong8 mask = (ulong8)(28, 1, 17, 27, 4, 1, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong8 mask = (ulong8)(7, 12, 8, 7, 10, 9, 30, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong8 mask = (ulong8)(10, 3, 31, 27, 11, 1, 25, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong8 mask = (ulong8)(31, 25, 31, 5, 20, 25, 15, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong8 mask = (ulong8)(26, 21, 28, 8, 12, 15, 15, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong8 mask = (ulong8)(2, 28, 7, 18, 10, 25, 9, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong8 mask = (ulong8)(6, 19, 4, 3, 2, 6, 16, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong8 mask = (ulong8)(24, 2, 12, 6, 4, 27, 24, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong8 mask = (ulong8)(28, 13, 24, 20, 23, 15, 23, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong8 mask = (ulong8)(8, 10, 8, 22, 9, 19, 4, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong8 mask = (ulong8)(20, 1, 3, 23, 25, 23, 20, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong8 mask = (ulong8)(9, 28, 1, 29, 4, 10, 28, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong8 mask = (ulong8)(22, 22, 7, 11, 0, 21, 23, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong8 mask = (ulong8)(7, 23, 18, 14, 3, 7, 11, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong8 mask = (ulong8)(13, 21, 15, 17, 29, 2, 20, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong8 mask = (ulong8)(8, 13, 24, 16, 14, 28, 22, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong8 mask = (ulong8)(1, 7, 6, 16, 18, 30, 21, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong8 mask = (ulong8)(4, 16, 31, 28, 5, 10, 27, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong8 mask = (ulong8)(9, 28, 27, 9, 10, 17, 25, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong8 mask = (ulong8)(3, 8, 5, 27, 25, 13, 16, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong8 mask = (ulong8)(4, 2, 10, 16, 29, 7, 26, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong8 mask = (ulong8)(19, 1, 25, 0, 14, 18, 17, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong8 mask = (ulong8)(0, 29, 5, 16, 23, 17, 29, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong8 mask = (ulong8)(12, 9, 3, 18, 30, 1, 0, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong8 mask = (ulong8)(30, 19, 7, 9, 10, 22, 19, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong8 mask = (ulong8)(26, 21, 20, 25, 28, 17, 31, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong8 mask = (ulong8)(0, 5, 18, 18, 2, 6, 11, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong8 mask = (ulong8)(24, 2, 17, 13, 4, 28, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong8 mask = (ulong8)(15, 30, 14, 0, 1, 2, 15, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong8 mask = (ulong8)(11, 12, 5, 17, 29, 6, 21, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong8 mask = (ulong8)(16, 11, 17, 29, 26, 10, 10, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
