// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int8 *secondSource, __global int8 *source,
                          __global int16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // int8 src1 , src2;
  int16 tmp;
  tmp = (int16)((int)0);
  {
    int8 src1 = source[0];
    int8 src2 = secondSource[0];
    uint16 mask =
        (uint16)(6, 15, 11, 11, 13, 1, 6, 2, 10, 12, 9, 10, 12, 4, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[1];
    int8 src2 = secondSource[1];
    uint16 mask = (uint16)(11, 3, 4, 4, 9, 3, 13, 6, 8, 0, 10, 4, 12, 2, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[2];
    int8 src2 = secondSource[2];
    uint16 mask =
        (uint16)(8, 15, 6, 12, 12, 12, 15, 9, 6, 3, 4, 3, 10, 1, 8, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[3];
    int8 src2 = secondSource[3];
    uint16 mask = (uint16)(7, 2, 0, 3, 6, 3, 9, 4, 3, 1, 10, 6, 7, 0, 4, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[4];
    int8 src2 = secondSource[4];
    uint16 mask =
        (uint16)(15, 11, 6, 12, 9, 1, 14, 6, 9, 5, 10, 10, 7, 9, 1, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[5];
    int8 src2 = secondSource[5];
    uint16 mask = (uint16)(4, 12, 7, 2, 6, 0, 11, 5, 6, 14, 13, 3, 5, 8, 13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[6];
    int8 src2 = secondSource[6];
    uint16 mask =
        (uint16)(9, 7, 13, 11, 14, 0, 15, 11, 12, 11, 12, 2, 1, 0, 11, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[7];
    int8 src2 = secondSource[7];
    uint16 mask = (uint16)(9, 8, 7, 6, 8, 6, 12, 13, 5, 9, 12, 8, 1, 4, 14, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[8];
    int8 src2 = secondSource[8];
    uint16 mask = (uint16)(3, 0, 8, 9, 6, 13, 1, 3, 13, 8, 2, 14, 8, 14, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[9];
    int8 src2 = secondSource[9];
    uint16 mask =
        (uint16)(15, 13, 10, 4, 4, 2, 13, 2, 0, 15, 4, 7, 9, 10, 3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[10];
    int8 src2 = secondSource[10];
    uint16 mask =
        (uint16)(12, 11, 13, 4, 8, 5, 12, 1, 14, 2, 0, 4, 8, 2, 14, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[11];
    int8 src2 = secondSource[11];
    uint16 mask = (uint16)(0, 13, 12, 5, 0, 5, 9, 3, 15, 11, 6, 6, 12, 1, 9, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[12];
    int8 src2 = secondSource[12];
    uint16 mask = (uint16)(9, 13, 9, 0, 10, 6, 0, 9, 8, 9, 13, 12, 3, 5, 1, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[13];
    int8 src2 = secondSource[13];
    uint16 mask = (uint16)(6, 12, 8, 6, 6, 2, 11, 9, 0, 8, 6, 3, 2, 12, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[14];
    int8 src2 = secondSource[14];
    uint16 mask = (uint16)(0, 2, 3, 12, 6, 14, 14, 4, 1, 6, 13, 2, 8, 0, 10, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[15];
    int8 src2 = secondSource[15];
    uint16 mask =
        (uint16)(14, 4, 6, 7, 6, 11, 14, 0, 10, 7, 11, 10, 5, 6, 11, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[16];
    int8 src2 = secondSource[16];
    uint16 mask =
        (uint16)(1, 15, 3, 4, 11, 0, 11, 14, 6, 2, 13, 5, 4, 9, 15, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[17];
    int8 src2 = secondSource[17];
    uint16 mask = (uint16)(1, 0, 14, 14, 5, 6, 1, 7, 15, 0, 4, 7, 15, 8, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[18];
    int8 src2 = secondSource[18];
    uint16 mask = (uint16)(9, 7, 9, 1, 3, 15, 13, 0, 13, 14, 3, 9, 8, 1, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[19];
    int8 src2 = secondSource[19];
    uint16 mask = (uint16)(2, 3, 5, 1, 1, 13, 7, 4, 6, 0, 15, 2, 5, 8, 8, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[20];
    int8 src2 = secondSource[20];
    uint16 mask =
        (uint16)(14, 3, 13, 7, 3, 8, 8, 15, 12, 14, 5, 12, 12, 3, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[21];
    int8 src2 = secondSource[21];
    uint16 mask =
        (uint16)(8, 11, 10, 15, 4, 14, 9, 15, 0, 0, 3, 6, 14, 10, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[22];
    int8 src2 = secondSource[22];
    uint16 mask = (uint16)(15, 1, 2, 15, 7, 0, 8, 0, 4, 0, 14, 9, 13, 5, 7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[23];
    int8 src2 = secondSource[23];
    uint16 mask = (uint16)(2, 5, 8, 13, 9, 5, 5, 10, 6, 15, 9, 15, 11, 6, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[24];
    int8 src2 = secondSource[24];
    uint16 mask =
        (uint16)(0, 10, 4, 1, 8, 6, 0, 2, 14, 0, 9, 12, 15, 4, 14, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[25];
    int8 src2 = secondSource[25];
    uint16 mask =
        (uint16)(9, 10, 7, 15, 2, 12, 13, 12, 1, 0, 12, 10, 13, 6, 13, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[26];
    int8 src2 = secondSource[26];
    uint16 mask = (uint16)(7, 1, 1, 8, 0, 0, 15, 10, 10, 2, 13, 5, 13, 4, 4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[27];
    int8 src2 = secondSource[27];
    uint16 mask = (uint16)(15, 15, 5, 10, 2, 1, 7, 6, 15, 5, 6, 11, 8, 1, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[28];
    int8 src2 = secondSource[28];
    uint16 mask =
        (uint16)(3, 8, 9, 9, 7, 10, 7, 9, 15, 11, 13, 7, 14, 9, 13, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[29];
    int8 src2 = secondSource[29];
    uint16 mask = (uint16)(8, 8, 9, 11, 0, 12, 1, 9, 13, 13, 0, 7, 1, 15, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[30];
    int8 src2 = secondSource[30];
    uint16 mask = (uint16)(2, 9, 13, 6, 10, 1, 5, 8, 8, 0, 15, 6, 2, 12, 0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[31];
    int8 src2 = secondSource[31];
    uint16 mask =
        (uint16)(13, 3, 6, 6, 0, 14, 10, 1, 10, 10, 10, 14, 10, 6, 1, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
