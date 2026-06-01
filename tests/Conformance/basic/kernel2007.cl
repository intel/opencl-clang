// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global long *src, __global long8 *result) {
  result[0] =
      (long8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (long8)(src[0], src[1], src[2], src[3], src[4], src[5],
                      vload2(0, src + 6));
  result[2] = (long8)(src[0], src[1], src[2], src[3], src[4],
                      vload2(0, src + 5), src[7]);
  result[3] =
      (long8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (long8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                      src[6], src[7]);
  result[5] = (long8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                      vload2(0, src + 6));
  result[6] =
      (long8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (long8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (long8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                      src[6], src[7]);
  result[9] = (long8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                      vload2(0, src + 6));
  result[10] = (long8)(src[0], src[1], src[2], vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[11] =
      (long8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (long8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (long8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (long8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (long8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                       src[6], src[7]);
  result[16] = (long8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                       vload2(0, src + 6));
  result[17] = (long8)(src[0], src[1], vload2(0, src + 2), src[4],
                       vload2(0, src + 5), src[7]);
  result[18] =
      (long8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (long8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                       src[6], src[7]);
  result[20] = (long8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                       vload2(0, src + 6));
  result[21] =
      (long8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (long8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (long8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (long8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (long8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (long8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (long8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (long8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (long8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                       src[6], src[7]);
  result[30] = (long8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[31] = (long8)(src[0], vload2(0, src + 1), src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[32] =
      (long8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (long8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[34] = (long8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[35] =
      (long8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (long8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (long8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[38] = (long8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[39] = (long8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[40] = (long8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                       vload3(0, src + 5));
  result[41] =
      (long8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (long8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                       vload2(0, src + 6));
  result[43] = (long8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (long8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (long8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (long8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (long8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (long8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (long8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                       vload2(0, src + 6));
  result[50] = (long8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (long8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (long8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (long8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (long8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (long8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (long8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                       src[6], src[7]);
  result[57] = (long8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[58] = (long8)(vload2(0, src + 0), src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[59] =
      (long8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (long8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[61] = (long8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[62] =
      (long8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (long8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (long8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[65] = (long8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[66] = (long8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[67] = (long8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                       vload3(0, src + 5));
  result[68] =
      (long8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (long8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                       vload2(0, src + 6));
  result[70] = (long8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (long8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                       src[6], src[7]);
  result[72] = (long8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                       vload2(0, src + 6));
  result[73] = (long8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                       vload2(0, src + 5), src[7]);
  result[74] = (long8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                       vload3(0, src + 5));
  result[75] = (long8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload2(0, src + 4), src[6], src[7]);
  result[76] = (long8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (long8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload3(0, src + 4), src[7]);
  result[78] =
      (long8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (long8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (long8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                       vload2(0, src + 6));
  result[81] = (long8)(vload2(0, src + 0), vload3(0, src + 2),
                       vload2(0, src + 5), src[7]);
  result[82] =
      (long8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (long8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (long8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (long8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (long8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (long8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (long8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (long8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (long8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[91] = (long8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (long8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (long8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (long8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[95] = (long8)(vload3(0, src + 0), vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[96] =
      (long8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (long8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (long8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (long8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (long8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] = (long8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] = (long8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (long8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] = (long8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (long8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (long8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (long8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (long8)(vload8(0, src + 0));
}
