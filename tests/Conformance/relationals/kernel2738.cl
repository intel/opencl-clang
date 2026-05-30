// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *secondSource,
                          __global char16 *source, __global char4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 , src2;
  char4 tmp;
  tmp = (char4)((char)0);
  {
    char16 src1 = source[0];
    char16 src2 = secondSource[0];
    uchar4 mask = (uchar4)(25, 18, 30, 31);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[1];
    char16 src2 = secondSource[1];
    uchar4 mask = (uchar4)(11, 15, 9, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[2];
    char16 src2 = secondSource[2];
    uchar4 mask = (uchar4)(2, 20, 21, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[3];
    char16 src2 = secondSource[3];
    uchar4 mask = (uchar4)(30, 21, 4, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[4];
    char16 src2 = secondSource[4];
    uchar4 mask = (uchar4)(15, 13, 3, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[5];
    char16 src2 = secondSource[5];
    uchar4 mask = (uchar4)(1, 24, 21, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[6];
    char16 src2 = secondSource[6];
    uchar4 mask = (uchar4)(27, 9, 10, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[7];
    char16 src2 = secondSource[7];
    uchar4 mask = (uchar4)(28, 31, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[8];
    char16 src2 = secondSource[8];
    uchar4 mask = (uchar4)(7, 2, 28, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[9];
    char16 src2 = secondSource[9];
    uchar4 mask = (uchar4)(16, 19, 19, 30);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[10];
    char16 src2 = secondSource[10];
    uchar4 mask = (uchar4)(1, 25, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[11];
    char16 src2 = secondSource[11];
    uchar4 mask = (uchar4)(1, 3, 28, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[12];
    char16 src2 = secondSource[12];
    uchar4 mask = (uchar4)(4, 25, 27, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[13];
    char16 src2 = secondSource[13];
    uchar4 mask = (uchar4)(11, 25, 25, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[14];
    char16 src2 = secondSource[14];
    uchar4 mask = (uchar4)(11, 17, 8, 20);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[15];
    char16 src2 = secondSource[15];
    uchar4 mask = (uchar4)(2, 16, 8, 26);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[16];
    char16 src2 = secondSource[16];
    uchar4 mask = (uchar4)(15, 12, 26, 19);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[17];
    char16 src2 = secondSource[17];
    uchar4 mask = (uchar4)(14, 3, 31, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[18];
    char16 src2 = secondSource[18];
    uchar4 mask = (uchar4)(17, 4, 0, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[19];
    char16 src2 = secondSource[19];
    uchar4 mask = (uchar4)(13, 10, 22, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[20];
    char16 src2 = secondSource[20];
    uchar4 mask = (uchar4)(7, 14, 22, 22);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[21];
    char16 src2 = secondSource[21];
    uchar4 mask = (uchar4)(16, 28, 0, 24);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[22];
    char16 src2 = secondSource[22];
    uchar4 mask = (uchar4)(24, 17, 17, 11);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[23];
    char16 src2 = secondSource[23];
    uchar4 mask = (uchar4)(2, 17, 15, 28);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[24];
    char16 src2 = secondSource[24];
    uchar4 mask = (uchar4)(9, 27, 28, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[25];
    char16 src2 = secondSource[25];
    uchar4 mask = (uchar4)(9, 21, 30, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[26];
    char16 src2 = secondSource[26];
    uchar4 mask = (uchar4)(17, 25, 10, 27);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[27];
    char16 src2 = secondSource[27];
    uchar4 mask = (uchar4)(26, 27, 22, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[28];
    char16 src2 = secondSource[28];
    uchar4 mask = (uchar4)(13, 20, 20, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[29];
    char16 src2 = secondSource[29];
    uchar4 mask = (uchar4)(24, 31, 27, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[30];
    char16 src2 = secondSource[30];
    uchar4 mask = (uchar4)(26, 17, 5, 16);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[31];
    char16 src2 = secondSource[31];
    uchar4 mask = (uchar4)(26, 20, 1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
