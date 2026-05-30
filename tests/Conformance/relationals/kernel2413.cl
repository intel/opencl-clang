// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char8 *source, __global char8 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char8 src1 /*, src2*/;
  char8 tmp;
  tmp = (char8)((char)0);
  {
    char8 src1 = source[0];
    uchar8 mask = (uchar8)(7, 5, 5, 3, 0, 3, 0, 7);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[1];
    uchar8 mask = (uchar8)(2, 2, 2, 5, 6, 6, 7, 3);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[2];
    uchar8 mask = (uchar8)(3, 3, 5, 5, 7, 4, 5, 5);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[3];
    uchar8 mask = (uchar8)(5, 6, 0, 4, 2, 7, 7, 2);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[4];
    uchar8 mask = (uchar8)(1, 0, 6, 3, 5, 7, 2, 6);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[5];
    uchar8 mask = (uchar8)(4, 1, 4, 7, 5, 5, 4, 6);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[6];
    uchar8 mask = (uchar8)(1, 0, 6, 5, 3, 3, 7, 6);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[7];
    uchar8 mask = (uchar8)(2, 5, 2, 1, 2, 7, 4, 4);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[8];
    uchar8 mask = (uchar8)(7, 3, 1, 1, 2, 6, 4, 7);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[9];
    uchar8 mask = (uchar8)(3, 5, 3, 4, 6, 7, 7, 5);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[10];
    uchar8 mask = (uchar8)(3, 3, 5, 2, 6, 1, 4, 6);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[11];
    uchar8 mask = (uchar8)(2, 5, 5, 7, 4, 0, 7, 2);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[12];
    uchar8 mask = (uchar8)(0, 3, 7, 7, 4, 4, 0, 5);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[13];
    uchar8 mask = (uchar8)(2, 2, 5, 2, 3, 2, 7, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[14];
    uchar8 mask = (uchar8)(3, 7, 2, 3, 6, 1, 4, 2);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[15];
    uchar8 mask = (uchar8)(5, 1, 6, 2, 5, 6, 3, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[16];
    uchar8 mask = (uchar8)(0, 5, 4, 4, 7, 1, 3, 6);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[17];
    uchar8 mask = (uchar8)(7, 6, 4, 7, 4, 7, 6, 5);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[18];
    uchar8 mask = (uchar8)(4, 2, 0, 0, 7, 3, 1, 5);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[19];
    uchar8 mask = (uchar8)(5, 7, 4, 0, 3, 4, 1, 3);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[20];
    uchar8 mask = (uchar8)(5, 0, 0, 5, 7, 6, 6, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[21];
    uchar8 mask = (uchar8)(4, 4, 3, 1, 2, 0, 4, 4);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[22];
    uchar8 mask = (uchar8)(7, 5, 2, 2, 4, 3, 1, 7);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[23];
    uchar8 mask = (uchar8)(2, 0, 1, 1, 7, 0, 4, 6);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[24];
    uchar8 mask = (uchar8)(5, 7, 0, 1, 2, 6, 7, 2);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[25];
    uchar8 mask = (uchar8)(0, 2, 1, 7, 5, 5, 4, 6);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[26];
    uchar8 mask = (uchar8)(6, 3, 7, 2, 1, 1, 2, 5);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[27];
    uchar8 mask = (uchar8)(3, 5, 0, 7, 0, 1, 1, 5);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[28];
    uchar8 mask = (uchar8)(3, 4, 2, 3, 7, 6, 2, 4);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[29];
    uchar8 mask = (uchar8)(7, 0, 7, 3, 3, 7, 1, 6);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[30];
    uchar8 mask = (uchar8)(2, 6, 6, 7, 2, 5, 3, 6);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (char8)((char)0);
  {
    char8 src1 = source[31];
    uchar8 mask = (uchar8)(3, 3, 4, 3, 7, 7, 1, 6);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
