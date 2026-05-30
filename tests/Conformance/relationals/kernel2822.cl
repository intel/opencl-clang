// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort4 *secondSource,
                          __global ushort4 *source, __global ushort16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort4 src1 , src2;
  ushort16 tmp;
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[0];
    ushort4 src2 = secondSource[0];
    ushort16 mask = (ushort16)(1, 6, 6, 7, 0, 1, 7, 3, 7, 4, 7, 5, 4, 7, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[1];
    ushort4 src2 = secondSource[1];
    ushort16 mask = (ushort16)(0, 1, 4, 5, 4, 4, 3, 3, 0, 4, 6, 4, 5, 6, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[2];
    ushort4 src2 = secondSource[2];
    ushort16 mask = (ushort16)(3, 5, 4, 4, 3, 1, 7, 3, 3, 6, 6, 2, 4, 2, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[3];
    ushort4 src2 = secondSource[3];
    ushort16 mask = (ushort16)(3, 5, 2, 7, 6, 4, 5, 2, 0, 4, 6, 1, 3, 5, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[4];
    ushort4 src2 = secondSource[4];
    ushort16 mask = (ushort16)(2, 1, 1, 5, 2, 2, 1, 0, 3, 7, 4, 2, 7, 4, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[5];
    ushort4 src2 = secondSource[5];
    ushort16 mask = (ushort16)(4, 0, 2, 4, 1, 0, 3, 5, 4, 1, 1, 7, 7, 1, 5, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[6];
    ushort4 src2 = secondSource[6];
    ushort16 mask = (ushort16)(3, 0, 6, 0, 1, 2, 6, 5, 0, 5, 3, 3, 4, 7, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[7];
    ushort4 src2 = secondSource[7];
    ushort16 mask = (ushort16)(5, 3, 7, 7, 0, 0, 0, 0, 5, 1, 6, 3, 3, 3, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[8];
    ushort4 src2 = secondSource[8];
    ushort16 mask = (ushort16)(2, 5, 6, 6, 0, 0, 6, 2, 1, 4, 6, 2, 4, 4, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[9];
    ushort4 src2 = secondSource[9];
    ushort16 mask = (ushort16)(1, 2, 1, 7, 1, 1, 4, 1, 3, 0, 2, 0, 2, 1, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[10];
    ushort4 src2 = secondSource[10];
    ushort16 mask = (ushort16)(0, 1, 7, 7, 3, 5, 6, 0, 1, 5, 6, 3, 2, 6, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[11];
    ushort4 src2 = secondSource[11];
    ushort16 mask = (ushort16)(6, 3, 4, 0, 5, 0, 4, 6, 1, 0, 2, 2, 0, 1, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[12];
    ushort4 src2 = secondSource[12];
    ushort16 mask = (ushort16)(3, 6, 1, 0, 0, 4, 6, 0, 2, 5, 2, 6, 4, 1, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[13];
    ushort4 src2 = secondSource[13];
    ushort16 mask = (ushort16)(4, 4, 0, 3, 2, 6, 7, 1, 1, 0, 2, 5, 0, 1, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[14];
    ushort4 src2 = secondSource[14];
    ushort16 mask = (ushort16)(3, 5, 3, 6, 3, 6, 5, 1, 3, 4, 2, 2, 3, 0, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[15];
    ushort4 src2 = secondSource[15];
    ushort16 mask = (ushort16)(3, 3, 1, 1, 6, 6, 7, 6, 2, 1, 0, 6, 6, 2, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[16];
    ushort4 src2 = secondSource[16];
    ushort16 mask = (ushort16)(4, 4, 6, 4, 3, 1, 2, 1, 6, 3, 7, 7, 5, 0, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[17];
    ushort4 src2 = secondSource[17];
    ushort16 mask = (ushort16)(0, 0, 4, 1, 6, 1, 1, 4, 7, 7, 7, 4, 6, 7, 5, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[18];
    ushort4 src2 = secondSource[18];
    ushort16 mask = (ushort16)(2, 1, 0, 3, 7, 2, 2, 7, 1, 6, 7, 7, 4, 3, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[19];
    ushort4 src2 = secondSource[19];
    ushort16 mask = (ushort16)(6, 0, 2, 2, 5, 2, 4, 0, 3, 4, 4, 5, 4, 4, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[20];
    ushort4 src2 = secondSource[20];
    ushort16 mask = (ushort16)(1, 6, 4, 6, 0, 2, 6, 5, 3, 6, 0, 1, 6, 1, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[21];
    ushort4 src2 = secondSource[21];
    ushort16 mask = (ushort16)(1, 4, 6, 6, 7, 3, 0, 7, 0, 5, 3, 7, 3, 1, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[22];
    ushort4 src2 = secondSource[22];
    ushort16 mask = (ushort16)(3, 1, 5, 1, 2, 5, 1, 1, 5, 6, 3, 4, 4, 6, 6, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[23];
    ushort4 src2 = secondSource[23];
    ushort16 mask = (ushort16)(2, 4, 3, 4, 4, 1, 0, 5, 5, 5, 3, 6, 4, 4, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[24];
    ushort4 src2 = secondSource[24];
    ushort16 mask = (ushort16)(2, 2, 5, 3, 4, 4, 4, 2, 7, 4, 2, 5, 0, 3, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[25];
    ushort4 src2 = secondSource[25];
    ushort16 mask = (ushort16)(0, 3, 6, 6, 7, 4, 6, 5, 6, 1, 5, 1, 4, 1, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[26];
    ushort4 src2 = secondSource[26];
    ushort16 mask = (ushort16)(3, 7, 1, 7, 5, 7, 0, 6, 1, 6, 0, 7, 3, 0, 2, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[27];
    ushort4 src2 = secondSource[27];
    ushort16 mask = (ushort16)(3, 5, 4, 3, 0, 7, 2, 5, 1, 3, 7, 4, 5, 7, 1, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[28];
    ushort4 src2 = secondSource[28];
    ushort16 mask = (ushort16)(6, 4, 3, 6, 6, 4, 5, 7, 2, 2, 4, 3, 4, 0, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[29];
    ushort4 src2 = secondSource[29];
    ushort16 mask = (ushort16)(0, 4, 6, 5, 3, 1, 1, 0, 2, 3, 1, 3, 0, 3, 2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[30];
    ushort4 src2 = secondSource[30];
    ushort16 mask = (ushort16)(3, 0, 5, 5, 7, 1, 1, 2, 0, 6, 3, 7, 5, 0, 6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[31];
    ushort4 src2 = secondSource[31];
    ushort16 mask = (ushort16)(1, 7, 2, 2, 0, 0, 2, 7, 2, 3, 4, 0, 5, 1, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
