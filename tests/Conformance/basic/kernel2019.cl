// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_vector_creation(__global double *src,
                                   __global double8 *result) {
  result[0] =
      (double8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (double8)(src[0], src[1], src[2], src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[2] = (double8)(src[0], src[1], src[2], src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[3] =
      (double8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (double8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[5] = (double8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[6] =
      (double8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (double8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (double8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[9] = (double8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[10] = (double8)(src[0], src[1], src[2], vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[11] =
      (double8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (double8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (double8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (double8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (double8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                         src[6], src[7]);
  result[16] = (double8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                         vload2(0, src + 6));
  result[17] = (double8)(src[0], src[1], vload2(0, src + 2), src[4],
                         vload2(0, src + 5), src[7]);
  result[18] =
      (double8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (double8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                         src[6], src[7]);
  result[20] = (double8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                         vload2(0, src + 6));
  result[21] =
      (double8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] =
      (double8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (double8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (double8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (double8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] =
      (double8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (double8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] =
      (double8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (double8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                         src[6], src[7]);
  result[30] = (double8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                         vload2(0, src + 6));
  result[31] = (double8)(src[0], vload2(0, src + 1), src[3], src[4],
                         vload2(0, src + 5), src[7]);
  result[32] =
      (double8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (double8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                         src[6], src[7]);
  result[34] = (double8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                         vload2(0, src + 6));
  result[35] =
      (double8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] =
      (double8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (double8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                         src[6], src[7]);
  result[38] = (double8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                         vload2(0, src + 6));
  result[39] = (double8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[40] = (double8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                         vload3(0, src + 5));
  result[41] =
      (double8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (double8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                         vload2(0, src + 6));
  result[43] =
      (double8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (double8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (double8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (double8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] =
      (double8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (double8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (double8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                         vload2(0, src + 6));
  result[50] =
      (double8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (double8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (double8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] =
      (double8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] =
      (double8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (double8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (double8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                         src[6], src[7]);
  result[57] = (double8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                         vload2(0, src + 6));
  result[58] = (double8)(vload2(0, src + 0), src[2], src[3], src[4],
                         vload2(0, src + 5), src[7]);
  result[59] =
      (double8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (double8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                         src[6], src[7]);
  result[61] = (double8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                         vload2(0, src + 6));
  result[62] =
      (double8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] =
      (double8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (double8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                         src[6], src[7]);
  result[65] = (double8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                         vload2(0, src + 6));
  result[66] = (double8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[67] = (double8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                         vload3(0, src + 5));
  result[68] =
      (double8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (double8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                         vload2(0, src + 6));
  result[70] =
      (double8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (double8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                         src[6], src[7]);
  result[72] = (double8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                         vload2(0, src + 6));
  result[73] = (double8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                         vload2(0, src + 5), src[7]);
  result[74] = (double8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                         vload3(0, src + 5));
  result[75] = (double8)(vload2(0, src + 0), vload2(0, src + 2),
                         vload2(0, src + 4), src[6], src[7]);
  result[76] = (double8)(vload2(0, src + 0), vload2(0, src + 2),
                         vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (double8)(vload2(0, src + 0), vload2(0, src + 2),
                         vload3(0, src + 4), src[7]);
  result[78] =
      (double8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (double8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (double8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                         vload2(0, src + 6));
  result[81] = (double8)(vload2(0, src + 0), vload3(0, src + 2),
                         vload2(0, src + 5), src[7]);
  result[82] =
      (double8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] =
      (double8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (double8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (double8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (double8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (double8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] =
      (double8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (double8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (double8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                         vload2(0, src + 6));
  result[91] =
      (double8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (double8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (double8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (double8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                         vload2(0, src + 6));
  result[95] = (double8)(vload3(0, src + 0), vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[96] =
      (double8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] =
      (double8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (double8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (double8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (double8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] =
      (double8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] =
      (double8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (double8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] =
      (double8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (double8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (double8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (double8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (double8)(vload8(0, src + 0));
}
