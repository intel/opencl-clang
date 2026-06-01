// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *source, __global ulong2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong16 src1 /*, src2*/;
  ulong2 tmp;
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[0];
    ulong2 mask = (ulong2)(6, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[1];
    ulong2 mask = (ulong2)(7, 5);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[2];
    ulong2 mask = (ulong2)(14, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[3];
    ulong2 mask = (ulong2)(4, 15);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[4];
    ulong2 mask = (ulong2)(7, 14);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[5];
    ulong2 mask = (ulong2)(9, 2);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[6];
    ulong2 mask = (ulong2)(11, 4);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[7];
    ulong2 mask = (ulong2)(4, 5);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[8];
    ulong2 mask = (ulong2)(12, 5);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[9];
    ulong2 mask = (ulong2)(11, 6);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[10];
    ulong2 mask = (ulong2)(2, 12);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[11];
    ulong2 mask = (ulong2)(2, 10);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[12];
    ulong2 mask = (ulong2)(9, 15);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[13];
    ulong2 mask = (ulong2)(1, 14);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[14];
    ulong2 mask = (ulong2)(15, 6);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[15];
    ulong2 mask = (ulong2)(12, 7);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[16];
    ulong2 mask = (ulong2)(10, 9);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[17];
    ulong2 mask = (ulong2)(15, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[18];
    ulong2 mask = (ulong2)(5, 6);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[19];
    ulong2 mask = (ulong2)(8, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[20];
    ulong2 mask = (ulong2)(4, 4);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[21];
    ulong2 mask = (ulong2)(7, 4);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[22];
    ulong2 mask = (ulong2)(14, 2);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[23];
    ulong2 mask = (ulong2)(2, 14);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[24];
    ulong2 mask = (ulong2)(11, 8);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[25];
    ulong2 mask = (ulong2)(0, 3);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[26];
    ulong2 mask = (ulong2)(13, 14);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[27];
    ulong2 mask = (ulong2)(15, 11);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[28];
    ulong2 mask = (ulong2)(5, 3);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[29];
    ulong2 mask = (ulong2)(9, 5);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[30];
    ulong2 mask = (ulong2)(12, 8);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong16 src1 = source[31];
    ulong2 mask = (ulong2)(2, 9);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
