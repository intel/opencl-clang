// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void sample_test(__global double16 *secondSource,
                          __global double16 *source, __global double2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // double16 src1 , src2;
  double2 tmp;
  tmp = (double2)((double)0);
  {
    double16 src1 = source[0];
    double16 src2 = secondSource[0];
    ulong2 mask = (ulong2)(24, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[1];
    double16 src2 = secondSource[1];
    ulong2 mask = (ulong2)(24, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[2];
    double16 src2 = secondSource[2];
    ulong2 mask = (ulong2)(0, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[3];
    double16 src2 = secondSource[3];
    ulong2 mask = (ulong2)(8, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[4];
    double16 src2 = secondSource[4];
    ulong2 mask = (ulong2)(1, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[5];
    double16 src2 = secondSource[5];
    ulong2 mask = (ulong2)(15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[6];
    double16 src2 = secondSource[6];
    ulong2 mask = (ulong2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[7];
    double16 src2 = secondSource[7];
    ulong2 mask = (ulong2)(16, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[8];
    double16 src2 = secondSource[8];
    ulong2 mask = (ulong2)(27, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[9];
    double16 src2 = secondSource[9];
    ulong2 mask = (ulong2)(8, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[10];
    double16 src2 = secondSource[10];
    ulong2 mask = (ulong2)(14, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[11];
    double16 src2 = secondSource[11];
    ulong2 mask = (ulong2)(17, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[12];
    double16 src2 = secondSource[12];
    ulong2 mask = (ulong2)(7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[13];
    double16 src2 = secondSource[13];
    ulong2 mask = (ulong2)(11, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[14];
    double16 src2 = secondSource[14];
    ulong2 mask = (ulong2)(23, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[15];
    double16 src2 = secondSource[15];
    ulong2 mask = (ulong2)(4, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[16];
    double16 src2 = secondSource[16];
    ulong2 mask = (ulong2)(6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[17];
    double16 src2 = secondSource[17];
    ulong2 mask = (ulong2)(7, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[18];
    double16 src2 = secondSource[18];
    ulong2 mask = (ulong2)(24, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[19];
    double16 src2 = secondSource[19];
    ulong2 mask = (ulong2)(17, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[20];
    double16 src2 = secondSource[20];
    ulong2 mask = (ulong2)(17, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[21];
    double16 src2 = secondSource[21];
    ulong2 mask = (ulong2)(8, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[22];
    double16 src2 = secondSource[22];
    ulong2 mask = (ulong2)(2, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[23];
    double16 src2 = secondSource[23];
    ulong2 mask = (ulong2)(18, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[24];
    double16 src2 = secondSource[24];
    ulong2 mask = (ulong2)(28, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[25];
    double16 src2 = secondSource[25];
    ulong2 mask = (ulong2)(24, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[26];
    double16 src2 = secondSource[26];
    ulong2 mask = (ulong2)(8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[27];
    double16 src2 = secondSource[27];
    ulong2 mask = (ulong2)(21, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[28];
    double16 src2 = secondSource[28];
    ulong2 mask = (ulong2)(22, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[29];
    double16 src2 = secondSource[29];
    ulong2 mask = (ulong2)(31, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[30];
    double16 src2 = secondSource[30];
    ulong2 mask = (ulong2)(31, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (double2)((double)0);
  {
    double16 src1 = source[31];
    double16 src2 = secondSource[31];
    ulong2 mask = (ulong2)(28, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
