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
    ulong16 mask =
        (ulong16)(14, 5, 10, 1, 15, 0, 10, 11, 9, 14, 3, 7, 7, 0, 9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[1];
    double8 src2 = secondSource[1];
    ulong16 mask =
        (ulong16)(5, 12, 8, 13, 0, 12, 2, 14, 15, 3, 7, 13, 10, 13, 0, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[2];
    double8 src2 = secondSource[2];
    ulong16 mask =
        (ulong16)(1, 2, 5, 11, 9, 12, 12, 13, 15, 8, 1, 11, 6, 12, 0, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[3];
    double8 src2 = secondSource[3];
    ulong16 mask =
        (ulong16)(10, 4, 2, 12, 3, 2, 15, 9, 4, 13, 5, 1, 12, 6, 13, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[4];
    double8 src2 = secondSource[4];
    ulong16 mask =
        (ulong16)(6, 11, 5, 6, 10, 1, 15, 10, 11, 13, 4, 7, 8, 12, 12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[5];
    double8 src2 = secondSource[5];
    ulong16 mask =
        (ulong16)(12, 9, 2, 13, 6, 3, 10, 4, 6, 11, 8, 8, 2, 7, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[6];
    double8 src2 = secondSource[6];
    ulong16 mask =
        (ulong16)(12, 3, 7, 5, 3, 8, 12, 10, 12, 4, 9, 12, 2, 15, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[7];
    double8 src2 = secondSource[7];
    ulong16 mask =
        (ulong16)(10, 4, 6, 12, 13, 14, 10, 3, 5, 4, 10, 15, 7, 13, 5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[8];
    double8 src2 = secondSource[8];
    ulong16 mask =
        (ulong16)(12, 14, 0, 6, 12, 1, 1, 14, 2, 10, 6, 3, 3, 14, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[9];
    double8 src2 = secondSource[9];
    ulong16 mask =
        (ulong16)(11, 12, 8, 10, 13, 7, 8, 2, 5, 6, 4, 1, 14, 2, 13, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[10];
    double8 src2 = secondSource[10];
    ulong16 mask =
        (ulong16)(5, 7, 9, 9, 3, 15, 9, 13, 3, 7, 5, 10, 14, 9, 13, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[11];
    double8 src2 = secondSource[11];
    ulong16 mask =
        (ulong16)(0, 10, 2, 3, 9, 15, 7, 8, 2, 2, 2, 10, 13, 10, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[12];
    double8 src2 = secondSource[12];
    ulong16 mask =
        (ulong16)(0, 3, 7, 15, 3, 11, 2, 6, 4, 13, 14, 6, 8, 3, 12, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[13];
    double8 src2 = secondSource[13];
    ulong16 mask = (ulong16)(5, 2, 1, 5, 0, 5, 0, 8, 13, 7, 13, 0, 3, 4, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[14];
    double8 src2 = secondSource[14];
    ulong16 mask = (ulong16)(12, 8, 1, 7, 10, 7, 3, 4, 13, 9, 1, 2, 3, 0, 1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[15];
    double8 src2 = secondSource[15];
    ulong16 mask =
        (ulong16)(4, 2, 7, 1, 9, 0, 10, 13, 14, 7, 8, 15, 6, 4, 10, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[16];
    double8 src2 = secondSource[16];
    ulong16 mask =
        (ulong16)(1, 15, 12, 15, 12, 10, 2, 2, 7, 2, 3, 4, 14, 4, 10, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[17];
    double8 src2 = secondSource[17];
    ulong16 mask =
        (ulong16)(4, 8, 15, 12, 11, 8, 13, 4, 1, 10, 9, 11, 14, 4, 10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[18];
    double8 src2 = secondSource[18];
    ulong16 mask =
        (ulong16)(15, 9, 1, 10, 8, 0, 0, 12, 2, 12, 11, 4, 1, 4, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[19];
    double8 src2 = secondSource[19];
    ulong16 mask =
        (ulong16)(14, 13, 8, 8, 6, 11, 2, 12, 4, 7, 7, 3, 5, 3, 10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[20];
    double8 src2 = secondSource[20];
    ulong16 mask =
        (ulong16)(1, 5, 10, 3, 8, 15, 10, 14, 7, 1, 3, 5, 4, 11, 0, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[21];
    double8 src2 = secondSource[21];
    ulong16 mask =
        (ulong16)(9, 1, 6, 14, 10, 13, 14, 7, 7, 0, 15, 1, 5, 5, 8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[22];
    double8 src2 = secondSource[22];
    ulong16 mask =
        (ulong16)(3, 3, 9, 15, 12, 0, 2, 11, 2, 7, 4, 6, 15, 10, 0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[23];
    double8 src2 = secondSource[23];
    ulong16 mask =
        (ulong16)(5, 0, 7, 13, 13, 14, 11, 0, 7, 5, 5, 11, 12, 4, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[24];
    double8 src2 = secondSource[24];
    ulong16 mask =
        (ulong16)(6, 6, 14, 11, 15, 1, 2, 5, 4, 9, 2, 4, 2, 12, 2, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[25];
    double8 src2 = secondSource[25];
    ulong16 mask =
        (ulong16)(3, 6, 4, 0, 3, 13, 2, 12, 11, 12, 14, 1, 11, 8, 10, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[26];
    double8 src2 = secondSource[26];
    ulong16 mask =
        (ulong16)(13, 4, 14, 8, 0, 7, 0, 11, 4, 7, 2, 1, 0, 11, 8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[27];
    double8 src2 = secondSource[27];
    ulong16 mask =
        (ulong16)(9, 6, 7, 4, 2, 2, 10, 14, 3, 15, 13, 14, 12, 11, 3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[28];
    double8 src2 = secondSource[28];
    ulong16 mask =
        (ulong16)(10, 15, 12, 12, 5, 2, 9, 1, 7, 12, 14, 8, 11, 15, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[29];
    double8 src2 = secondSource[29];
    ulong16 mask =
        (ulong16)(3, 3, 3, 10, 4, 13, 1, 10, 7, 3, 2, 15, 5, 13, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[30];
    double8 src2 = secondSource[30];
    ulong16 mask =
        (ulong16)(12, 0, 13, 1, 2, 14, 3, 11, 14, 1, 14, 13, 9, 6, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[31];
    double8 src2 = secondSource[31];
    ulong16 mask =
        (ulong16)(11, 11, 14, 14, 2, 6, 9, 4, 0, 0, 5, 15, 4, 5, 9, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
