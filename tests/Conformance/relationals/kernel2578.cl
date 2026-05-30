// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *source, __global uint4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // uint16 src1 /*, src2*/;
  uint4 tmp;
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[0];
    uint4 mask = (uint4)(15, 7, 7, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[1];
    uint4 mask = (uint4)(12, 1, 3, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[2];
    uint4 mask = (uint4)(7, 4, 8, 1);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[3];
    uint4 mask = (uint4)(8, 14, 14, 13);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[4];
    uint4 mask = (uint4)(12, 7, 11, 0);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[5];
    uint4 mask = (uint4)(9, 13, 2, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[6];
    uint4 mask = (uint4)(1, 10, 3, 14);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[7];
    uint4 mask = (uint4)(5, 2, 14, 8);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[8];
    uint4 mask = (uint4)(13, 5, 1, 13);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[9];
    uint4 mask = (uint4)(13, 14, 6, 12);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[10];
    uint4 mask = (uint4)(10, 15, 2, 1);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[11];
    uint4 mask = (uint4)(2, 13, 13, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[12];
    uint4 mask = (uint4)(7, 12, 12, 10);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[13];
    uint4 mask = (uint4)(12, 13, 15, 10);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[14];
    uint4 mask = (uint4)(14, 6, 10, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[15];
    uint4 mask = (uint4)(9, 14, 13, 12);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[16];
    uint4 mask = (uint4)(11, 7, 6, 15);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[17];
    uint4 mask = (uint4)(4, 9, 5, 1);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[18];
    uint4 mask = (uint4)(4, 3, 6, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[19];
    uint4 mask = (uint4)(15, 4, 14, 13);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[20];
    uint4 mask = (uint4)(4, 6, 3, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[21];
    uint4 mask = (uint4)(0, 15, 15, 15);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[22];
    uint4 mask = (uint4)(9, 3, 15, 11);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[23];
    uint4 mask = (uint4)(7, 2, 2, 10);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[24];
    uint4 mask = (uint4)(15, 2, 2, 15);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[25];
    uint4 mask = (uint4)(1, 8, 2, 8);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[26];
    uint4 mask = (uint4)(11, 3, 2, 2);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[27];
    uint4 mask = (uint4)(9, 1, 3, 7);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[28];
    uint4 mask = (uint4)(6, 14, 5, 8);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[29];
    uint4 mask = (uint4)(7, 9, 4, 4);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[30];
    uint4 mask = (uint4)(13, 6, 15, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (uint4)((uint)0);
  {
    uint16 src1 = source[31];
    uint4 mask = (uint4)(8, 3, 7, 13);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
