// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *source, __global double16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double8 src1 /*, src2*/;
  double16 tmp;
  tmp = (double16)((double)0);
  {
    double8 src1 = source[0];
    ulong16 mask = (ulong16)(7, 2, 5, 0, 7, 0, 5, 5, 4, 7, 1, 3, 3, 0, 4, 6);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[1];
    ulong16 mask = (ulong16)(2, 6, 4, 6, 0, 6, 1, 7, 7, 1, 3, 6, 5, 6, 0, 5);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[2];
    ulong16 mask = (ulong16)(0, 1, 2, 5, 4, 6, 6, 6, 7, 4, 0, 5, 3, 6, 0, 5);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[3];
    ulong16 mask = (ulong16)(5, 2, 1, 6, 1, 1, 7, 4, 2, 6, 2, 0, 6, 3, 6, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[4];
    ulong16 mask = (ulong16)(3, 5, 2, 3, 5, 0, 7, 5, 5, 6, 2, 3, 4, 6, 6, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[5];
    ulong16 mask = (ulong16)(6, 4, 1, 6, 3, 1, 5, 2, 3, 5, 4, 4, 1, 3, 2, 3);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[6];
    ulong16 mask = (ulong16)(6, 1, 3, 2, 1, 4, 6, 5, 6, 2, 4, 6, 1, 7, 1, 3);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[7];
    ulong16 mask = (ulong16)(5, 2, 3, 6, 6, 7, 5, 1, 2, 2, 5, 7, 3, 6, 2, 7);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[8];
    ulong16 mask = (ulong16)(6, 7, 0, 3, 6, 0, 0, 7, 1, 5, 3, 1, 1, 7, 2, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[9];
    ulong16 mask = (ulong16)(5, 6, 4, 5, 6, 3, 4, 1, 2, 3, 2, 0, 7, 1, 6, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[10];
    ulong16 mask = (ulong16)(2, 3, 4, 4, 1, 7, 4, 6, 1, 3, 2, 5, 7, 4, 6, 4);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[11];
    ulong16 mask = (ulong16)(0, 5, 1, 1, 4, 7, 3, 4, 1, 1, 1, 5, 6, 5, 2, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[12];
    ulong16 mask = (ulong16)(0, 1, 3, 7, 1, 5, 1, 3, 2, 6, 7, 3, 4, 1, 6, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[13];
    ulong16 mask = (ulong16)(2, 1, 0, 2, 0, 2, 0, 4, 6, 3, 6, 0, 1, 2, 4, 2);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[14];
    ulong16 mask = (ulong16)(6, 4, 0, 3, 5, 3, 1, 2, 6, 4, 0, 1, 1, 0, 0, 4);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[15];
    ulong16 mask = (ulong16)(2, 1, 3, 0, 4, 0, 5, 6, 7, 3, 4, 7, 3, 2, 5, 3);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[16];
    ulong16 mask = (ulong16)(0, 7, 6, 7, 6, 5, 1, 1, 3, 1, 1, 2, 7, 2, 5, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[17];
    ulong16 mask = (ulong16)(2, 4, 7, 6, 5, 4, 6, 2, 0, 5, 4, 5, 7, 2, 5, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[18];
    ulong16 mask = (ulong16)(7, 4, 0, 5, 4, 0, 0, 6, 1, 6, 5, 2, 0, 2, 0, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[19];
    ulong16 mask = (ulong16)(7, 6, 4, 4, 3, 5, 1, 6, 2, 3, 3, 1, 2, 1, 5, 7);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[20];
    ulong16 mask = (ulong16)(0, 2, 5, 1, 4, 7, 5, 7, 3, 0, 1, 2, 2, 5, 0, 5);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[21];
    ulong16 mask = (ulong16)(4, 0, 3, 7, 5, 6, 7, 3, 3, 0, 7, 0, 2, 2, 4, 6);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[22];
    ulong16 mask = (ulong16)(1, 1, 4, 7, 6, 0, 1, 5, 1, 3, 2, 3, 7, 5, 0, 7);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[23];
    ulong16 mask = (ulong16)(2, 0, 3, 6, 6, 7, 5, 0, 3, 2, 2, 5, 6, 2, 2, 3);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[24];
    ulong16 mask = (ulong16)(3, 3, 7, 5, 7, 0, 1, 2, 2, 4, 1, 2, 1, 6, 1, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[25];
    ulong16 mask = (ulong16)(1, 3, 2, 0, 1, 6, 1, 6, 5, 6, 7, 0, 5, 4, 5, 2);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[26];
    ulong16 mask = (ulong16)(6, 2, 7, 4, 0, 3, 0, 5, 2, 3, 1, 0, 0, 5, 4, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[27];
    ulong16 mask = (ulong16)(4, 3, 3, 2, 1, 1, 5, 7, 1, 7, 6, 7, 6, 5, 1, 5);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[28];
    ulong16 mask = (ulong16)(5, 7, 6, 6, 2, 1, 4, 0, 3, 6, 7, 4, 5, 7, 1, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[29];
    ulong16 mask = (ulong16)(1, 1, 1, 5, 2, 6, 0, 5, 3, 1, 1, 7, 2, 6, 6, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[30];
    ulong16 mask = (ulong16)(6, 0, 6, 0, 1, 7, 1, 5, 7, 0, 7, 6, 4, 3, 5, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (double16)((double)0);
  {
    double8 src1 = source[31];
    ulong16 mask = (ulong16)(5, 5, 7, 7, 1, 3, 4, 2, 0, 0, 2, 7, 2, 2, 4, 4);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
