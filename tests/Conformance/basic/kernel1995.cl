// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global ushort *src,
                                   __global ushort8 *result) {
  result[0] =
      (ushort8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (ushort8)(src[0], src[1], src[2], src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[2] = (ushort8)(src[0], src[1], src[2], src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[3] =
      (ushort8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (ushort8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[5] = (ushort8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[6] =
      (ushort8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (ushort8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (ushort8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[9] = (ushort8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[10] = (ushort8)(src[0], src[1], src[2], vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[11] =
      (ushort8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (ushort8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (ushort8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (ushort8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (ushort8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                         src[6], src[7]);
  result[16] = (ushort8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                         vload2(0, src + 6));
  result[17] = (ushort8)(src[0], src[1], vload2(0, src + 2), src[4],
                         vload2(0, src + 5), src[7]);
  result[18] =
      (ushort8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (ushort8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                         src[6], src[7]);
  result[20] = (ushort8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                         vload2(0, src + 6));
  result[21] =
      (ushort8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] =
      (ushort8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (ushort8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (ushort8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (ushort8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] =
      (ushort8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (ushort8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] =
      (ushort8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (ushort8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                         src[6], src[7]);
  result[30] = (ushort8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                         vload2(0, src + 6));
  result[31] = (ushort8)(src[0], vload2(0, src + 1), src[3], src[4],
                         vload2(0, src + 5), src[7]);
  result[32] =
      (ushort8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (ushort8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                         src[6], src[7]);
  result[34] = (ushort8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                         vload2(0, src + 6));
  result[35] =
      (ushort8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] =
      (ushort8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (ushort8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                         src[6], src[7]);
  result[38] = (ushort8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                         vload2(0, src + 6));
  result[39] = (ushort8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[40] = (ushort8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                         vload3(0, src + 5));
  result[41] =
      (ushort8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (ushort8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                         vload2(0, src + 6));
  result[43] =
      (ushort8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (ushort8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (ushort8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (ushort8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] =
      (ushort8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (ushort8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (ushort8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                         vload2(0, src + 6));
  result[50] =
      (ushort8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (ushort8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (ushort8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] =
      (ushort8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] =
      (ushort8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (ushort8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (ushort8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                         src[6], src[7]);
  result[57] = (ushort8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                         vload2(0, src + 6));
  result[58] = (ushort8)(vload2(0, src + 0), src[2], src[3], src[4],
                         vload2(0, src + 5), src[7]);
  result[59] =
      (ushort8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (ushort8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                         src[6], src[7]);
  result[61] = (ushort8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                         vload2(0, src + 6));
  result[62] =
      (ushort8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] =
      (ushort8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (ushort8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                         src[6], src[7]);
  result[65] = (ushort8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                         vload2(0, src + 6));
  result[66] = (ushort8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[67] = (ushort8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                         vload3(0, src + 5));
  result[68] =
      (ushort8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (ushort8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                         vload2(0, src + 6));
  result[70] =
      (ushort8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                         src[6], src[7]);
  result[72] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                         vload2(0, src + 6));
  result[73] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                         vload2(0, src + 5), src[7]);
  result[74] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                         vload3(0, src + 5));
  result[75] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2),
                         vload2(0, src + 4), src[6], src[7]);
  result[76] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2),
                         vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (ushort8)(vload2(0, src + 0), vload2(0, src + 2),
                         vload3(0, src + 4), src[7]);
  result[78] =
      (ushort8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (ushort8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (ushort8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                         vload2(0, src + 6));
  result[81] = (ushort8)(vload2(0, src + 0), vload3(0, src + 2),
                         vload2(0, src + 5), src[7]);
  result[82] =
      (ushort8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] =
      (ushort8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (ushort8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (ushort8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (ushort8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (ushort8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] =
      (ushort8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (ushort8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (ushort8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                         vload2(0, src + 6));
  result[91] =
      (ushort8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (ushort8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (ushort8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (ushort8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                         vload2(0, src + 6));
  result[95] = (ushort8)(vload3(0, src + 0), vload2(0, src + 3),
                         vload2(0, src + 5), src[7]);
  result[96] =
      (ushort8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] =
      (ushort8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (ushort8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (ushort8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (ushort8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] =
      (ushort8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] =
      (ushort8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (ushort8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] =
      (ushort8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (ushort8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (ushort8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (ushort8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (ushort8)(vload8(0, src + 0));
}
