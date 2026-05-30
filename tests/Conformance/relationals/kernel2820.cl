// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort4 *secondSource,
                          __global ushort4 *source, __global ushort8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort4 src1 , src2;
  ushort8 tmp;
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[0];
    ushort4 src2 = secondSource[0];
    ushort8 mask = (ushort8)(6, 1, 4, 3, 6, 6, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[1];
    ushort4 src2 = secondSource[1];
    ushort8 mask = (ushort8)(2, 3, 5, 2, 5, 0, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[2];
    ushort4 src2 = secondSource[2];
    ushort8 mask = (ushort8)(2, 6, 1, 3, 1, 3, 2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[3];
    ushort4 src2 = secondSource[3];
    ushort8 mask = (ushort8)(7, 6, 2, 4, 3, 4, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[4];
    ushort4 src2 = secondSource[4];
    ushort8 mask = (ushort8)(2, 6, 2, 0, 2, 0, 0, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[5];
    ushort4 src2 = secondSource[5];
    ushort8 mask = (ushort8)(5, 3, 0, 1, 5, 6, 1, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[6];
    ushort4 src2 = secondSource[6];
    ushort8 mask = (ushort8)(5, 1, 3, 6, 7, 1, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[7];
    ushort4 src2 = secondSource[7];
    ushort8 mask = (ushort8)(6, 7, 7, 4, 0, 5, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[8];
    ushort4 src2 = secondSource[8];
    ushort8 mask = (ushort8)(2, 5, 1, 5, 4, 2, 7, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[9];
    ushort4 src2 = secondSource[9];
    ushort8 mask = (ushort8)(0, 5, 7, 7, 6, 2, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[10];
    ushort4 src2 = secondSource[10];
    ushort8 mask = (ushort8)(0, 1, 2, 7, 0, 3, 3, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[11];
    ushort4 src2 = secondSource[11];
    ushort8 mask = (ushort8)(1, 1, 0, 4, 5, 6, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[12];
    ushort4 src2 = secondSource[12];
    ushort8 mask = (ushort8)(7, 5, 1, 2, 2, 3, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[13];
    ushort4 src2 = secondSource[13];
    ushort8 mask = (ushort8)(0, 4, 7, 3, 7, 0, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[14];
    ushort4 src2 = secondSource[14];
    ushort8 mask = (ushort8)(6, 0, 3, 0, 0, 0, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[15];
    ushort4 src2 = secondSource[15];
    ushort8 mask = (ushort8)(4, 6, 5, 6, 1, 0, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[16];
    ushort4 src2 = secondSource[16];
    ushort8 mask = (ushort8)(5, 0, 5, 2, 0, 2, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[17];
    ushort4 src2 = secondSource[17];
    ushort8 mask = (ushort8)(0, 5, 1, 3, 1, 0, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[18];
    ushort4 src2 = secondSource[18];
    ushort8 mask = (ushort8)(4, 6, 6, 2, 6, 3, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[19];
    ushort4 src2 = secondSource[19];
    ushort8 mask = (ushort8)(2, 0, 1, 7, 7, 0, 3, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[20];
    ushort4 src2 = secondSource[20];
    ushort8 mask = (ushort8)(4, 0, 5, 7, 5, 1, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[21];
    ushort4 src2 = secondSource[21];
    ushort8 mask = (ushort8)(3, 7, 3, 2, 6, 3, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[22];
    ushort4 src2 = secondSource[22];
    ushort8 mask = (ushort8)(0, 4, 6, 3, 5, 5, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[23];
    ushort4 src2 = secondSource[23];
    ushort8 mask = (ushort8)(7, 1, 5, 5, 1, 7, 2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[24];
    ushort4 src2 = secondSource[24];
    ushort8 mask = (ushort8)(4, 3, 6, 0, 6, 3, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[25];
    ushort4 src2 = secondSource[25];
    ushort8 mask = (ushort8)(0, 2, 2, 0, 2, 7, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[26];
    ushort4 src2 = secondSource[26];
    ushort8 mask = (ushort8)(1, 0, 2, 4, 0, 3, 3, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[27];
    ushort4 src2 = secondSource[27];
    ushort8 mask = (ushort8)(1, 2, 7, 2, 3, 5, 7, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[28];
    ushort4 src2 = secondSource[28];
    ushort8 mask = (ushort8)(1, 7, 4, 6, 5, 7, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[29];
    ushort4 src2 = secondSource[29];
    ushort8 mask = (ushort8)(5, 5, 7, 0, 5, 3, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[30];
    ushort4 src2 = secondSource[30];
    ushort8 mask = (ushort8)(6, 5, 5, 2, 1, 7, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ushort8)((ushort)0);
  {
    ushort4 src1 = source[31];
    ushort4 src2 = secondSource[31];
    ushort8 mask = (ushort8)(1, 2, 1, 0, 2, 6, 5, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
