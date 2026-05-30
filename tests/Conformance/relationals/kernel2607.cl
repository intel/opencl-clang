// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *source, __global long16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 /*, src2*/;
  long16 tmp;
  tmp = (long16)((long)0);
  {
    long8 src1 = source[0];
    ulong16 mask = (ulong16)(7, 6, 3, 4, 6, 5, 7, 4, 3, 4, 7, 2, 7, 4, 7, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[1];
    ulong16 mask = (ulong16)(7, 1, 2, 5, 0, 5, 7, 1, 3, 5, 5, 7, 2, 7, 3, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[2];
    ulong16 mask = (ulong16)(6, 1, 6, 4, 3, 7, 5, 2, 6, 6, 6, 0, 4, 6, 6, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[3];
    ulong16 mask = (ulong16)(5, 6, 3, 5, 6, 4, 3, 3, 0, 3, 7, 5, 7, 7, 7, 0);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[4];
    ulong16 mask = (ulong16)(5, 7, 5, 5, 0, 3, 6, 5, 4, 0, 5, 3, 1, 3, 2, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[5];
    ulong16 mask = (ulong16)(7, 4, 6, 6, 4, 0, 4, 6, 4, 4, 6, 5, 4, 7, 1, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[6];
    ulong16 mask = (ulong16)(0, 5, 1, 0, 3, 0, 7, 0, 7, 3, 4, 6, 4, 3, 6, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[7];
    ulong16 mask = (ulong16)(4, 0, 1, 5, 4, 3, 3, 4, 2, 5, 5, 3, 0, 6, 3, 3);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[8];
    ulong16 mask = (ulong16)(1, 2, 2, 2, 6, 7, 0, 2, 0, 6, 4, 2, 2, 7, 5, 0);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[9];
    ulong16 mask = (ulong16)(2, 7, 0, 6, 6, 2, 3, 3, 1, 5, 5, 5, 5, 1, 3, 3);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[10];
    ulong16 mask = (ulong16)(7, 5, 4, 2, 5, 4, 3, 3, 7, 3, 5, 3, 3, 6, 0, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[11];
    ulong16 mask = (ulong16)(4, 7, 0, 1, 1, 1, 3, 7, 6, 6, 2, 2, 4, 5, 2, 6);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[12];
    ulong16 mask = (ulong16)(4, 4, 3, 2, 2, 4, 3, 6, 5, 2, 3, 0, 6, 3, 0, 6);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[13];
    ulong16 mask = (ulong16)(7, 3, 1, 4, 1, 7, 2, 2, 1, 4, 3, 6, 4, 3, 6, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[14];
    ulong16 mask = (ulong16)(3, 3, 1, 6, 3, 2, 2, 1, 0, 4, 1, 3, 0, 6, 5, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[15];
    ulong16 mask = (ulong16)(6, 3, 6, 1, 6, 6, 4, 4, 3, 4, 5, 4, 0, 4, 6, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[16];
    ulong16 mask = (ulong16)(5, 2, 0, 4, 2, 5, 7, 3, 5, 5, 3, 1, 7, 6, 5, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[17];
    ulong16 mask = (ulong16)(4, 7, 2, 4, 1, 7, 0, 4, 3, 3, 1, 6, 0, 1, 3, 6);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[18];
    ulong16 mask = (ulong16)(5, 1, 5, 2, 5, 0, 1, 3, 2, 6, 2, 1, 6, 2, 4, 5);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[19];
    ulong16 mask = (ulong16)(1, 7, 0, 3, 7, 0, 2, 1, 2, 1, 7, 5, 7, 7, 5, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[20];
    ulong16 mask = (ulong16)(0, 5, 1, 3, 2, 0, 1, 0, 7, 1, 6, 0, 5, 1, 5, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[21];
    ulong16 mask = (ulong16)(2, 3, 5, 0, 3, 0, 6, 2, 1, 2, 7, 2, 2, 1, 3, 5);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[22];
    ulong16 mask = (ulong16)(7, 2, 4, 0, 2, 4, 4, 7, 6, 6, 1, 3, 2, 0, 1, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[23];
    ulong16 mask = (ulong16)(2, 7, 2, 2, 1, 3, 5, 7, 6, 7, 1, 2, 3, 3, 7, 5);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[24];
    ulong16 mask = (ulong16)(5, 1, 0, 4, 2, 5, 2, 2, 3, 5, 4, 2, 3, 7, 5, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[25];
    ulong16 mask = (ulong16)(5, 2, 3, 1, 6, 2, 2, 6, 5, 4, 3, 2, 0, 6, 1, 1);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[26];
    ulong16 mask = (ulong16)(2, 1, 3, 2, 6, 5, 1, 2, 2, 1, 5, 3, 0, 5, 5, 3);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[27];
    ulong16 mask = (ulong16)(5, 7, 4, 4, 0, 6, 7, 5, 5, 7, 4, 2, 3, 5, 3, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[28];
    ulong16 mask = (ulong16)(4, 0, 5, 6, 4, 5, 1, 6, 4, 5, 5, 2, 2, 3, 7, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[29];
    ulong16 mask = (ulong16)(4, 0, 0, 6, 4, 3, 6, 3, 5, 7, 0, 1, 6, 7, 7, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[30];
    ulong16 mask = (ulong16)(2, 7, 2, 0, 1, 5, 3, 5, 3, 5, 0, 0, 3, 2, 6, 2);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long16)((long)0);
  {
    long8 src1 = source[31];
    ulong16 mask = (ulong16)(4, 6, 7, 6, 1, 3, 7, 5, 0, 2, 2, 1, 2, 7, 0, 6);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
