// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *source, __global char4 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 /*, src2*/;
  char4 tmp;
  tmp = (char4)((char)0);
  {
    char16 src1 = source[0];
    uchar4 mask = (uchar4)(12, 9, 15, 15);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[1];
    uchar4 mask = (uchar4)(5, 7, 4, 9);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[2];
    uchar4 mask = (uchar4)(1, 10, 10, 11);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[3];
    uchar4 mask = (uchar4)(15, 10, 2, 14);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[4];
    uchar4 mask = (uchar4)(7, 6, 1, 15);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[5];
    uchar4 mask = (uchar4)(0, 12, 10, 4);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[6];
    uchar4 mask = (uchar4)(13, 4, 5, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[7];
    uchar4 mask = (uchar4)(14, 15, 1, 0);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[8];
    uchar4 mask = (uchar4)(3, 1, 14, 6);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[9];
    uchar4 mask = (uchar4)(8, 9, 9, 15);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[10];
    uchar4 mask = (uchar4)(0, 12, 2, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[11];
    uchar4 mask = (uchar4)(0, 1, 14, 2);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[12];
    uchar4 mask = (uchar4)(2, 12, 13, 5);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[13];
    uchar4 mask = (uchar4)(5, 12, 12, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[14];
    uchar4 mask = (uchar4)(5, 8, 4, 10);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[15];
    uchar4 mask = (uchar4)(1, 8, 4, 13);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[16];
    uchar4 mask = (uchar4)(7, 6, 13, 9);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[17];
    uchar4 mask = (uchar4)(7, 1, 15, 12);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[18];
    uchar4 mask = (uchar4)(8, 2, 0, 12);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[19];
    uchar4 mask = (uchar4)(6, 5, 11, 0);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[20];
    uchar4 mask = (uchar4)(3, 7, 11, 11);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[21];
    uchar4 mask = (uchar4)(8, 14, 0, 12);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[22];
    uchar4 mask = (uchar4)(12, 8, 8, 5);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[23];
    uchar4 mask = (uchar4)(1, 8, 7, 14);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[24];
    uchar4 mask = (uchar4)(4, 13, 14, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[25];
    uchar4 mask = (uchar4)(4, 10, 15, 2);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[26];
    uchar4 mask = (uchar4)(8, 12, 5, 13);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[27];
    uchar4 mask = (uchar4)(13, 13, 11, 4);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[28];
    uchar4 mask = (uchar4)(6, 10, 10, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[29];
    uchar4 mask = (uchar4)(12, 15, 13, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[30];
    uchar4 mask = (uchar4)(13, 8, 2, 8);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char4)((char)0);
  {
    char16 src1 = source[31];
    uchar4 mask = (uchar4)(13, 10, 0, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
