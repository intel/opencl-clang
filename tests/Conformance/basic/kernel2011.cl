// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global ulong *src,
                                   __global ulong8 *result) {
  result[0] =
      (ulong8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (ulong8)(src[0], src[1], src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[2] = (ulong8)(src[0], src[1], src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[3] =
      (ulong8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (ulong8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[5] = (ulong8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[6] =
      (ulong8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (ulong8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (ulong8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[9] = (ulong8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[10] = (ulong8)(src[0], src[1], src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[11] =
      (ulong8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (ulong8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (ulong8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (ulong8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (ulong8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[16] = (ulong8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[17] = (ulong8)(src[0], src[1], vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[18] =
      (ulong8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (ulong8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        src[6], src[7]);
  result[20] = (ulong8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[21] =
      (ulong8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (ulong8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (ulong8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (ulong8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (ulong8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (ulong8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (ulong8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (ulong8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (ulong8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        src[6], src[7]);
  result[30] = (ulong8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[31] = (ulong8)(src[0], vload2(0, src + 1), src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[32] =
      (ulong8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (ulong8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[34] = (ulong8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[35] =
      (ulong8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (ulong8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (ulong8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[38] = (ulong8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[39] = (ulong8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[40] = (ulong8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload3(0, src + 5));
  result[41] =
      (ulong8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (ulong8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                        vload2(0, src + 6));
  result[43] = (ulong8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (ulong8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (ulong8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (ulong8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (ulong8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (ulong8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (ulong8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[50] = (ulong8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (ulong8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (ulong8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (ulong8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (ulong8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (ulong8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (ulong8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        src[6], src[7]);
  result[57] = (ulong8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[58] = (ulong8)(vload2(0, src + 0), src[2], src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[59] =
      (ulong8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (ulong8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[61] = (ulong8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[62] =
      (ulong8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (ulong8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (ulong8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[65] = (ulong8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[66] = (ulong8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[67] = (ulong8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload3(0, src + 5));
  result[68] =
      (ulong8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (ulong8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                        vload2(0, src + 6));
  result[70] = (ulong8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[72] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[73] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[74] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload3(0, src + 5));
  result[75] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), src[6], src[7]);
  result[76] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (ulong8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload3(0, src + 4), src[7]);
  result[78] =
      (ulong8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (ulong8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (ulong8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                        vload2(0, src + 6));
  result[81] = (ulong8)(vload2(0, src + 0), vload3(0, src + 2),
                        vload2(0, src + 5), src[7]);
  result[82] =
      (ulong8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (ulong8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (ulong8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (ulong8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (ulong8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (ulong8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (ulong8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (ulong8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (ulong8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[91] = (ulong8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (ulong8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (ulong8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (ulong8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[95] = (ulong8)(vload3(0, src + 0), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[96] =
      (ulong8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (ulong8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (ulong8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (ulong8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (ulong8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] =
      (ulong8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] =
      (ulong8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (ulong8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] =
      (ulong8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (ulong8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (ulong8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (ulong8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (ulong8)(vload8(0, src + 0));
}
