// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong8 *secondSource,
                          __global ulong8 *source, __global ulong2 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong8 src1 , src2;
  ulong2 tmp;
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[0];
    ulong8 src2 = secondSource[0];
    ulong2 mask = (ulong2)(4, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[0] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[1];
    ulong8 src2 = secondSource[1];
    ulong2 mask = (ulong2)(7, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[1] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[2];
    ulong8 src2 = secondSource[2];
    ulong2 mask = (ulong2)(5, 5);
    tmp = shuffle2(src1, src2, mask);
    dest[2] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[3];
    ulong8 src2 = secondSource[3];
    ulong2 mask = (ulong2)(11, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[3] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[4];
    ulong8 src2 = secondSource[4];
    ulong2 mask = (ulong2)(8, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[4] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[5];
    ulong8 src2 = secondSource[5];
    ulong2 mask = (ulong2)(6, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[5] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[6];
    ulong8 src2 = secondSource[6];
    ulong2 mask = (ulong2)(9, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[6] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[7];
    ulong8 src2 = secondSource[7];
    ulong2 mask = (ulong2)(3, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[7] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[8];
    ulong8 src2 = secondSource[8];
    ulong2 mask = (ulong2)(5, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[8] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[9];
    ulong8 src2 = secondSource[9];
    ulong2 mask = (ulong2)(2, 7);
    tmp = shuffle2(src1, src2, mask);
    dest[9] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[10];
    ulong8 src2 = secondSource[10];
    ulong2 mask = (ulong2)(13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[10] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[11];
    ulong8 src2 = secondSource[11];
    ulong2 mask = (ulong2)(8, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[11] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[12];
    ulong8 src2 = secondSource[12];
    ulong2 mask = (ulong2)(2, 12);
    tmp = shuffle2(src1, src2, mask);
    dest[12] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[13];
    ulong8 src2 = secondSource[13];
    ulong2 mask = (ulong2)(7, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[13] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[14];
    ulong8 src2 = secondSource[14];
    ulong2 mask = (ulong2)(12, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[14] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[15];
    ulong8 src2 = secondSource[15];
    ulong2 mask = (ulong2)(10, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[15] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[16];
    ulong8 src2 = secondSource[16];
    ulong2 mask = (ulong2)(4, 2);
    tmp = shuffle2(src1, src2, mask);
    dest[16] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[17];
    ulong8 src2 = secondSource[17];
    ulong2 mask = (ulong2)(2, 3);
    tmp = shuffle2(src1, src2, mask);
    dest[17] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[18];
    ulong8 src2 = secondSource[18];
    ulong2 mask = (ulong2)(6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[18] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[19];
    ulong8 src2 = secondSource[19];
    ulong2 mask = (ulong2)(6, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[19] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[20];
    ulong8 src2 = secondSource[20];
    ulong2 mask = (ulong2)(5, 8);
    tmp = shuffle2(src1, src2, mask);
    dest[20] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[21];
    ulong8 src2 = secondSource[21];
    ulong2 mask = (ulong2)(12, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[21] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[22];
    ulong8 src2 = secondSource[22];
    ulong2 mask = (ulong2)(5, 6);
    tmp = shuffle2(src1, src2, mask);
    dest[22] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[23];
    ulong8 src2 = secondSource[23];
    ulong2 mask = (ulong2)(4, 10);
    tmp = shuffle2(src1, src2, mask);
    dest[23] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[24];
    ulong8 src2 = secondSource[24];
    ulong2 mask = (ulong2)(15, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[24] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[25];
    ulong8 src2 = secondSource[25];
    ulong2 mask = (ulong2)(7, 14);
    tmp = shuffle2(src1, src2, mask);
    dest[25] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[26];
    ulong8 src2 = secondSource[26];
    ulong2 mask = (ulong2)(13, 15);
    tmp = shuffle2(src1, src2, mask);
    dest[26] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[27];
    ulong8 src2 = secondSource[27];
    ulong2 mask = (ulong2)(9, 13);
    tmp = shuffle2(src1, src2, mask);
    dest[27] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[28];
    ulong8 src2 = secondSource[28];
    ulong2 mask = (ulong2)(8, 1);
    tmp = shuffle2(src1, src2, mask);
    dest[28] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[29];
    ulong8 src2 = secondSource[29];
    ulong2 mask = (ulong2)(8, 4);
    tmp = shuffle2(src1, src2, mask);
    dest[29] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[30];
    ulong8 src2 = secondSource[30];
    ulong2 mask = (ulong2)(0, 0);
    tmp = shuffle2(src1, src2, mask);
    dest[30] = tmp;
  }
  tmp = (ulong2)((ulong)0);
  {
    ulong8 src1 = source[31];
    ulong8 src2 = secondSource[31];
    ulong2 mask = (ulong2)(5, 9);
    tmp = shuffle2(src1, src2, mask);
    dest[31] = tmp;
  }
}
