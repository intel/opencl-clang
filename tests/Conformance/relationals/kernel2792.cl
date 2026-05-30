// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *secondSource,
                          __global short8 *source, __global short2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short8 src1 , src2;
  short2 tmp;
  tmp = (short2)((short)0);
  {
    short8 src1 = source[0];
    short8 src2 = secondSource[0];
    ushort2 mask = (ushort2)(9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[1];
    short8 src2 = secondSource[1];
    ushort2 mask = (ushort2)(3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[2];
    short8 src2 = secondSource[2];
    ushort2 mask = (ushort2)(4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[3];
    short8 src2 = secondSource[3];
    ushort2 mask = (ushort2)(7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[4];
    short8 src2 = secondSource[4];
    ushort2 mask = (ushort2)(8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[5];
    short8 src2 = secondSource[5];
    ushort2 mask = (ushort2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[6];
    short8 src2 = secondSource[6];
    ushort2 mask = (ushort2)(9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[7];
    short8 src2 = secondSource[7];
    ushort2 mask = (ushort2)(9, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[8];
    short8 src2 = secondSource[8];
    ushort2 mask = (ushort2)(6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[9];
    short8 src2 = secondSource[9];
    ushort2 mask = (ushort2)(3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[10];
    short8 src2 = secondSource[10];
    ushort2 mask = (ushort2)(5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[11];
    short8 src2 = secondSource[11];
    ushort2 mask = (ushort2)(1, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[12];
    short8 src2 = secondSource[12];
    ushort2 mask = (ushort2)(11, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[13];
    short8 src2 = secondSource[13];
    ushort2 mask = (ushort2)(0, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[14];
    short8 src2 = secondSource[14];
    ushort2 mask = (ushort2)(5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[15];
    short8 src2 = secondSource[15];
    ushort2 mask = (ushort2)(14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[16];
    short8 src2 = secondSource[16];
    ushort2 mask = (ushort2)(3, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[17];
    short8 src2 = secondSource[17];
    ushort2 mask = (ushort2)(8, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[18];
    short8 src2 = secondSource[18];
    ushort2 mask = (ushort2)(2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[19];
    short8 src2 = secondSource[19];
    ushort2 mask = (ushort2)(15, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[20];
    short8 src2 = secondSource[20];
    ushort2 mask = (ushort2)(13, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[21];
    short8 src2 = secondSource[21];
    ushort2 mask = (ushort2)(5, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[22];
    short8 src2 = secondSource[22];
    ushort2 mask = (ushort2)(12, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[23];
    short8 src2 = secondSource[23];
    ushort2 mask = (ushort2)(9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[24];
    short8 src2 = secondSource[24];
    ushort2 mask = (ushort2)(3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[25];
    short8 src2 = secondSource[25];
    ushort2 mask = (ushort2)(2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[26];
    short8 src2 = secondSource[26];
    ushort2 mask = (ushort2)(3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[27];
    short8 src2 = secondSource[27];
    ushort2 mask = (ushort2)(10, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[28];
    short8 src2 = secondSource[28];
    ushort2 mask = (ushort2)(15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[29];
    short8 src2 = secondSource[29];
    ushort2 mask = (ushort2)(12, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[30];
    short8 src2 = secondSource[30];
    ushort2 mask = (ushort2)(14, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short2)((short)0);
  {
    short8 src1 = source[31];
    short8 src2 = secondSource[31];
    ushort2 mask = (ushort2)(3, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
