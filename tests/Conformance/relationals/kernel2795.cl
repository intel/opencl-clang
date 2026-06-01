// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *secondSource,
                          __global short8 *source, __global short4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 , src2;
  short4 tmp;
  tmp = (short4)((short)0);
  {
    short8 src1 = source[0];
    short8 src2 = secondSource[0];
    ushort4 mask = (ushort4)(6, 13, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[1];
    short8 src2 = secondSource[1];
    ushort4 mask = (ushort4)(7, 7, 2, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[2];
    short8 src2 = secondSource[2];
    ushort4 mask = (ushort4)(12, 15, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[3];
    short8 src2 = secondSource[3];
    ushort4 mask = (ushort4)(8, 2, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[4];
    short8 src2 = secondSource[4];
    ushort4 mask = (ushort4)(13, 1, 13, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[5];
    short8 src2 = secondSource[5];
    ushort4 mask = (ushort4)(15, 0, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[6];
    short8 src2 = secondSource[6];
    ushort4 mask = (ushort4)(14, 1, 13, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[7];
    short8 src2 = secondSource[7];
    ushort4 mask = (ushort4)(9, 9, 2, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[8];
    short8 src2 = secondSource[8];
    ushort4 mask = (ushort4)(11, 14, 15, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[9];
    short8 src2 = secondSource[9];
    ushort4 mask = (ushort4)(13, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[10];
    short8 src2 = secondSource[10];
    ushort4 mask = (ushort4)(0, 7, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[11];
    short8 src2 = secondSource[11];
    ushort4 mask = (ushort4)(14, 14, 11, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[12];
    short8 src2 = secondSource[12];
    ushort4 mask = (ushort4)(15, 5, 10, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[13];
    short8 src2 = secondSource[13];
    ushort4 mask = (ushort4)(14, 12, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[14];
    short8 src2 = secondSource[14];
    ushort4 mask = (ushort4)(8, 3, 1, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[15];
    short8 src2 = secondSource[15];
    ushort4 mask = (ushort4)(2, 9, 13, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[16];
    short8 src2 = secondSource[16];
    ushort4 mask = (ushort4)(5, 5, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[17];
    short8 src2 = secondSource[17];
    ushort4 mask = (ushort4)(4, 14, 14, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[18];
    short8 src2 = secondSource[18];
    ushort4 mask = (ushort4)(14, 11, 15, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[19];
    short8 src2 = secondSource[19];
    ushort4 mask = (ushort4)(14, 6, 9, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[20];
    short8 src2 = secondSource[20];
    ushort4 mask = (ushort4)(9, 7, 15, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[21];
    short8 src2 = secondSource[21];
    ushort4 mask = (ushort4)(5, 1, 10, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[22];
    short8 src2 = secondSource[22];
    ushort4 mask = (ushort4)(7, 12, 5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[23];
    short8 src2 = secondSource[23];
    ushort4 mask = (ushort4)(14, 6, 9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[24];
    short8 src2 = secondSource[24];
    ushort4 mask = (ushort4)(7, 12, 0, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[25];
    short8 src2 = secondSource[25];
    ushort4 mask = (ushort4)(2, 6, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[26];
    short8 src2 = secondSource[26];
    ushort4 mask = (ushort4)(15, 3, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[27];
    short8 src2 = secondSource[27];
    ushort4 mask = (ushort4)(10, 8, 13, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[28];
    short8 src2 = secondSource[28];
    ushort4 mask = (ushort4)(14, 1, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[29];
    short8 src2 = secondSource[29];
    ushort4 mask = (ushort4)(2, 10, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[30];
    short8 src2 = secondSource[30];
    ushort4 mask = (ushort4)(8, 6, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short8 src1 = source[31];
    short8 src2 = secondSource[31];
    ushort4 mask = (ushort4)(4, 2, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
