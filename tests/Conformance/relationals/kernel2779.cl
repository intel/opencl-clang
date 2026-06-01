// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short2 *secondSource,
                          __global short2 *source, __global short4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // short2 src1 , src2;
  short4 tmp;
  tmp = (short4)((short)0);
  {
    short2 src1 = source[0];
    short2 src2 = secondSource[0];
    ushort4 mask = (ushort4)(0, 3, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[1];
    short2 src2 = secondSource[1];
    ushort4 mask = (ushort4)(0, 1, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[2];
    short2 src2 = secondSource[2];
    ushort4 mask = (ushort4)(1, 2, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[3];
    short2 src2 = secondSource[3];
    ushort4 mask = (ushort4)(3, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[4];
    short2 src2 = secondSource[4];
    ushort4 mask = (ushort4)(1, 1, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[5];
    short2 src2 = secondSource[5];
    ushort4 mask = (ushort4)(0, 3, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[6];
    short2 src2 = secondSource[6];
    ushort4 mask = (ushort4)(1, 3, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[7];
    short2 src2 = secondSource[7];
    ushort4 mask = (ushort4)(0, 2, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[8];
    short2 src2 = secondSource[8];
    ushort4 mask = (ushort4)(1, 0, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[9];
    short2 src2 = secondSource[9];
    ushort4 mask = (ushort4)(2, 2, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[10];
    short2 src2 = secondSource[10];
    ushort4 mask = (ushort4)(2, 1, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[11];
    short2 src2 = secondSource[11];
    ushort4 mask = (ushort4)(3, 1, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[12];
    short2 src2 = secondSource[12];
    ushort4 mask = (ushort4)(3, 0, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[13];
    short2 src2 = secondSource[13];
    ushort4 mask = (ushort4)(3, 2, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[14];
    short2 src2 = secondSource[14];
    ushort4 mask = (ushort4)(0, 3, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[15];
    short2 src2 = secondSource[15];
    ushort4 mask = (ushort4)(3, 2, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[16];
    short2 src2 = secondSource[16];
    ushort4 mask = (ushort4)(1, 3, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[17];
    short2 src2 = secondSource[17];
    ushort4 mask = (ushort4)(0, 3, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[18];
    short2 src2 = secondSource[18];
    ushort4 mask = (ushort4)(1, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[19];
    short2 src2 = secondSource[19];
    ushort4 mask = (ushort4)(2, 3, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[20];
    short2 src2 = secondSource[20];
    ushort4 mask = (ushort4)(1, 2, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[21];
    short2 src2 = secondSource[21];
    ushort4 mask = (ushort4)(0, 1, 1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[22];
    short2 src2 = secondSource[22];
    ushort4 mask = (ushort4)(1, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[23];
    short2 src2 = secondSource[23];
    ushort4 mask = (ushort4)(0, 1, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[24];
    short2 src2 = secondSource[24];
    ushort4 mask = (ushort4)(2, 1, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[25];
    short2 src2 = secondSource[25];
    ushort4 mask = (ushort4)(3, 2, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[26];
    short2 src2 = secondSource[26];
    ushort4 mask = (ushort4)(1, 2, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[27];
    short2 src2 = secondSource[27];
    ushort4 mask = (ushort4)(0, 0, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[28];
    short2 src2 = secondSource[28];
    ushort4 mask = (ushort4)(3, 2, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[29];
    short2 src2 = secondSource[29];
    ushort4 mask = (ushort4)(2, 3, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[30];
    short2 src2 = secondSource[30];
    ushort4 mask = (ushort4)(2, 1, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (short4)((short)0);
  {
    short2 src1 = source[31];
    short2 src2 = secondSource[31];
    ushort4 mask = (ushort4)(1, 1, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
