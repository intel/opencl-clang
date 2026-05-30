// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char2 *secondSource, __global char2 *source,
                          __global char2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // char2 src1 , src2;
  char2 tmp;
  tmp = (char2)((char)0);
  {
    char2 src1 = source[0];
    char2 src2 = secondSource[0];
    uchar2 mask = (uchar2)(1, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[1];
    char2 src2 = secondSource[1];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[2];
    char2 src2 = secondSource[2];
    uchar2 mask = (uchar2)(0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[3];
    char2 src2 = secondSource[3];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[4];
    char2 src2 = secondSource[4];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[5];
    char2 src2 = secondSource[5];
    uchar2 mask = (uchar2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[6];
    char2 src2 = secondSource[6];
    uchar2 mask = (uchar2)(3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[7];
    char2 src2 = secondSource[7];
    uchar2 mask = (uchar2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[8];
    char2 src2 = secondSource[8];
    uchar2 mask = (uchar2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[9];
    char2 src2 = secondSource[9];
    uchar2 mask = (uchar2)(1, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[10];
    char2 src2 = secondSource[10];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[11];
    char2 src2 = secondSource[11];
    uchar2 mask = (uchar2)(0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[12];
    char2 src2 = secondSource[12];
    uchar2 mask = (uchar2)(2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[13];
    char2 src2 = secondSource[13];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[14];
    char2 src2 = secondSource[14];
    uchar2 mask = (uchar2)(0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[15];
    char2 src2 = secondSource[15];
    uchar2 mask = (uchar2)(0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[16];
    char2 src2 = secondSource[16];
    uchar2 mask = (uchar2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[17];
    char2 src2 = secondSource[17];
    uchar2 mask = (uchar2)(1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[18];
    char2 src2 = secondSource[18];
    uchar2 mask = (uchar2)(2, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[19];
    char2 src2 = secondSource[19];
    uchar2 mask = (uchar2)(1, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[20];
    char2 src2 = secondSource[20];
    uchar2 mask = (uchar2)(3, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[21];
    char2 src2 = secondSource[21];
    uchar2 mask = (uchar2)(0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[22];
    char2 src2 = secondSource[22];
    uchar2 mask = (uchar2)(0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[23];
    char2 src2 = secondSource[23];
    uchar2 mask = (uchar2)(0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[24];
    char2 src2 = secondSource[24];
    uchar2 mask = (uchar2)(2, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[25];
    char2 src2 = secondSource[25];
    uchar2 mask = (uchar2)(1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[26];
    char2 src2 = secondSource[26];
    uchar2 mask = (uchar2)(1, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[27];
    char2 src2 = secondSource[27];
    uchar2 mask = (uchar2)(0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[28];
    char2 src2 = secondSource[28];
    uchar2 mask = (uchar2)(0, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[29];
    char2 src2 = secondSource[29];
    uchar2 mask = (uchar2)(0, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[30];
    char2 src2 = secondSource[30];
    uchar2 mask = (uchar2)(2, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (char2)((char)0);
  {
    char2 src1 = source[31];
    char2 src2 = secondSource[31];
    uchar2 mask = (uchar2)(0, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
