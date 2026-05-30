// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long2 *secondSource, __global long2 *source,
                          __global long16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long2 src1 , src2;
  long16 tmp;
  tmp = (long16)((long)0);
  {
    long2 src1 = source[0];
    long2 src2 = secondSource[0];
    ulong16 mask = (ulong16)(1, 2, 1, 2, 0, 3, 3, 3, 2, 0, 1, 1, 3, 0, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[1];
    long2 src2 = secondSource[1];
    ulong16 mask = (ulong16)(2, 1, 1, 2, 0, 2, 2, 1, 3, 3, 1, 0, 3, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[2];
    long2 src2 = secondSource[2];
    ulong16 mask = (ulong16)(3, 2, 2, 0, 2, 1, 1, 2, 2, 3, 0, 2, 0, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[3];
    long2 src2 = secondSource[3];
    ulong16 mask = (ulong16)(3, 3, 2, 0, 2, 0, 2, 1, 0, 3, 0, 3, 2, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[4];
    long2 src2 = secondSource[4];
    ulong16 mask = (ulong16)(2, 3, 0, 2, 0, 2, 2, 3, 3, 0, 0, 0, 3, 3, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[5];
    long2 src2 = secondSource[5];
    ulong16 mask = (ulong16)(3, 2, 0, 2, 3, 3, 2, 1, 1, 0, 2, 2, 2, 0, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[6];
    long2 src2 = secondSource[6];
    ulong16 mask = (ulong16)(0, 0, 0, 3, 3, 0, 2, 2, 1, 2, 1, 3, 3, 2, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[7];
    long2 src2 = secondSource[7];
    ulong16 mask = (ulong16)(3, 0, 0, 3, 2, 2, 3, 0, 2, 3, 0, 0, 1, 2, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[8];
    long2 src2 = secondSource[8];
    ulong16 mask = (ulong16)(3, 3, 3, 1, 2, 2, 2, 1, 3, 2, 0, 0, 3, 2, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[9];
    long2 src2 = secondSource[9];
    ulong16 mask = (ulong16)(0, 0, 3, 1, 1, 2, 3, 0, 3, 2, 1, 3, 0, 3, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[10];
    long2 src2 = secondSource[10];
    ulong16 mask = (ulong16)(2, 0, 3, 0, 3, 3, 2, 3, 3, 1, 0, 2, 0, 0, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[11];
    long2 src2 = secondSource[11];
    ulong16 mask = (ulong16)(3, 0, 3, 2, 2, 1, 1, 1, 3, 1, 0, 1, 0, 0, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[12];
    long2 src2 = secondSource[12];
    ulong16 mask = (ulong16)(0, 3, 0, 2, 2, 2, 2, 1, 2, 2, 0, 3, 3, 1, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[13];
    long2 src2 = secondSource[13];
    ulong16 mask = (ulong16)(0, 2, 3, 0, 0, 3, 1, 1, 2, 0, 2, 3, 0, 2, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[14];
    long2 src2 = secondSource[14];
    ulong16 mask = (ulong16)(1, 0, 3, 2, 1, 1, 0, 3, 3, 1, 1, 1, 1, 2, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[15];
    long2 src2 = secondSource[15];
    ulong16 mask = (ulong16)(3, 3, 2, 1, 2, 0, 1, 2, 1, 2, 0, 1, 2, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[16];
    long2 src2 = secondSource[16];
    ulong16 mask = (ulong16)(0, 2, 3, 3, 3, 1, 3, 2, 2, 1, 0, 3, 3, 0, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[17];
    long2 src2 = secondSource[17];
    ulong16 mask = (ulong16)(3, 2, 2, 2, 3, 1, 2, 2, 1, 1, 0, 3, 0, 0, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[18];
    long2 src2 = secondSource[18];
    ulong16 mask = (ulong16)(0, 0, 2, 0, 2, 2, 0, 1, 1, 3, 2, 0, 3, 2, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[19];
    long2 src2 = secondSource[19];
    ulong16 mask = (ulong16)(2, 2, 0, 3, 0, 0, 0, 3, 2, 3, 3, 2, 2, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[20];
    long2 src2 = secondSource[20];
    ulong16 mask = (ulong16)(1, 2, 2, 3, 1, 1, 0, 3, 1, 3, 3, 1, 2, 1, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[21];
    long2 src2 = secondSource[21];
    ulong16 mask = (ulong16)(1, 1, 2, 0, 1, 0, 3, 3, 0, 3, 1, 2, 0, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[22];
    long2 src2 = secondSource[22];
    ulong16 mask = (ulong16)(3, 0, 0, 0, 2, 2, 2, 3, 2, 1, 0, 1, 2, 1, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[23];
    long2 src2 = secondSource[23];
    ulong16 mask = (ulong16)(3, 2, 0, 3, 0, 1, 3, 3, 1, 2, 2, 1, 1, 1, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[24];
    long2 src2 = secondSource[24];
    ulong16 mask = (ulong16)(2, 0, 0, 1, 0, 3, 1, 0, 0, 3, 0, 2, 1, 0, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[25];
    long2 src2 = secondSource[25];
    ulong16 mask = (ulong16)(0, 2, 1, 3, 1, 3, 1, 3, 2, 2, 0, 0, 0, 2, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[26];
    long2 src2 = secondSource[26];
    ulong16 mask = (ulong16)(0, 0, 1, 0, 0, 1, 1, 2, 1, 1, 3, 3, 0, 3, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[27];
    long2 src2 = secondSource[27];
    ulong16 mask = (ulong16)(0, 0, 2, 3, 0, 1, 0, 0, 3, 0, 0, 0, 1, 0, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[28];
    long2 src2 = secondSource[28];
    ulong16 mask = (ulong16)(2, 3, 2, 3, 0, 3, 0, 0, 3, 0, 1, 0, 1, 3, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[29];
    long2 src2 = secondSource[29];
    ulong16 mask = (ulong16)(0, 0, 0, 1, 2, 3, 1, 0, 0, 1, 0, 2, 3, 0, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[30];
    long2 src2 = secondSource[30];
    ulong16 mask = (ulong16)(2, 2, 1, 3, 2, 2, 0, 1, 1, 2, 1, 2, 1, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long2 src1 = source[31];
    long2 src2 = secondSource[31];
    ulong16 mask = (ulong16)(2, 3, 3, 2, 1, 3, 2, 0, 2, 3, 1, 1, 2, 2, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
