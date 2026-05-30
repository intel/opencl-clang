// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *secondSource,
                          __global long16 *source, __global long2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long16 src1 , src2;
  long2 tmp;
  tmp = (long2)((long)0);
  {
    long16 src1 = source[0];
    long16 src2 = secondSource[0];
    ulong2 mask = (ulong2)(25, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[1];
    long16 src2 = secondSource[1];
    ulong2 mask = (ulong2)(27, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[2];
    long16 src2 = secondSource[2];
    ulong2 mask = (ulong2)(15, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[3];
    long16 src2 = secondSource[3];
    ulong2 mask = (ulong2)(16, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[4];
    long16 src2 = secondSource[4];
    ulong2 mask = (ulong2)(28, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[5];
    long16 src2 = secondSource[5];
    ulong2 mask = (ulong2)(15, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[6];
    long16 src2 = secondSource[6];
    ulong2 mask = (ulong2)(6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[7];
    long16 src2 = secondSource[7];
    ulong2 mask = (ulong2)(22, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[8];
    long16 src2 = secondSource[8];
    ulong2 mask = (ulong2)(18, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[9];
    long16 src2 = secondSource[9];
    ulong2 mask = (ulong2)(20, 17);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[10];
    long16 src2 = secondSource[10];
    ulong2 mask = (ulong2)(14, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[11];
    long16 src2 = secondSource[11];
    ulong2 mask = (ulong2)(28, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[12];
    long16 src2 = secondSource[12];
    ulong2 mask = (ulong2)(4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[13];
    long16 src2 = secondSource[13];
    ulong2 mask = (ulong2)(14, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[14];
    long16 src2 = secondSource[14];
    ulong2 mask = (ulong2)(21, 29);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[15];
    long16 src2 = secondSource[15];
    ulong2 mask = (ulong2)(17, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[16];
    long16 src2 = secondSource[16];
    ulong2 mask = (ulong2)(10, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[17];
    long16 src2 = secondSource[17];
    ulong2 mask = (ulong2)(3, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[18];
    long16 src2 = secondSource[18];
    ulong2 mask = (ulong2)(20, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[19];
    long16 src2 = secondSource[19];
    ulong2 mask = (ulong2)(31, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[20];
    long16 src2 = secondSource[20];
    ulong2 mask = (ulong2)(26, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[21];
    long16 src2 = secondSource[21];
    ulong2 mask = (ulong2)(17, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[22];
    long16 src2 = secondSource[22];
    ulong2 mask = (ulong2)(31, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[23];
    long16 src2 = secondSource[23];
    ulong2 mask = (ulong2)(30, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[24];
    long16 src2 = secondSource[24];
    ulong2 mask = (ulong2)(30, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[25];
    long16 src2 = secondSource[25];
    ulong2 mask = (ulong2)(7, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[26];
    long16 src2 = secondSource[26];
    ulong2 mask = (ulong2)(18, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[27];
    long16 src2 = secondSource[27];
    ulong2 mask = (ulong2)(12, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[28];
    long16 src2 = secondSource[28];
    ulong2 mask = (ulong2)(12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[29];
    long16 src2 = secondSource[29];
    ulong2 mask = (ulong2)(27, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[30];
    long16 src2 = secondSource[30];
    ulong2 mask = (ulong2)(0, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long16 src1 = source[31];
    long16 src2 = secondSource[31];
    ulong2 mask = (ulong2)(29, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
