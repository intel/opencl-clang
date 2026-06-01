// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short16 *secondSource,
                          __global short16 *source, __global short4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short16 src1 , src2;
  short4 tmp;
  tmp = (short4)((short)0);
  {
    short16 src1 = source[0];
    short16 src2 = secondSource[0];
    ushort4 mask = (ushort4)(8, 17, 22, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[1];
    short16 src2 = secondSource[1];
    ushort4 mask = (ushort4)(5, 15, 26, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[2];
    short16 src2 = secondSource[2];
    ushort4 mask = (ushort4)(27, 28, 18, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[3];
    short16 src2 = secondSource[3];
    ushort4 mask = (ushort4)(7, 30, 30, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[4];
    short16 src2 = secondSource[4];
    ushort4 mask = (ushort4)(7, 29, 9, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[5];
    short16 src2 = secondSource[5];
    ushort4 mask = (ushort4)(14, 26, 16, 18);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[6];
    short16 src2 = secondSource[6];
    ushort4 mask = (ushort4)(14, 1, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[7];
    short16 src2 = secondSource[7];
    ushort4 mask = (ushort4)(27, 29, 0, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[8];
    short16 src2 = secondSource[8];
    ushort4 mask = (ushort4)(28, 31, 26, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[9];
    short16 src2 = secondSource[9];
    ushort4 mask = (ushort4)(29, 2, 10, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[10];
    short16 src2 = secondSource[10];
    ushort4 mask = (ushort4)(5, 6, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[11];
    short16 src2 = secondSource[11];
    ushort4 mask = (ushort4)(22, 7, 5, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[12];
    short16 src2 = secondSource[12];
    ushort4 mask = (ushort4)(5, 18, 7, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[13];
    short16 src2 = secondSource[13];
    ushort4 mask = (ushort4)(8, 2, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[14];
    short16 src2 = secondSource[14];
    ushort4 mask = (ushort4)(19, 8, 16, 21);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[15];
    short16 src2 = secondSource[15];
    ushort4 mask = (ushort4)(20, 30, 20, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[16];
    short16 src2 = secondSource[16];
    ushort4 mask = (ushort4)(27, 21, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[17];
    short16 src2 = secondSource[17];
    ushort4 mask = (ushort4)(17, 28, 12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[18];
    short16 src2 = secondSource[18];
    ushort4 mask = (ushort4)(25, 4, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[19];
    short16 src2 = secondSource[19];
    ushort4 mask = (ushort4)(19, 5, 8, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[20];
    short16 src2 = secondSource[20];
    ushort4 mask = (ushort4)(7, 8, 10, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[21];
    short16 src2 = secondSource[21];
    ushort4 mask = (ushort4)(2, 19, 23, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[22];
    short16 src2 = secondSource[22];
    ushort4 mask = (ushort4)(28, 31, 0, 25);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[23];
    short16 src2 = secondSource[23];
    ushort4 mask = (ushort4)(20, 19, 18, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[24];
    short16 src2 = secondSource[24];
    ushort4 mask = (ushort4)(28, 7, 21, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[25];
    short16 src2 = secondSource[25];
    ushort4 mask = (ushort4)(13, 10, 18, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[26];
    short16 src2 = secondSource[26];
    ushort4 mask = (ushort4)(4, 1, 5, 23);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[27];
    short16 src2 = secondSource[27];
    ushort4 mask = (ushort4)(7, 12, 15, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[28];
    short16 src2 = secondSource[28];
    ushort4 mask = (ushort4)(8, 29, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[29];
    short16 src2 = secondSource[29];
    ushort4 mask = (ushort4)(16, 18, 22, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[30];
    short16 src2 = secondSource[30];
    ushort4 mask = (ushort4)(3, 16, 23, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short16 src1 = source[31];
    short16 src2 = secondSource[31];
    ushort4 mask = (ushort4)(0, 22, 22, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
