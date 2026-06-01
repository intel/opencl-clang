// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short4 *secondSource,
                          __global short4 *source, __global short16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short4 src1 , src2;
  short16 tmp;
  tmp = (short16)((short)0);
  {
    short4 src1 = source[0];
    short4 src2 = secondSource[0];
    ushort16 mask = (ushort16)(0, 2, 7, 7, 0, 4, 3, 2, 4, 3, 5, 0, 2, 0, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[1];
    short4 src2 = secondSource[1];
    ushort16 mask = (ushort16)(3, 1, 0, 5, 0, 3, 3, 0, 0, 3, 0, 6, 0, 5, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[2];
    short4 src2 = secondSource[2];
    ushort16 mask = (ushort16)(7, 3, 7, 2, 0, 7, 5, 2, 2, 0, 0, 0, 0, 6, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[3];
    short4 src2 = secondSource[3];
    ushort16 mask = (ushort16)(4, 5, 2, 3, 1, 4, 1, 1, 6, 2, 0, 7, 3, 2, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[4];
    short4 src2 = secondSource[4];
    ushort16 mask = (ushort16)(1, 4, 3, 5, 1, 1, 5, 4, 3, 6, 6, 1, 5, 6, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[5];
    short4 src2 = secondSource[5];
    ushort16 mask = (ushort16)(2, 1, 3, 0, 5, 0, 3, 2, 1, 4, 0, 1, 2, 5, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[6];
    short4 src2 = secondSource[6];
    ushort16 mask = (ushort16)(4, 6, 0, 7, 6, 3, 0, 6, 7, 7, 4, 7, 7, 0, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[7];
    short4 src2 = secondSource[7];
    ushort16 mask = (ushort16)(7, 2, 3, 7, 1, 1, 2, 7, 1, 4, 6, 3, 4, 6, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[8];
    short4 src2 = secondSource[8];
    ushort16 mask = (ushort16)(6, 4, 3, 4, 0, 7, 1, 7, 3, 0, 0, 2, 5, 1, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[9];
    short4 src2 = secondSource[9];
    ushort16 mask = (ushort16)(4, 3, 0, 5, 1, 5, 2, 1, 0, 5, 7, 5, 1, 0, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[10];
    short4 src2 = secondSource[10];
    ushort16 mask = (ushort16)(5, 1, 7, 4, 7, 2, 7, 1, 4, 1, 7, 1, 1, 5, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[11];
    short4 src2 = secondSource[11];
    ushort16 mask = (ushort16)(6, 5, 3, 5, 7, 0, 5, 3, 1, 7, 6, 6, 7, 0, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[12];
    short4 src2 = secondSource[12];
    ushort16 mask = (ushort16)(7, 5, 4, 0, 6, 0, 2, 3, 1, 3, 6, 2, 1, 6, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[13];
    short4 src2 = secondSource[13];
    ushort16 mask = (ushort16)(2, 4, 4, 2, 2, 6, 2, 6, 3, 0, 3, 3, 0, 2, 2, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[14];
    short4 src2 = secondSource[14];
    ushort16 mask = (ushort16)(3, 7, 1, 3, 3, 0, 4, 6, 6, 4, 6, 4, 2, 4, 1, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[15];
    short4 src2 = secondSource[15];
    ushort16 mask = (ushort16)(0, 1, 3, 2, 6, 4, 1, 6, 2, 6, 4, 6, 4, 7, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[16];
    short4 src2 = secondSource[16];
    ushort16 mask = (ushort16)(0, 5, 6, 0, 7, 0, 2, 6, 1, 5, 6, 7, 5, 0, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[17];
    short4 src2 = secondSource[17];
    ushort16 mask = (ushort16)(7, 0, 0, 7, 4, 7, 6, 7, 4, 0, 4, 5, 4, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[18];
    short4 src2 = secondSource[18];
    ushort16 mask = (ushort16)(7, 4, 1, 7, 0, 0, 5, 0, 4, 5, 1, 0, 7, 0, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[19];
    short4 src2 = secondSource[19];
    ushort16 mask = (ushort16)(2, 6, 0, 3, 4, 2, 1, 6, 1, 4, 5, 7, 0, 6, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[20];
    short4 src2 = secondSource[20];
    ushort16 mask = (ushort16)(0, 6, 3, 4, 0, 4, 7, 4, 1, 0, 2, 4, 1, 5, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[21];
    short4 src2 = secondSource[21];
    ushort16 mask = (ushort16)(7, 5, 3, 6, 5, 0, 2, 6, 2, 6, 0, 2, 7, 7, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[22];
    short4 src2 = secondSource[22];
    ushort16 mask = (ushort16)(6, 0, 4, 3, 5, 3, 3, 2, 2, 4, 3, 7, 6, 5, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[23];
    short4 src2 = secondSource[23];
    ushort16 mask = (ushort16)(3, 4, 4, 1, 5, 5, 7, 4, 5, 3, 6, 5, 3, 6, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[24];
    short4 src2 = secondSource[24];
    ushort16 mask = (ushort16)(5, 4, 1, 4, 7, 2, 0, 5, 3, 7, 3, 7, 6, 3, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[25];
    short4 src2 = secondSource[25];
    ushort16 mask = (ushort16)(7, 7, 0, 2, 7, 6, 5, 0, 2, 3, 3, 4, 7, 5, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[26];
    short4 src2 = secondSource[26];
    ushort16 mask = (ushort16)(0, 4, 1, 2, 0, 1, 3, 2, 2, 5, 5, 4, 1, 1, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[27];
    short4 src2 = secondSource[27];
    ushort16 mask = (ushort16)(4, 4, 0, 4, 7, 5, 6, 0, 6, 7, 3, 3, 4, 2, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[28];
    short4 src2 = secondSource[28];
    ushort16 mask = (ushort16)(6, 5, 5, 7, 6, 6, 7, 2, 7, 6, 7, 4, 3, 5, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[29];
    short4 src2 = secondSource[29];
    ushort16 mask = (ushort16)(7, 5, 2, 1, 6, 1, 1, 0, 2, 4, 3, 0, 3, 6, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[30];
    short4 src2 = secondSource[30];
    ushort16 mask = (ushort16)(0, 6, 6, 6, 1, 2, 0, 5, 3, 0, 6, 3, 2, 0, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short16)((short)0);
  {
    short4 src1 = source[31];
    short4 src2 = secondSource[31];
    ushort16 mask = (ushort16)(5, 7, 5, 7, 4, 5, 4, 4, 1, 4, 7, 1, 3, 2, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
