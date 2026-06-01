// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global char *src, __global char8 *result) {
  result[0] =
      (char8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (char8)(src[0], src[1], src[2], src[3], src[4], src[5],
                      vload2(0, src + 6));
  result[2] = (char8)(src[0], src[1], src[2], src[3], src[4],
                      vload2(0, src + 5), src[7]);
  result[3] =
      (char8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (char8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                      src[6], src[7]);
  result[5] = (char8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                      vload2(0, src + 6));
  result[6] =
      (char8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (char8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (char8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                      src[6], src[7]);
  result[9] = (char8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                      vload2(0, src + 6));
  result[10] = (char8)(src[0], src[1], src[2], vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[11] =
      (char8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (char8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (char8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (char8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (char8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                       src[6], src[7]);
  result[16] = (char8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                       vload2(0, src + 6));
  result[17] = (char8)(src[0], src[1], vload2(0, src + 2), src[4],
                       vload2(0, src + 5), src[7]);
  result[18] =
      (char8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (char8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                       src[6], src[7]);
  result[20] = (char8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                       vload2(0, src + 6));
  result[21] =
      (char8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (char8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (char8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (char8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (char8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (char8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (char8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (char8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (char8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                       src[6], src[7]);
  result[30] = (char8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[31] = (char8)(src[0], vload2(0, src + 1), src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[32] =
      (char8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (char8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[34] = (char8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[35] =
      (char8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (char8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (char8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[38] = (char8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[39] = (char8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[40] = (char8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                       vload3(0, src + 5));
  result[41] =
      (char8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (char8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                       vload2(0, src + 6));
  result[43] = (char8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (char8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (char8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (char8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (char8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (char8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (char8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                       vload2(0, src + 6));
  result[50] = (char8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (char8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (char8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (char8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (char8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (char8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (char8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                       src[6], src[7]);
  result[57] = (char8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[58] = (char8)(vload2(0, src + 0), src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[59] =
      (char8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (char8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[61] = (char8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[62] =
      (char8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (char8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (char8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[65] = (char8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[66] = (char8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[67] = (char8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                       vload3(0, src + 5));
  result[68] =
      (char8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (char8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                       vload2(0, src + 6));
  result[70] = (char8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (char8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                       src[6], src[7]);
  result[72] = (char8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                       vload2(0, src + 6));
  result[73] = (char8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                       vload2(0, src + 5), src[7]);
  result[74] = (char8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                       vload3(0, src + 5));
  result[75] = (char8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload2(0, src + 4), src[6], src[7]);
  result[76] = (char8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (char8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload3(0, src + 4), src[7]);
  result[78] =
      (char8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (char8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (char8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                       vload2(0, src + 6));
  result[81] = (char8)(vload2(0, src + 0), vload3(0, src + 2),
                       vload2(0, src + 5), src[7]);
  result[82] =
      (char8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (char8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (char8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (char8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (char8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (char8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (char8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (char8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (char8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[91] = (char8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (char8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (char8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (char8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[95] = (char8)(vload3(0, src + 0), vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[96] =
      (char8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (char8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (char8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (char8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (char8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] = (char8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] = (char8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (char8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] = (char8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (char8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (char8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (char8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (char8)(vload8(0, src + 0));
}
