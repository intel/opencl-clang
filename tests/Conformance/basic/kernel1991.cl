// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global short *src,
                                   __global short8 *result) {
  result[0] =
      (short8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (short8)(src[0], src[1], src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[2] = (short8)(src[0], src[1], src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[3] =
      (short8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (short8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[5] = (short8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[6] =
      (short8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (short8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (short8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[9] = (short8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[10] = (short8)(src[0], src[1], src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[11] =
      (short8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (short8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (short8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (short8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (short8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[16] = (short8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[17] = (short8)(src[0], src[1], vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[18] =
      (short8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (short8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        src[6], src[7]);
  result[20] = (short8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[21] =
      (short8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (short8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (short8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (short8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (short8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (short8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (short8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (short8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (short8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        src[6], src[7]);
  result[30] = (short8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[31] = (short8)(src[0], vload2(0, src + 1), src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[32] =
      (short8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (short8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[34] = (short8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[35] =
      (short8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (short8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (short8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[38] = (short8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[39] = (short8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[40] = (short8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload3(0, src + 5));
  result[41] =
      (short8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (short8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                        vload2(0, src + 6));
  result[43] = (short8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (short8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (short8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (short8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (short8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (short8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (short8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[50] = (short8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (short8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (short8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (short8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (short8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (short8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (short8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        src[6], src[7]);
  result[57] = (short8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[58] = (short8)(vload2(0, src + 0), src[2], src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[59] =
      (short8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (short8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[61] = (short8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[62] =
      (short8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (short8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (short8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[65] = (short8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[66] = (short8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[67] = (short8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload3(0, src + 5));
  result[68] =
      (short8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (short8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                        vload2(0, src + 6));
  result[70] = (short8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (short8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[72] = (short8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[73] = (short8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[74] = (short8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload3(0, src + 5));
  result[75] = (short8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), src[6], src[7]);
  result[76] = (short8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (short8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload3(0, src + 4), src[7]);
  result[78] =
      (short8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (short8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (short8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                        vload2(0, src + 6));
  result[81] = (short8)(vload2(0, src + 0), vload3(0, src + 2),
                        vload2(0, src + 5), src[7]);
  result[82] =
      (short8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (short8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (short8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (short8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (short8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (short8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (short8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (short8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (short8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[91] = (short8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (short8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (short8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (short8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[95] = (short8)(vload3(0, src + 0), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[96] =
      (short8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (short8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (short8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (short8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (short8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] =
      (short8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] =
      (short8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (short8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] =
      (short8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (short8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (short8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (short8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (short8)(vload8(0, src + 0));
}
