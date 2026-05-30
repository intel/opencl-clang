// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *secondSource,
                          __global double8 *source, __global double16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double8 src1 , src2;
  double16 tmp;
  tmp = (double16)((double)0);
  {
    double8 src1 = source[0];
    double8 src2 = secondSource[0];
    ulong16 mask = (ulong16)(6, 2, 0, 2, 3, 3, 7, 3, 7, 6, 3, 15, 7, 11, 11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[1];
    double8 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(15, 14, 8, 9, 0, 4, 7, 8, 1, 4, 1, 12, 3, 0, 13, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[2];
    double8 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(13, 14, 0, 3, 12, 15, 2, 11, 7, 1, 2, 15, 13, 1, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[3];
    double8 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(1, 11, 8, 8, 0, 11, 13, 3, 9, 9, 13, 0, 15, 12, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[4];
    double8 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(6, 12, 9, 11, 13, 14, 0, 2, 12, 12, 13, 7, 8, 1, 11, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[5];
    double8 src2 = secondSource[5];
    ulong16 mask = (ulong16)(5, 0, 3, 8, 6, 3, 10, 9, 15, 4, 14, 8, 9, 6, 9, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[6];
    double8 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(1, 13, 0, 13, 6, 10, 10, 8, 3, 4, 9, 13, 0, 8, 3, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[7];
    double8 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(11, 1, 15, 6, 9, 5, 4, 0, 11, 0, 15, 5, 4, 5, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[8];
    double8 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(9, 11, 2, 2, 3, 3, 2, 0, 9, 0, 8, 12, 11, 4, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[9];
    double8 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(13, 2, 13, 10, 4, 14, 6, 8, 4, 11, 7, 14, 7, 11, 8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[10];
    double8 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(14, 7, 12, 7, 2, 6, 1, 7, 14, 2, 8, 15, 4, 4, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[11];
    double8 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(12, 0, 0, 11, 6, 9, 12, 10, 3, 14, 0, 14, 0, 6, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[12];
    double8 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(15, 8, 11, 15, 13, 0, 1, 4, 9, 4, 13, 10, 8, 12, 9, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[13];
    double8 src2 = secondSource[13];
    ulong16 mask =
        (ulong16)(3, 0, 12, 11, 7, 4, 12, 13, 9, 3, 0, 13, 3, 7, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[14];
    double8 src2 = secondSource[14];
    ulong16 mask =
        (ulong16)(0, 13, 2, 10, 12, 13, 5, 5, 8, 7, 12, 10, 14, 14, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[15];
    double8 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(10, 4, 9, 10, 12, 3, 13, 5, 11, 14, 0, 2, 4, 11, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[16];
    double8 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(12, 2, 4, 8, 0, 4, 7, 15, 8, 10, 4, 12, 8, 15, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[17];
    double8 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(13, 11, 3, 15, 10, 13, 5, 1, 2, 14, 8, 0, 3, 6, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[18];
    double8 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(14, 10, 14, 6, 12, 9, 6, 10, 9, 10, 0, 15, 10, 0, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[19];
    double8 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(8, 4, 6, 14, 7, 14, 11, 0, 9, 3, 3, 4, 14, 7, 4, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[20];
    double8 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(0, 4, 13, 14, 11, 3, 3, 3, 14, 4, 7, 15, 0, 0, 6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[21];
    double8 src2 = secondSource[21];
    ulong16 mask = (ulong16)(3, 6, 8, 0, 5, 9, 1, 15, 7, 5, 6, 5, 2, 4, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[22];
    double8 src2 = secondSource[22];
    ulong16 mask = (ulong16)(4, 1, 13, 8, 4, 15, 5, 8, 13, 2, 7, 5, 1, 1, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[23];
    double8 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(0, 0, 8, 7, 11, 4, 13, 1, 2, 7, 1, 13, 11, 14, 8, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[24];
    double8 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(2, 6, 4, 14, 2, 14, 9, 3, 10, 12, 1, 6, 4, 6, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[25];
    double8 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(7, 10, 6, 2, 7, 7, 1, 9, 13, 10, 3, 9, 13, 0, 9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[26];
    double8 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(3, 13, 7, 4, 7, 1, 7, 10, 1, 4, 0, 9, 11, 2, 11, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[27];
    double8 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(12, 3, 0, 13, 4, 11, 3, 5, 15, 11, 14, 13, 2, 11, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[28];
    double8 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(12, 13, 11, 13, 14, 3, 0, 11, 4, 6, 15, 11, 9, 3, 2, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[29];
    double8 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(5, 5, 8, 3, 6, 13, 1, 3, 13, 12, 10, 10, 5, 4, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[30];
    double8 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(0, 1, 10, 8, 14, 0, 0, 13, 7, 15, 2, 8, 0, 8, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[31];
    double8 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(0, 6, 11, 15, 7, 7, 4, 5, 4, 14, 2, 1, 7, 1, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
