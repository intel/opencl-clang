// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort4 *source, __global ushort16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ushort4 src1 /*, src2*/;
  ushort16 tmp;
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[0];
    ushort16 mask = (ushort16)(0, 3, 3, 3, 0, 0, 3, 1, 3, 2, 3, 2, 2, 3, 0, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[1];
    ushort16 mask = (ushort16)(0, 0, 2, 2, 2, 2, 1, 1, 0, 2, 3, 2, 2, 3, 3, 1);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[2];
    ushort16 mask = (ushort16)(1, 2, 2, 2, 1, 0, 3, 1, 1, 3, 3, 1, 2, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[3];
    ushort16 mask = (ushort16)(1, 2, 1, 3, 3, 2, 2, 1, 0, 2, 3, 0, 1, 2, 1, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[4];
    ushort16 mask = (ushort16)(1, 0, 0, 2, 1, 1, 0, 0, 1, 3, 2, 1, 3, 2, 3, 3);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[5];
    ushort16 mask = (ushort16)(2, 0, 1, 2, 0, 0, 1, 2, 2, 0, 0, 3, 3, 0, 2, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[6];
    ushort16 mask = (ushort16)(1, 0, 3, 0, 0, 1, 3, 2, 0, 2, 1, 1, 2, 3, 0, 2);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[7];
    ushort16 mask = (ushort16)(2, 1, 3, 3, 0, 0, 0, 0, 2, 0, 3, 1, 1, 1, 1, 2);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[8];
    ushort16 mask = (ushort16)(1, 2, 3, 3, 0, 0, 3, 1, 0, 2, 3, 1, 2, 2, 3, 1);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[9];
    ushort16 mask = (ushort16)(0, 1, 0, 3, 0, 0, 2, 0, 1, 0, 1, 0, 1, 0, 3, 3);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[10];
    ushort16 mask = (ushort16)(0, 0, 3, 3, 1, 2, 3, 0, 0, 2, 3, 1, 1, 3, 0, 2);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[11];
    ushort16 mask = (ushort16)(3, 1, 2, 0, 2, 0, 2, 3, 0, 0, 1, 1, 0, 0, 3, 1);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[12];
    ushort16 mask = (ushort16)(1, 3, 0, 0, 0, 2, 3, 0, 1, 2, 1, 3, 2, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[13];
    ushort16 mask = (ushort16)(2, 2, 0, 1, 1, 3, 3, 0, 0, 0, 1, 2, 0, 0, 2, 0);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[14];
    ushort16 mask = (ushort16)(1, 2, 1, 3, 1, 3, 2, 0, 1, 2, 1, 1, 1, 0, 3, 1);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[15];
    ushort16 mask = (ushort16)(1, 1, 0, 0, 3, 3, 3, 3, 1, 0, 0, 3, 3, 1, 1, 2);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[16];
    ushort16 mask = (ushort16)(2, 2, 3, 2, 1, 0, 1, 0, 3, 1, 3, 3, 2, 0, 0, 2);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[17];
    ushort16 mask = (ushort16)(0, 0, 2, 0, 3, 0, 0, 2, 3, 3, 3, 2, 3, 3, 2, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[18];
    ushort16 mask = (ushort16)(1, 0, 0, 1, 3, 1, 1, 3, 0, 3, 3, 3, 2, 1, 3, 0);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[19];
    ushort16 mask = (ushort16)(3, 0, 1, 1, 2, 1, 2, 0, 1, 2, 2, 2, 2, 2, 0, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[20];
    ushort16 mask = (ushort16)(0, 3, 2, 3, 0, 1, 3, 2, 1, 3, 0, 0, 3, 0, 0, 3);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[21];
    ushort16 mask = (ushort16)(0, 2, 3, 3, 3, 1, 0, 3, 0, 2, 1, 3, 1, 0, 3, 2);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[22];
    ushort16 mask = (ushort16)(1, 0, 2, 0, 1, 2, 0, 0, 2, 3, 1, 2, 2, 3, 3, 1);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[23];
    ushort16 mask = (ushort16)(1, 2, 1, 2, 2, 0, 0, 2, 2, 2, 1, 3, 2, 2, 3, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[24];
    ushort16 mask = (ushort16)(1, 1, 2, 1, 2, 2, 2, 1, 3, 2, 1, 2, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[25];
    ushort16 mask = (ushort16)(0, 1, 3, 3, 3, 2, 3, 2, 3, 0, 2, 0, 2, 0, 2, 2);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[26];
    ushort16 mask = (ushort16)(1, 3, 0, 3, 2, 3, 0, 3, 0, 3, 0, 3, 1, 0, 1, 2);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[27];
    ushort16 mask = (ushort16)(1, 2, 2, 1, 0, 3, 1, 2, 0, 1, 3, 2, 2, 3, 0, 2);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[28];
    ushort16 mask = (ushort16)(3, 2, 1, 3, 3, 2, 2, 3, 1, 1, 2, 1, 2, 0, 3, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[29];
    ushort16 mask = (ushort16)(0, 2, 3, 2, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[30];
    ushort16 mask = (ushort16)(1, 0, 2, 2, 3, 0, 0, 1, 0, 3, 1, 3, 2, 0, 3, 0);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ushort16)((ushort)0);
  {
    ushort4 src1 = source[31];
    ushort16 mask = (ushort16)(0, 3, 1, 1, 0, 0, 1, 3, 1, 1, 2, 0, 2, 0, 1, 3);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
