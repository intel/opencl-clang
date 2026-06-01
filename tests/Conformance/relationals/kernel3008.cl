// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double4 *secondSource,
                          __global double4 *source, __global double2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double4 src1 , src2;
  double2 tmp;
  tmp = (double2)((double)0);
  {
    double4 src1 = source[0];
    double4 src2 = secondSource[0];
    ulong2 mask = (ulong2)(0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[1];
    double4 src2 = secondSource[1];
    ulong2 mask = (ulong2)(2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[2];
    double4 src2 = secondSource[2];
    ulong2 mask = (ulong2)(7, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[3];
    double4 src2 = secondSource[3];
    ulong2 mask = (ulong2)(3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[4];
    double4 src2 = secondSource[4];
    ulong2 mask = (ulong2)(5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[5];
    double4 src2 = secondSource[5];
    ulong2 mask = (ulong2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[6];
    double4 src2 = secondSource[6];
    ulong2 mask = (ulong2)(3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[7];
    double4 src2 = secondSource[7];
    ulong2 mask = (ulong2)(6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[8];
    double4 src2 = secondSource[8];
    ulong2 mask = (ulong2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[9];
    double4 src2 = secondSource[9];
    ulong2 mask = (ulong2)(4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[10];
    double4 src2 = secondSource[10];
    ulong2 mask = (ulong2)(5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[11];
    double4 src2 = secondSource[11];
    ulong2 mask = (ulong2)(1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[12];
    double4 src2 = secondSource[12];
    ulong2 mask = (ulong2)(6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[13];
    double4 src2 = secondSource[13];
    ulong2 mask = (ulong2)(5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[14];
    double4 src2 = secondSource[14];
    ulong2 mask = (ulong2)(4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[15];
    double4 src2 = secondSource[15];
    ulong2 mask = (ulong2)(5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[16];
    double4 src2 = secondSource[16];
    ulong2 mask = (ulong2)(0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[17];
    double4 src2 = secondSource[17];
    ulong2 mask = (ulong2)(2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[18];
    double4 src2 = secondSource[18];
    ulong2 mask = (ulong2)(1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[19];
    double4 src2 = secondSource[19];
    ulong2 mask = (ulong2)(5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[20];
    double4 src2 = secondSource[20];
    ulong2 mask = (ulong2)(1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[21];
    double4 src2 = secondSource[21];
    ulong2 mask = (ulong2)(4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[22];
    double4 src2 = secondSource[22];
    ulong2 mask = (ulong2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[23];
    double4 src2 = secondSource[23];
    ulong2 mask = (ulong2)(6, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[24];
    double4 src2 = secondSource[24];
    ulong2 mask = (ulong2)(0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[25];
    double4 src2 = secondSource[25];
    ulong2 mask = (ulong2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[26];
    double4 src2 = secondSource[26];
    ulong2 mask = (ulong2)(3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[27];
    double4 src2 = secondSource[27];
    ulong2 mask = (ulong2)(5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[28];
    double4 src2 = secondSource[28];
    ulong2 mask = (ulong2)(4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[29];
    double4 src2 = secondSource[29];
    ulong2 mask = (ulong2)(6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[30];
    double4 src2 = secondSource[30];
    ulong2 mask = (ulong2)(4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double4 src1 = source[31];
    double4 src2 = secondSource[31];
    ulong2 mask = (ulong2)(4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
