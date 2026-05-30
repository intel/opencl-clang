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
        (uint16)(10, 6, 7, 15, 5, 0, 8, 15, 13, 8, 3, 8, 0, 11, 5, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[1];
    int8 src2 = secondSource[1];
    uint16 mask =
        (uint16)(12, 11, 6, 8, 10, 10, 6, 4, 13, 10, 8, 1, 5, 4, 14, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[2];
    int8 src2 = secondSource[2];
    uint16 mask = (uint16)(13, 4, 13, 1, 6, 0, 4, 10, 7, 13, 14, 7, 0, 8, 9, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[3];
    int8 src2 = secondSource[3];
    uint16 mask = (uint16)(5, 1, 4, 6, 9, 14, 6, 1, 4, 11, 14, 4, 11, 4, 7, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[4];
    int8 src2 = secondSource[4];
    uint16 mask =
        (uint16)(0, 2, 7, 12, 14, 12, 10, 9, 11, 4, 0, 15, 2, 1, 15, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[5];
    int8 src2 = secondSource[5];
    uint16 mask = (uint16)(13, 7, 11, 2, 5, 6, 0, 0, 11, 6, 0, 3, 15, 8, 9, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[6];
    int8 src2 = secondSource[6];
    uint16 mask =
        (uint16)(9, 2, 12, 4, 6, 5, 6, 10, 0, 13, 15, 7, 5, 7, 13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[7];
    int8 src2 = secondSource[7];
    uint16 mask = (uint16)(3, 7, 15, 9, 8, 13, 9, 6, 3, 4, 5, 10, 0, 5, 1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[8];
    int8 src2 = secondSource[8];
    uint16 mask = (uint16)(0, 10, 1, 8, 15, 2, 10, 10, 13, 8, 0, 3, 2, 4, 5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[9];
    int8 src2 = secondSource[9];
    uint16 mask = (uint16)(0, 1, 9, 3, 1, 12, 11, 5, 7, 8, 8, 12, 12, 2, 7, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[10];
    int8 src2 = secondSource[10];
    uint16 mask = (uint16)(12, 2, 0, 6, 11, 7, 0, 10, 8, 14, 8, 3, 0, 5, 2, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[11];
    int8 src2 = secondSource[11];
    uint16 mask = (uint16)(9, 10, 9, 9, 5, 4, 7, 15, 1, 6, 11, 6, 13, 4, 3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[12];
    int8 src2 = secondSource[12];
    uint16 mask = (uint16)(4, 12, 0, 4, 2, 9, 6, 15, 12, 3, 7, 1, 2, 5, 13, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[13];
    int8 src2 = secondSource[13];
    uint16 mask =
        (uint16)(9, 4, 1, 7, 11, 2, 14, 13, 4, 14, 4, 13, 4, 12, 12, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[14];
    int8 src2 = secondSource[14];
    uint16 mask =
        (uint16)(14, 11, 0, 1, 1, 10, 2, 5, 5, 10, 4, 2, 8, 14, 1, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[15];
    int8 src2 = secondSource[15];
    uint16 mask =
        (uint16)(13, 15, 10, 12, 15, 8, 13, 10, 1, 5, 6, 15, 5, 4, 4, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[16];
    int8 src2 = secondSource[16];
    uint16 mask = (uint16)(0, 12, 0, 1, 6, 14, 3, 7, 10, 10, 9, 0, 10, 8, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[17];
    int8 src2 = secondSource[17];
    uint16 mask = (uint16)(8, 15, 2, 6, 5, 8, 1, 9, 9, 10, 11, 6, 15, 1, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[18];
    int8 src2 = secondSource[18];
    uint16 mask = (uint16)(12, 4, 9, 12, 0, 3, 3, 15, 6, 4, 1, 7, 13, 3, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[19];
    int8 src2 = secondSource[19];
    uint16 mask =
        (uint16)(10, 13, 13, 11, 5, 7, 0, 1, 9, 0, 14, 4, 12, 11, 9, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[20];
    int8 src2 = secondSource[20];
    uint16 mask = (uint16)(4, 5, 4, 10, 12, 1, 9, 3, 1, 6, 9, 3, 7, 13, 12, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[21];
    int8 src2 = secondSource[21];
    uint16 mask =
        (uint16)(4, 1, 8, 8, 14, 11, 9, 10, 14, 0, 8, 7, 11, 15, 15, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[22];
    int8 src2 = secondSource[22];
    uint16 mask =
        (uint16)(4, 10, 4, 7, 11, 7, 9, 13, 8, 14, 0, 0, 10, 11, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[23];
    int8 src2 = secondSource[23];
    uint16 mask = (uint16)(9, 15, 1, 10, 1, 9, 9, 1, 5, 12, 9, 7, 4, 8, 11, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[24];
    int8 src2 = secondSource[24];
    uint16 mask =
        (uint16)(8, 11, 9, 2, 3, 11, 12, 9, 2, 11, 12, 9, 11, 1, 0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[25];
    int8 src2 = secondSource[25];
    uint16 mask =
        (uint16)(13, 10, 3, 5, 10, 15, 2, 8, 8, 14, 2, 12, 2, 8, 15, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[26];
    int8 src2 = secondSource[26];
    uint16 mask =
        (uint16)(13, 15, 11, 0, 12, 6, 11, 7, 1, 3, 11, 13, 12, 2, 7, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[27];
    int8 src2 = secondSource[27];
    uint16 mask =
        (uint16)(13, 9, 10, 2, 11, 3, 8, 15, 14, 6, 10, 4, 11, 9, 3, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[28];
    int8 src2 = secondSource[28];
    uint16 mask =
        (uint16)(11, 12, 11, 2, 2, 8, 1, 13, 3, 13, 11, 7, 3, 11, 4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[29];
    int8 src2 = secondSource[29];
    uint16 mask =
        (uint16)(12, 5, 12, 3, 13, 1, 12, 15, 2, 1, 13, 14, 2, 0, 3, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[30];
    int8 src2 = secondSource[30];
    uint16 mask =
        (uint16)(12, 12, 5, 9, 12, 10, 10, 9, 8, 5, 8, 9, 11, 5, 15, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (int16)((int)0);
  {
    int8 src1 = source[31];
    int8 src2 = secondSource[31];
    uint16 mask =
        (uint16)(15, 0, 2, 8, 11, 7, 14, 3, 14, 15, 15, 8, 12, 7, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
