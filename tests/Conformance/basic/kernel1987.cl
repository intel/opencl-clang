// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uchar *src,
                                   __global uchar8 *result) {
  result[0] =
      (uchar8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (uchar8)(src[0], src[1], src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[2] = (uchar8)(src[0], src[1], src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[3] =
      (uchar8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (uchar8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[5] = (uchar8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[6] =
      (uchar8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (uchar8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (uchar8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[9] = (uchar8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[10] = (uchar8)(src[0], src[1], src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[11] =
      (uchar8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (uchar8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (uchar8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (uchar8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (uchar8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[16] = (uchar8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[17] = (uchar8)(src[0], src[1], vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[18] =
      (uchar8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (uchar8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        src[6], src[7]);
  result[20] = (uchar8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[21] =
      (uchar8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (uchar8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (uchar8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (uchar8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (uchar8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (uchar8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (uchar8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (uchar8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (uchar8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        src[6], src[7]);
  result[30] = (uchar8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[31] = (uchar8)(src[0], vload2(0, src + 1), src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[32] =
      (uchar8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (uchar8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[34] = (uchar8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[35] =
      (uchar8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (uchar8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (uchar8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[38] = (uchar8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[39] = (uchar8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[40] = (uchar8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload3(0, src + 5));
  result[41] =
      (uchar8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (uchar8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                        vload2(0, src + 6));
  result[43] = (uchar8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (uchar8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (uchar8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (uchar8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (uchar8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (uchar8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (uchar8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[50] = (uchar8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (uchar8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (uchar8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (uchar8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (uchar8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (uchar8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (uchar8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        src[6], src[7]);
  result[57] = (uchar8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[58] = (uchar8)(vload2(0, src + 0), src[2], src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[59] =
      (uchar8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (uchar8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[61] = (uchar8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[62] =
      (uchar8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (uchar8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (uchar8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[65] = (uchar8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[66] = (uchar8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[67] = (uchar8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload3(0, src + 5));
  result[68] =
      (uchar8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (uchar8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                        vload2(0, src + 6));
  result[70] = (uchar8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[72] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[73] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[74] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload3(0, src + 5));
  result[75] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), src[6], src[7]);
  result[76] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (uchar8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload3(0, src + 4), src[7]);
  result[78] =
      (uchar8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (uchar8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (uchar8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                        vload2(0, src + 6));
  result[81] = (uchar8)(vload2(0, src + 0), vload3(0, src + 2),
                        vload2(0, src + 5), src[7]);
  result[82] =
      (uchar8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (uchar8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (uchar8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (uchar8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (uchar8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (uchar8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (uchar8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (uchar8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (uchar8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[91] = (uchar8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (uchar8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (uchar8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (uchar8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[95] = (uchar8)(vload3(0, src + 0), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[96] =
      (uchar8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (uchar8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (uchar8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (uchar8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (uchar8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] =
      (uchar8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] =
      (uchar8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (uchar8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] =
      (uchar8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (uchar8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (uchar8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (uchar8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (uchar8)(vload8(0, src + 0));
}
