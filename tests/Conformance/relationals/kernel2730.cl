// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char8 *secondSource, __global char8 *source,
                          __global char4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char8 src1 , src2;
  char4 tmp;
  tmp = (char4)((char)0);
  {
    char8 src1 = source[0];
    char8 src2 = secondSource[0];
    uchar4 mask = (uchar4)(11, 14, 5, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[1];
    char8 src2 = secondSource[1];
    uchar4 mask = (uchar4)(6, 8, 5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[2];
    char8 src2 = secondSource[2];
    uchar4 mask = (uchar4)(9, 8, 14, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[3];
    char8 src2 = secondSource[3];
    uchar4 mask = (uchar4)(2, 10, 14, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[4];
    char8 src2 = secondSource[4];
    uchar4 mask = (uchar4)(0, 13, 10, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[5];
    char8 src2 = secondSource[5];
    uchar4 mask = (uchar4)(6, 15, 12, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[6];
    char8 src2 = secondSource[6];
    uchar4 mask = (uchar4)(11, 2, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[7];
    char8 src2 = secondSource[7];
    uchar4 mask = (uchar4)(10, 2, 8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[8];
    char8 src2 = secondSource[8];
    uchar4 mask = (uchar4)(12, 5, 7, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[9];
    char8 src2 = secondSource[9];
    uchar4 mask = (uchar4)(8, 5, 4, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[10];
    char8 src2 = secondSource[10];
    uchar4 mask = (uchar4)(9, 0, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[11];
    char8 src2 = secondSource[11];
    uchar4 mask = (uchar4)(9, 13, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[12];
    char8 src2 = secondSource[12];
    uchar4 mask = (uchar4)(2, 4, 6, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[13];
    char8 src2 = secondSource[13];
    uchar4 mask = (uchar4)(6, 9, 4, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[14];
    char8 src2 = secondSource[14];
    uchar4 mask = (uchar4)(2, 4, 0, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[15];
    char8 src2 = secondSource[15];
    uchar4 mask = (uchar4)(0, 8, 4, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[16];
    char8 src2 = secondSource[16];
    uchar4 mask = (uchar4)(7, 10, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[17];
    char8 src2 = secondSource[17];
    uchar4 mask = (uchar4)(7, 12, 14, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[18];
    char8 src2 = secondSource[18];
    uchar4 mask = (uchar4)(0, 2, 2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[19];
    char8 src2 = secondSource[19];
    uchar4 mask = (uchar4)(5, 1, 9, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[20];
    char8 src2 = secondSource[20];
    uchar4 mask = (uchar4)(13, 11, 5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[21];
    char8 src2 = secondSource[21];
    uchar4 mask = (uchar4)(4, 1, 0, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[22];
    char8 src2 = secondSource[22];
    uchar4 mask = (uchar4)(13, 12, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[23];
    char8 src2 = secondSource[23];
    uchar4 mask = (uchar4)(9, 10, 15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[24];
    char8 src2 = secondSource[24];
    uchar4 mask = (uchar4)(0, 10, 2, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[25];
    char8 src2 = secondSource[25];
    uchar4 mask = (uchar4)(12, 7, 12, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[26];
    char8 src2 = secondSource[26];
    uchar4 mask = (uchar4)(12, 9, 8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[27];
    char8 src2 = secondSource[27];
    uchar4 mask = (uchar4)(15, 0, 6, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[28];
    char8 src2 = secondSource[28];
    uchar4 mask = (uchar4)(9, 8, 1, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[29];
    char8 src2 = secondSource[29];
    uchar4 mask = (uchar4)(6, 11, 11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[30];
    char8 src2 = secondSource[30];
    uchar4 mask = (uchar4)(3, 12, 15, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char8 src1 = source[31];
    char8 src2 = secondSource[31];
    uchar4 mask = (uchar4)(10, 3, 4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
