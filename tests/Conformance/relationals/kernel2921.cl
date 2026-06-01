// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *secondSource, __global long8 *source,
                          __global long2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 , src2;
  long2 tmp;
  tmp = (long2)((long)0);
  {
    long8 src1 = source[0];
    long8 src2 = secondSource[0];
    ulong2 mask = (ulong2)(10, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[1];
    long8 src2 = secondSource[1];
    ulong2 mask = (ulong2)(11, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[2];
    long8 src2 = secondSource[2];
    ulong2 mask = (ulong2)(4, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[3];
    long8 src2 = secondSource[3];
    ulong2 mask = (ulong2)(5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[4];
    long8 src2 = secondSource[4];
    ulong2 mask = (ulong2)(9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[5];
    long8 src2 = secondSource[5];
    ulong2 mask = (ulong2)(10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[6];
    long8 src2 = secondSource[6];
    ulong2 mask = (ulong2)(15, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[7];
    long8 src2 = secondSource[7];
    ulong2 mask = (ulong2)(3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[8];
    long8 src2 = secondSource[8];
    ulong2 mask = (ulong2)(14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[9];
    long8 src2 = secondSource[9];
    ulong2 mask = (ulong2)(8, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[10];
    long8 src2 = secondSource[10];
    ulong2 mask = (ulong2)(13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[11];
    long8 src2 = secondSource[11];
    ulong2 mask = (ulong2)(12, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[12];
    long8 src2 = secondSource[12];
    ulong2 mask = (ulong2)(15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[13];
    long8 src2 = secondSource[13];
    ulong2 mask = (ulong2)(14, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[14];
    long8 src2 = secondSource[14];
    ulong2 mask = (ulong2)(2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[15];
    long8 src2 = secondSource[15];
    ulong2 mask = (ulong2)(9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[16];
    long8 src2 = secondSource[16];
    ulong2 mask = (ulong2)(0, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[17];
    long8 src2 = secondSource[17];
    ulong2 mask = (ulong2)(11, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[18];
    long8 src2 = secondSource[18];
    ulong2 mask = (ulong2)(8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[19];
    long8 src2 = secondSource[19];
    ulong2 mask = (ulong2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[20];
    long8 src2 = secondSource[20];
    ulong2 mask = (ulong2)(10, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[21];
    long8 src2 = secondSource[21];
    ulong2 mask = (ulong2)(5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[22];
    long8 src2 = secondSource[22];
    ulong2 mask = (ulong2)(1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[23];
    long8 src2 = secondSource[23];
    ulong2 mask = (ulong2)(0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[24];
    long8 src2 = secondSource[24];
    ulong2 mask = (ulong2)(9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[25];
    long8 src2 = secondSource[25];
    ulong2 mask = (ulong2)(12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[26];
    long8 src2 = secondSource[26];
    ulong2 mask = (ulong2)(7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[27];
    long8 src2 = secondSource[27];
    ulong2 mask = (ulong2)(5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[28];
    long8 src2 = secondSource[28];
    ulong2 mask = (ulong2)(12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[29];
    long8 src2 = secondSource[29];
    ulong2 mask = (ulong2)(0, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[30];
    long8 src2 = secondSource[30];
    ulong2 mask = (ulong2)(12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[31];
    long8 src2 = secondSource[31];
    ulong2 mask = (ulong2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
