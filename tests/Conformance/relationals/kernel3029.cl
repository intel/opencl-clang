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
    ulong8 mask = (ulong8)(13, 11, 3, 13, 27, 15, 22, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong8 mask = (ulong8)(4, 10, 22, 20, 20, 30, 22, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong8 mask = (ulong8)(14, 15, 0, 18, 24, 31, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong8 mask = (ulong8)(14, 22, 16, 26, 6, 31, 18, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong8 mask = (ulong8)(22, 17, 26, 6, 26, 1, 2, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong8 mask = (ulong8)(31, 15, 27, 5, 29, 21, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong8 mask = (ulong8)(27, 24, 19, 25, 25, 3, 22, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong8 mask = (ulong8)(4, 25, 4, 24, 11, 28, 21, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong8 mask = (ulong8)(9, 9, 5, 17, 21, 11, 26, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong8 mask = (ulong8)(6, 20, 11, 27, 3, 25, 20, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong8 mask = (ulong8)(19, 21, 23, 4, 30, 13, 8, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong8 mask = (ulong8)(15, 19, 20, 16, 25, 19, 4, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong8 mask = (ulong8)(19, 1, 3, 8, 26, 3, 31, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong8 mask = (ulong8)(31, 22, 13, 24, 5, 17, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong8 mask = (ulong8)(16, 18, 5, 8, 21, 28, 11, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong8 mask = (ulong8)(5, 27, 0, 27, 21, 3, 14, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong8 mask = (ulong8)(14, 7, 16, 4, 23, 11, 20, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong8 mask = (ulong8)(10, 3, 23, 15, 17, 12, 22, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong8 mask = (ulong8)(2, 4, 10, 17, 24, 0, 16, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong8 mask = (ulong8)(12, 13, 24, 10, 22, 4, 11, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong8 mask = (ulong8)(11, 11, 0, 22, 0, 19, 27, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong8 mask = (ulong8)(7, 6, 19, 20, 11, 11, 27, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong8 mask = (ulong8)(27, 5, 23, 9, 0, 24, 7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong8 mask = (ulong8)(8, 14, 26, 2, 21, 30, 25, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong8 mask = (ulong8)(0, 14, 24, 29, 28, 28, 14, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong8 mask = (ulong8)(17, 23, 22, 6, 24, 23, 6, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong8 mask = (ulong8)(13, 1, 11, 30, 22, 27, 24, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong8 mask = (ulong8)(23, 15, 27, 0, 28, 25, 29, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong8 mask = (ulong8)(10, 16, 1, 30, 3, 29, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong8 mask = (ulong8)(19, 19, 16, 26, 31, 4, 11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong8 mask = (ulong8)(30, 29, 3, 4, 19, 10, 12, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double8)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong8 mask = (ulong8)(6, 23, 16, 29, 2, 28, 10, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
