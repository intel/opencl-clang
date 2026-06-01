// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *source, __global long2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // long8 src1 /*, src2*/;
  long2 tmp;
  tmp = (long2)((long)0);
  {
    long8 src1 = source[0];
    ulong2 mask = (ulong2)(5, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[1];
    ulong2 mask = (ulong2)(5, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[2];
    ulong2 mask = (ulong2)(2, 7);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[3];
    ulong2 mask = (ulong2)(2, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[4];
    ulong2 mask = (ulong2)(4, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[5];
    ulong2 mask = (ulong2)(5, 7);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[6];
    ulong2 mask = (ulong2)(7, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[7];
    ulong2 mask = (ulong2)(1, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[8];
    ulong2 mask = (ulong2)(7, 3);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[9];
    ulong2 mask = (ulong2)(4, 6);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[10];
    ulong2 mask = (ulong2)(6, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[11];
    ulong2 mask = (ulong2)(6, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[12];
    ulong2 mask = (ulong2)(7, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[13];
    ulong2 mask = (ulong2)(7, 7);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[14];
    ulong2 mask = (ulong2)(1, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[15];
    ulong2 mask = (ulong2)(4, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[16];
    ulong2 mask = (ulong2)(0, 7);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[17];
    ulong2 mask = (ulong2)(5, 6);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[18];
    ulong2 mask = (ulong2)(4, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[19];
    ulong2 mask = (ulong2)(1, 2);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[20];
    ulong2 mask = (ulong2)(5, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[21];
    ulong2 mask = (ulong2)(2, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[22];
    ulong2 mask = (ulong2)(0, 3);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[23];
    ulong2 mask = (ulong2)(0, 7);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[24];
    ulong2 mask = (ulong2)(4, 3);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[25];
    ulong2 mask = (ulong2)(6, 5);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[26];
    ulong2 mask = (ulong2)(3, 1);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[27];
    ulong2 mask = (ulong2)(2, 2);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[28];
    ulong2 mask = (ulong2)(6, 2);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[29];
    ulong2 mask = (ulong2)(0, 4);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[30];
    ulong2 mask = (ulong2)(6, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (long2)((long)0);
  {
    long8 src1 = source[31];
    ulong2 mask = (ulong2)(1, 0);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
