// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uint *src, __global uint8 *result) {
  result[0] =
      (uint8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (uint8)(src[0], src[1], src[2], src[3], src[4], src[5],
                      vload2(0, src + 6));
  result[2] = (uint8)(src[0], src[1], src[2], src[3], src[4],
                      vload2(0, src + 5), src[7]);
  result[3] =
      (uint8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (uint8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                      src[6], src[7]);
  result[5] = (uint8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                      vload2(0, src + 6));
  result[6] =
      (uint8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (uint8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (uint8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                      src[6], src[7]);
  result[9] = (uint8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                      vload2(0, src + 6));
  result[10] = (uint8)(src[0], src[1], src[2], vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[11] =
      (uint8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (uint8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (uint8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (uint8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (uint8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                       src[6], src[7]);
  result[16] = (uint8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                       vload2(0, src + 6));
  result[17] = (uint8)(src[0], src[1], vload2(0, src + 2), src[4],
                       vload2(0, src + 5), src[7]);
  result[18] =
      (uint8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (uint8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                       src[6], src[7]);
  result[20] = (uint8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                       vload2(0, src + 6));
  result[21] =
      (uint8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (uint8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (uint8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (uint8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (uint8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (uint8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (uint8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (uint8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (uint8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                       src[6], src[7]);
  result[30] = (uint8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[31] = (uint8)(src[0], vload2(0, src + 1), src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[32] =
      (uint8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (uint8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[34] = (uint8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[35] =
      (uint8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (uint8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (uint8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[38] = (uint8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[39] = (uint8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[40] = (uint8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                       vload3(0, src + 5));
  result[41] =
      (uint8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (uint8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                       vload2(0, src + 6));
  result[43] = (uint8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (uint8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (uint8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (uint8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (uint8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (uint8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (uint8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                       vload2(0, src + 6));
  result[50] = (uint8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (uint8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (uint8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (uint8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (uint8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (uint8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (uint8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                       src[6], src[7]);
  result[57] = (uint8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[58] = (uint8)(vload2(0, src + 0), src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[59] =
      (uint8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (uint8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[61] = (uint8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[62] =
      (uint8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (uint8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (uint8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[65] = (uint8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[66] = (uint8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[67] = (uint8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                       vload3(0, src + 5));
  result[68] =
      (uint8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (uint8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                       vload2(0, src + 6));
  result[70] = (uint8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (uint8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                       src[6], src[7]);
  result[72] = (uint8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                       vload2(0, src + 6));
  result[73] = (uint8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                       vload2(0, src + 5), src[7]);
  result[74] = (uint8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                       vload3(0, src + 5));
  result[75] = (uint8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload2(0, src + 4), src[6], src[7]);
  result[76] = (uint8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (uint8)(vload2(0, src + 0), vload2(0, src + 2),
                       vload3(0, src + 4), src[7]);
  result[78] =
      (uint8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (uint8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (uint8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                       vload2(0, src + 6));
  result[81] = (uint8)(vload2(0, src + 0), vload3(0, src + 2),
                       vload2(0, src + 5), src[7]);
  result[82] =
      (uint8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (uint8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (uint8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (uint8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (uint8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (uint8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (uint8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (uint8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (uint8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[91] = (uint8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (uint8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (uint8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (uint8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[95] = (uint8)(vload3(0, src + 0), vload2(0, src + 3),
                       vload2(0, src + 5), src[7]);
  result[96] =
      (uint8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (uint8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (uint8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (uint8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (uint8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] = (uint8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] = (uint8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (uint8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] = (uint8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (uint8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (uint8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (uint8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (uint8)(vload8(0, src + 0));
}
