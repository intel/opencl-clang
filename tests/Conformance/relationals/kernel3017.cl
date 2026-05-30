// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double8 *secondSource,
                          __global double8 *source, __global double2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double8 src1 , src2;
  double2 tmp;
  tmp = (double2)((double)0);
  {
    double8 src1 = source[0];
    double8 src2 = secondSource[0];
    ulong2 mask = (ulong2)(6, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[1];
    double8 src2 = secondSource[1];
    ulong2 mask = (ulong2)(15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[2];
    double8 src2 = secondSource[2];
    ulong2 mask = (ulong2)(4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[3];
    double8 src2 = secondSource[3];
    ulong2 mask = (ulong2)(9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[4];
    double8 src2 = secondSource[4];
    ulong2 mask = (ulong2)(1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[5];
    double8 src2 = secondSource[5];
    ulong2 mask = (ulong2)(3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[6];
    double8 src2 = secondSource[6];
    ulong2 mask = (ulong2)(7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[7];
    double8 src2 = secondSource[7];
    ulong2 mask = (ulong2)(12, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[8];
    double8 src2 = secondSource[8];
    ulong2 mask = (ulong2)(12, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[9];
    double8 src2 = secondSource[9];
    ulong2 mask = (ulong2)(11, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[10];
    double8 src2 = secondSource[10];
    ulong2 mask = (ulong2)(4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[11];
    double8 src2 = secondSource[11];
    ulong2 mask = (ulong2)(15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[12];
    double8 src2 = secondSource[12];
    ulong2 mask = (ulong2)(11, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[13];
    double8 src2 = secondSource[13];
    ulong2 mask = (ulong2)(10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[14];
    double8 src2 = secondSource[14];
    ulong2 mask = (ulong2)(8, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[15];
    double8 src2 = secondSource[15];
    ulong2 mask = (ulong2)(6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[16];
    double8 src2 = secondSource[16];
    ulong2 mask = (ulong2)(4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[17];
    double8 src2 = secondSource[17];
    ulong2 mask = (ulong2)(11, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[18];
    double8 src2 = secondSource[18];
    ulong2 mask = (ulong2)(4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[19];
    double8 src2 = secondSource[19];
    ulong2 mask = (ulong2)(3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[20];
    double8 src2 = secondSource[20];
    ulong2 mask = (ulong2)(7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[21];
    double8 src2 = secondSource[21];
    ulong2 mask = (ulong2)(3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[22];
    double8 src2 = secondSource[22];
    ulong2 mask = (ulong2)(13, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[23];
    double8 src2 = secondSource[23];
    ulong2 mask = (ulong2)(7, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[24];
    double8 src2 = secondSource[24];
    ulong2 mask = (ulong2)(8, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[25];
    double8 src2 = secondSource[25];
    ulong2 mask = (ulong2)(15, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[26];
    double8 src2 = secondSource[26];
    ulong2 mask = (ulong2)(7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[27];
    double8 src2 = secondSource[27];
    ulong2 mask = (ulong2)(7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[28];
    double8 src2 = secondSource[28];
    ulong2 mask = (ulong2)(11, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[29];
    double8 src2 = secondSource[29];
    ulong2 mask = (ulong2)(11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[30];
    double8 src2 = secondSource[30];
    ulong2 mask = (ulong2)(8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double8 src1 = source[31];
    double8 src2 = secondSource[31];
    ulong2 mask = (ulong2)(3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
