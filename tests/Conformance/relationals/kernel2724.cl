// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char4 *secondSource, __global char4 *source,
                          __global char8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char4 src1 , src2;
  char8 tmp;
  tmp = (char8)((char)0);
  {
    char4 src1 = source[0];
    char4 src2 = secondSource[0];
    uchar8 mask = (uchar8)(1, 5, 2, 2, 6, 7, 7, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[1];
    char4 src2 = secondSource[1];
    uchar8 mask = (uchar8)(2, 7, 6, 7, 0, 0, 5, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[2];
    char4 src2 = secondSource[2];
    uchar8 mask = (uchar8)(6, 7, 1, 0, 3, 4, 7, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[3];
    char4 src2 = secondSource[3];
    uchar8 mask = (uchar8)(0, 0, 0, 0, 4, 6, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[4];
    char4 src2 = secondSource[4];
    uchar8 mask = (uchar8)(6, 2, 7, 1, 2, 3, 3, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[5];
    char4 src2 = secondSource[5];
    uchar8 mask = (uchar8)(3, 4, 4, 5, 7, 5, 5, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[6];
    char4 src2 = secondSource[6];
    uchar8 mask = (uchar8)(3, 4, 2, 4, 7, 5, 1, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[7];
    char4 src2 = secondSource[7];
    uchar8 mask = (uchar8)(5, 2, 7, 6, 5, 7, 3, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[8];
    char4 src2 = secondSource[8];
    uchar8 mask = (uchar8)(1, 6, 2, 6, 5, 1, 5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[9];
    char4 src2 = secondSource[9];
    uchar8 mask = (uchar8)(7, 5, 6, 2, 6, 5, 7, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[10];
    char4 src2 = secondSource[10];
    uchar8 mask = (uchar8)(2, 6, 2, 0, 3, 5, 4, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[11];
    char4 src2 = secondSource[11];
    uchar8 mask = (uchar8)(5, 4, 2, 6, 0, 1, 3, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[12];
    char4 src2 = secondSource[12];
    uchar8 mask = (uchar8)(2, 6, 7, 2, 7, 4, 6, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[13];
    char4 src2 = secondSource[13];
    uchar8 mask = (uchar8)(5, 2, 2, 3, 4, 5, 6, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[14];
    char4 src2 = secondSource[14];
    uchar8 mask = (uchar8)(0, 5, 6, 3, 0, 0, 6, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[15];
    char4 src2 = secondSource[15];
    uchar8 mask = (uchar8)(6, 0, 0, 0, 5, 6, 4, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[16];
    char4 src2 = secondSource[16];
    uchar8 mask = (uchar8)(1, 7, 1, 7, 6, 0, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[17];
    char4 src2 = secondSource[17];
    uchar8 mask = (uchar8)(7, 4, 7, 0, 7, 4, 0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[18];
    char4 src2 = secondSource[18];
    uchar8 mask = (uchar8)(7, 7, 1, 2, 3, 3, 6, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[19];
    char4 src2 = secondSource[19];
    uchar8 mask = (uchar8)(1, 7, 4, 0, 1, 6, 0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[20];
    char4 src2 = secondSource[20];
    uchar8 mask = (uchar8)(0, 1, 2, 5, 0, 4, 3, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[21];
    char4 src2 = secondSource[21];
    uchar8 mask = (uchar8)(5, 3, 3, 4, 0, 2, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[22];
    char4 src2 = secondSource[22];
    uchar8 mask = (uchar8)(2, 3, 1, 5, 7, 4, 1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[23];
    char4 src2 = secondSource[23];
    uchar8 mask = (uchar8)(6, 2, 4, 2, 4, 7, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[24];
    char4 src2 = secondSource[24];
    uchar8 mask = (uchar8)(7, 1, 2, 0, 6, 7, 4, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[25];
    char4 src2 = secondSource[25];
    uchar8 mask = (uchar8)(3, 7, 7, 5, 4, 0, 0, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[26];
    char4 src2 = secondSource[26];
    uchar8 mask = (uchar8)(3, 7, 6, 5, 5, 2, 7, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[27];
    char4 src2 = secondSource[27];
    uchar8 mask = (uchar8)(2, 1, 6, 7, 3, 4, 4, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[28];
    char4 src2 = secondSource[28];
    uchar8 mask = (uchar8)(7, 5, 7, 7, 6, 5, 2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[29];
    char4 src2 = secondSource[29];
    uchar8 mask = (uchar8)(7, 2, 5, 7, 3, 7, 0, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[30];
    char4 src2 = secondSource[30];
    uchar8 mask = (uchar8)(6, 0, 4, 2, 6, 1, 5, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char4 src1 = source[31];
    char4 src2 = secondSource[31];
    uchar8 mask = (uchar8)(6, 1, 2, 3, 6, 4, 4, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
