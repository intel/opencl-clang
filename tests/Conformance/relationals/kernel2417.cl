// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *source, __global char2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char16 src1 /*, src2*/;
  char2 tmp;
  tmp = (char2)((char)0);
  {
    char16 src1 = source[0];
    uchar2 mask = (uchar2)(11, 9);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[1];
    uchar2 mask = (uchar2)(0, 15);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[2];
    uchar2 mask = (uchar2)(2, 14);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[3];
    uchar2 mask = (uchar2)(0, 9);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[4];
    uchar2 mask = (uchar2)(13, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[5];
    uchar2 mask = (uchar2)(9, 13);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[6];
    uchar2 mask = (uchar2)(2, 15);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[7];
    uchar2 mask = (uchar2)(12, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[8];
    uchar2 mask = (uchar2)(15, 9);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[9];
    uchar2 mask = (uchar2)(14, 2);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[10];
    uchar2 mask = (uchar2)(14, 1);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[11];
    uchar2 mask = (uchar2)(0, 5);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[12];
    uchar2 mask = (uchar2)(9, 4);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[13];
    uchar2 mask = (uchar2)(4, 11);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[14];
    uchar2 mask = (uchar2)(9, 3);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[15];
    uchar2 mask = (uchar2)(5, 13);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[16];
    uchar2 mask = (uchar2)(2, 3);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[17];
    uchar2 mask = (uchar2)(7, 10);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[18];
    uchar2 mask = (uchar2)(7, 2);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[19];
    uchar2 mask = (uchar2)(15, 9);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[20];
    uchar2 mask = (uchar2)(0, 8);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[21];
    uchar2 mask = (uchar2)(4, 9);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[22];
    uchar2 mask = (uchar2)(13, 6);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[23];
    uchar2 mask = (uchar2)(10, 14);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[24];
    uchar2 mask = (uchar2)(13, 4);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[25];
    uchar2 mask = (uchar2)(10, 14);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[26];
    uchar2 mask = (uchar2)(12, 11);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[27];
    uchar2 mask = (uchar2)(7, 5);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[28];
    uchar2 mask = (uchar2)(3, 7);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[29];
    uchar2 mask = (uchar2)(12, 13);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[30];
    uchar2 mask = (uchar2)(9, 2);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char16 src1 = source[31];
    uchar2 mask = (uchar2)(2, 2);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
