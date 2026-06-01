// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char8 *source, __global char16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char8 src1 /*, src2*/;
  char16 tmp;
  tmp = (char16)((char)0);
  {
    char8 src1 = source[0];
    uchar16 mask = (uchar16)(4, 6, 7, 0, 6, 6, 3, 0, 4, 3, 5, 2, 6, 5, 0, 4);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[1];
    uchar16 mask = (uchar16)(6, 2, 3, 7, 5, 3, 6, 3, 4, 5, 1, 0, 3, 7, 0, 4);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[2];
    uchar16 mask = (uchar16)(5, 5, 7, 7, 6, 5, 3, 0, 4, 0, 2, 4, 4, 0, 2, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[3];
    uchar16 mask = (uchar16)(5, 3, 2, 7, 7, 4, 5, 7, 0, 3, 0, 7, 7, 0, 1, 5);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[4];
    uchar16 mask = (uchar16)(2, 7, 1, 3, 7, 2, 5, 5, 4, 3, 4, 2, 2, 2, 4, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[5];
    uchar16 mask = (uchar16)(3, 3, 1, 1, 5, 5, 2, 6, 6, 5, 3, 3, 4, 1, 6, 5);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[6];
    uchar16 mask = (uchar16)(3, 0, 7, 4, 6, 7, 6, 2, 7, 5, 3, 7, 4, 0, 5, 4);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[7];
    uchar16 mask = (uchar16)(5, 4, 7, 3, 2, 4, 2, 3, 7, 1, 6, 1, 1, 0, 4, 6);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[8];
    uchar16 mask = (uchar16)(5, 0, 2, 1, 3, 6, 4, 7, 3, 2, 6, 5, 0, 0, 3, 7);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[9];
    uchar16 mask = (uchar16)(2, 1, 4, 1, 6, 0, 0, 5, 1, 2, 5, 4, 5, 7, 4, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[10];
    uchar16 mask = (uchar16)(7, 4, 3, 2, 1, 4, 5, 6, 4, 5, 4, 7, 4, 5, 7, 4);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[11];
    uchar16 mask = (uchar16)(1, 1, 0, 0, 1, 2, 1, 2, 4, 6, 4, 4, 1, 4, 3, 7);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[12];
    uchar16 mask = (uchar16)(3, 5, 3, 4, 6, 6, 3, 1, 6, 6, 1, 2, 4, 2, 6, 5);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[13];
    uchar16 mask = (uchar16)(1, 0, 3, 1, 4, 7, 1, 5, 6, 2, 0, 7, 7, 2, 3, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[14];
    uchar16 mask = (uchar16)(2, 7, 0, 0, 3, 4, 5, 6, 0, 7, 2, 0, 6, 4, 5, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[15];
    uchar16 mask = (uchar16)(1, 6, 1, 1, 7, 1, 2, 7, 1, 6, 7, 5, 2, 5, 0, 4);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[16];
    uchar16 mask = (uchar16)(3, 7, 3, 6, 7, 4, 1, 1, 0, 2, 0, 7, 7, 0, 3, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[17];
    uchar16 mask = (uchar16)(1, 0, 4, 4, 4, 2, 1, 7, 4, 7, 2, 2, 1, 6, 4, 2);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[18];
    uchar16 mask = (uchar16)(2, 2, 1, 4, 7, 7, 1, 1, 2, 2, 3, 0, 2, 2, 1, 5);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[19];
    uchar16 mask = (uchar16)(6, 0, 2, 2, 0, 4, 4, 6, 1, 7, 2, 3, 7, 4, 2, 6);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[20];
    uchar16 mask = (uchar16)(5, 3, 4, 1, 1, 7, 5, 5, 6, 3, 0, 3, 6, 1, 5, 0);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[21];
    uchar16 mask = (uchar16)(6, 2, 0, 5, 2, 2, 5, 7, 0, 0, 5, 5, 6, 4, 3, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[22];
    uchar16 mask = (uchar16)(3, 6, 2, 3, 0, 4, 1, 5, 7, 5, 6, 6, 2, 0, 7, 7);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[23];
    uchar16 mask = (uchar16)(2, 6, 2, 7, 1, 5, 7, 2, 7, 5, 2, 6, 5, 1, 2, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[24];
    uchar16 mask = (uchar16)(0, 3, 3, 1, 4, 7, 0, 7, 6, 5, 3, 4, 1, 2, 4, 7);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[25];
    uchar16 mask = (uchar16)(6, 6, 2, 6, 5, 4, 3, 0, 7, 4, 6, 6, 2, 4, 0, 5);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[26];
    uchar16 mask = (uchar16)(5, 3, 1, 4, 0, 0, 7, 2, 7, 7, 2, 2, 2, 3, 1, 4);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[27];
    uchar16 mask = (uchar16)(3, 6, 6, 1, 5, 0, 6, 6, 1, 5, 5, 6, 7, 1, 2, 3);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[28];
    uchar16 mask = (uchar16)(5, 3, 3, 4, 2, 7, 7, 7, 2, 0, 0, 1, 3, 6, 3, 0);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[29];
    uchar16 mask = (uchar16)(6, 7, 7, 5, 6, 0, 7, 5, 3, 2, 5, 4, 2, 1, 0, 4);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[30];
    uchar16 mask = (uchar16)(2, 1, 5, 2, 2, 5, 6, 1, 6, 2, 1, 0, 2, 4, 6, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char16)((char)0);
  {
    char8 src1 = source[31];
    uchar16 mask = (uchar16)(1, 7, 2, 4, 2, 1, 6, 0, 0, 0, 0, 1, 4, 4, 3, 1);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
