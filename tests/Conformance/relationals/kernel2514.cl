// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *source, __global ushort4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort16 src1 /*, src2*/;
  ushort4 tmp;
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[0];
    ushort4 mask = (ushort4)(2, 8, 10, 11);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[1];
    ushort4 mask = (ushort4)(15, 2, 11, 13);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[2];
    ushort4 mask = (ushort4)(12, 8, 5, 13);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[3];
    ushort4 mask = (ushort4)(9, 7, 0, 3);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[4];
    ushort4 mask = (ushort4)(10, 6, 9, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[5];
    ushort4 mask = (ushort4)(9, 10, 13, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[6];
    ushort4 mask = (ushort4)(7, 1, 15, 12);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[7];
    ushort4 mask = (ushort4)(8, 12, 4, 4);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[8];
    ushort4 mask = (ushort4)(0, 0, 12, 4);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[9];
    ushort4 mask = (ushort4)(2, 8, 12, 11);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[10];
    ushort4 mask = (ushort4)(9, 13, 7, 10);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[11];
    ushort4 mask = (ushort4)(7, 11, 1, 2);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[12];
    ushort4 mask = (ushort4)(3, 2, 10, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[13];
    ushort4 mask = (ushort4)(13, 7, 3, 5);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[14];
    ushort4 mask = (ushort4)(1, 0, 2, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[15];
    ushort4 mask = (ushort4)(3, 2, 0, 9);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[16];
    ushort4 mask = (ushort4)(4, 3, 4, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[17];
    ushort4 mask = (ushort4)(10, 14, 12, 14);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[18];
    ushort4 mask = (ushort4)(7, 2, 5, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[19];
    ushort4 mask = (ushort4)(6, 1, 9, 5);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[20];
    ushort4 mask = (ushort4)(0, 6, 4, 6);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[21];
    ushort4 mask = (ushort4)(8, 5, 13, 2);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[22];
    ushort4 mask = (ushort4)(1, 3, 15, 10);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[23];
    ushort4 mask = (ushort4)(4, 3, 7, 14);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[24];
    ushort4 mask = (ushort4)(1, 6, 12, 2);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[25];
    ushort4 mask = (ushort4)(12, 7, 14, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[26];
    ushort4 mask = (ushort4)(9, 9, 14, 10);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[27];
    ushort4 mask = (ushort4)(13, 1, 6, 11);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[28];
    ushort4 mask = (ushort4)(14, 6, 4, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[29];
    ushort4 mask = (ushort4)(7, 15, 13, 14);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[30];
    ushort4 mask = (ushort4)(9, 8, 5, 14);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ushort4)((ushort)0);
  {
    ushort16 src1 = source[31];
    ushort4 mask = (ushort4)(14, 7, 0, 15);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
