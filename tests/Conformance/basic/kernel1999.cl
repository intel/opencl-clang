// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global int *src, __global int8 *result) {
  result[0] =
      (int8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (int8)(src[0], src[1], src[2], src[3], src[4], src[5],
                     vload2(0, src + 6));
  result[2] = (int8)(src[0], src[1], src[2], src[3], src[4], vload2(0, src + 5),
                     src[7]);
  result[3] =
      (int8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (int8)(src[0], src[1], src[2], src[3], vload2(0, src + 4), src[6],
                     src[7]);
  result[5] = (int8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                     vload2(0, src + 6));
  result[6] =
      (int8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (int8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (int8)(src[0], src[1], src[2], vload2(0, src + 3), src[5], src[6],
                     src[7]);
  result[9] = (int8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                     vload2(0, src + 6));
  result[10] = (int8)(src[0], src[1], src[2], vload2(0, src + 3),
                      vload2(0, src + 5), src[7]);
  result[11] =
      (int8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (int8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (int8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (int8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (int8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                      src[6], src[7]);
  result[16] = (int8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                      vload2(0, src + 6));
  result[17] = (int8)(src[0], src[1], vload2(0, src + 2), src[4],
                      vload2(0, src + 5), src[7]);
  result[18] =
      (int8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (int8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                      src[6], src[7]);
  result[20] = (int8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                      vload2(0, src + 6));
  result[21] =
      (int8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (int8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (int8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (int8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (int8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (int8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (int8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (int8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (int8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                      src[6], src[7]);
  result[30] = (int8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                      vload2(0, src + 6));
  result[31] = (int8)(src[0], vload2(0, src + 1), src[3], src[4],
                      vload2(0, src + 5), src[7]);
  result[32] =
      (int8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (int8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                      src[6], src[7]);
  result[34] = (int8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                      vload2(0, src + 6));
  result[35] =
      (int8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (int8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (int8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                      src[6], src[7]);
  result[38] = (int8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                      vload2(0, src + 6));
  result[39] = (int8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                      vload2(0, src + 5), src[7]);
  result[40] = (int8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                      vload3(0, src + 5));
  result[41] =
      (int8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (int8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                      vload2(0, src + 6));
  result[43] = (int8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (int8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (int8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (int8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (int8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (int8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (int8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                      vload2(0, src + 6));
  result[50] = (int8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (int8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (int8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (int8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (int8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (int8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (int8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                      src[6], src[7]);
  result[57] = (int8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                      vload2(0, src + 6));
  result[58] = (int8)(vload2(0, src + 0), src[2], src[3], src[4],
                      vload2(0, src + 5), src[7]);
  result[59] =
      (int8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (int8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                      src[6], src[7]);
  result[61] = (int8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                      vload2(0, src + 6));
  result[62] =
      (int8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (int8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (int8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                      src[6], src[7]);
  result[65] = (int8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                      vload2(0, src + 6));
  result[66] = (int8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                      vload2(0, src + 5), src[7]);
  result[67] = (int8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                      vload3(0, src + 5));
  result[68] =
      (int8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (int8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                      vload2(0, src + 6));
  result[70] = (int8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (int8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                      src[6], src[7]);
  result[72] = (int8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                      vload2(0, src + 6));
  result[73] = (int8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                      vload2(0, src + 5), src[7]);
  result[74] = (int8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                      vload3(0, src + 5));
  result[75] = (int8)(vload2(0, src + 0), vload2(0, src + 2),
                      vload2(0, src + 4), src[6], src[7]);
  result[76] = (int8)(vload2(0, src + 0), vload2(0, src + 2),
                      vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (int8)(vload2(0, src + 0), vload2(0, src + 2),
                      vload3(0, src + 4), src[7]);
  result[78] =
      (int8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (int8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (int8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                      vload2(0, src + 6));
  result[81] = (int8)(vload2(0, src + 0), vload3(0, src + 2),
                      vload2(0, src + 5), src[7]);
  result[82] =
      (int8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (int8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (int8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (int8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (int8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (int8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (int8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (int8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (int8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                      vload2(0, src + 6));
  result[91] = (int8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (int8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (int8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (int8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                      vload2(0, src + 6));
  result[95] = (int8)(vload3(0, src + 0), vload2(0, src + 3),
                      vload2(0, src + 5), src[7]);
  result[96] =
      (int8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (int8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (int8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (int8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (int8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] = (int8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] = (int8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (int8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] = (int8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (int8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (int8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (int8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (int8)(vload8(0, src + 0));
}
