// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong2 *source, __global ulong16 *dest) {
  if (get_global_id(0) != 0)
    return;
  // ulong2 src1 /*, src2*/;
  ulong16 tmp;
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[0];
    ulong16 mask = (ulong16)(0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[0] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[1];
    ulong16 mask = (ulong16)(0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[1] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[2];
    ulong16 mask = (ulong16)(0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[2] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[3];
    ulong16 mask = (ulong16)(0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[3] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[4];
    ulong16 mask = (ulong16)(0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[4] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[5];
    ulong16 mask = (ulong16)(0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[5] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[6];
    ulong16 mask = (ulong16)(1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[6] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[7];
    ulong16 mask = (ulong16)(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[7] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[8];
    ulong16 mask = (ulong16)(0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[8] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[9];
    ulong16 mask = (ulong16)(0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[9] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[10];
    ulong16 mask = (ulong16)(0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[10] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[11];
    ulong16 mask = (ulong16)(0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[11] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[12];
    ulong16 mask = (ulong16)(1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[12] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[13];
    ulong16 mask = (ulong16)(0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[13] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[14];
    ulong16 mask = (ulong16)(1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[14] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[15];
    ulong16 mask = (ulong16)(0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[15] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[16];
    ulong16 mask = (ulong16)(1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[16] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[17];
    ulong16 mask = (ulong16)(0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0);
    tmp = shuffle(src1, mask);
    dest[17] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[18];
    ulong16 mask = (ulong16)(0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[18] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[19];
    ulong16 mask = (ulong16)(1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[19] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[20];
    ulong16 mask = (ulong16)(1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1);
    tmp = shuffle(src1, mask);
    dest[20] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[21];
    ulong16 mask = (ulong16)(1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[21] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[22];
    ulong16 mask = (ulong16)(1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[22] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[23];
    ulong16 mask = (ulong16)(1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[23] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[24];
    ulong16 mask = (ulong16)(1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1);
    tmp = shuffle(src1, mask);
    dest[24] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[25];
    ulong16 mask = (ulong16)(0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[25] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[26];
    ulong16 mask = (ulong16)(0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0);
    tmp = shuffle(src1, mask);
    dest[26] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[27];
    ulong16 mask = (ulong16)(1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0);
    tmp = shuffle(src1, mask);
    dest[27] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[28];
    ulong16 mask = (ulong16)(1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1);
    tmp = shuffle(src1, mask);
    dest[28] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[29];
    ulong16 mask = (ulong16)(0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[29] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[30];
    ulong16 mask = (ulong16)(1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1);
    tmp = shuffle(src1, mask);
    dest[30] = tmp;
  }
  tmp = (ulong16)((ulong)0);
  {
    ulong2 src1 = source[31];
    ulong16 mask = (ulong16)(1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0);
    tmp = shuffle(src1, mask);
    dest[31] = tmp;
  }
}
