// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global float *src,
                                   __global float8 *result) {
  result[0] =
      (float8)(src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7]);
  result[1] = (float8)(src[0], src[1], src[2], src[3], src[4], src[5],
                       vload2(0, src + 6));
  result[2] = (float8)(src[0], src[1], src[2], src[3], src[4],
                       vload2(0, src + 5), src[7]);
  result[3] =
      (float8)(src[0], src[1], src[2], src[3], src[4], vload3(0, src + 5));
  result[4] = (float8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       src[6], src[7]);
  result[5] = (float8)(src[0], src[1], src[2], src[3], vload2(0, src + 4),
                       vload2(0, src + 6));
  result[6] =
      (float8)(src[0], src[1], src[2], src[3], vload3(0, src + 4), src[7]);
  result[7] = (float8)(src[0], src[1], src[2], src[3], vload4(0, src + 4));
  result[8] = (float8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       src[6], src[7]);
  result[9] = (float8)(src[0], src[1], src[2], vload2(0, src + 3), src[5],
                       vload2(0, src + 6));
  result[10] = (float8)(src[0], src[1], src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[11] =
      (float8)(src[0], src[1], src[2], vload2(0, src + 3), vload3(0, src + 5));
  result[12] =
      (float8)(src[0], src[1], src[2], vload3(0, src + 3), src[6], src[7]);
  result[13] =
      (float8)(src[0], src[1], src[2], vload3(0, src + 3), vload2(0, src + 6));
  result[14] = (float8)(src[0], src[1], src[2], vload4(0, src + 3), src[7]);
  result[15] = (float8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[16] = (float8)(src[0], src[1], vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[17] = (float8)(src[0], src[1], vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[18] =
      (float8)(src[0], src[1], vload2(0, src + 2), src[4], vload3(0, src + 5));
  result[19] = (float8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        src[6], src[7]);
  result[20] = (float8)(src[0], src[1], vload2(0, src + 2), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[21] =
      (float8)(src[0], src[1], vload2(0, src + 2), vload3(0, src + 4), src[7]);
  result[22] = (float8)(src[0], src[1], vload2(0, src + 2), vload4(0, src + 4));
  result[23] =
      (float8)(src[0], src[1], vload3(0, src + 2), src[5], src[6], src[7]);
  result[24] =
      (float8)(src[0], src[1], vload3(0, src + 2), src[5], vload2(0, src + 6));
  result[25] =
      (float8)(src[0], src[1], vload3(0, src + 2), vload2(0, src + 5), src[7]);
  result[26] = (float8)(src[0], src[1], vload3(0, src + 2), vload3(0, src + 5));
  result[27] = (float8)(src[0], src[1], vload4(0, src + 2), src[6], src[7]);
  result[28] = (float8)(src[0], src[1], vload4(0, src + 2), vload2(0, src + 6));
  result[29] = (float8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        src[6], src[7]);
  result[30] = (float8)(src[0], vload2(0, src + 1), src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[31] = (float8)(src[0], vload2(0, src + 1), src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[32] =
      (float8)(src[0], vload2(0, src + 1), src[3], src[4], vload3(0, src + 5));
  result[33] = (float8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[34] = (float8)(src[0], vload2(0, src + 1), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[35] =
      (float8)(src[0], vload2(0, src + 1), src[3], vload3(0, src + 4), src[7]);
  result[36] = (float8)(src[0], vload2(0, src + 1), src[3], vload4(0, src + 4));
  result[37] = (float8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[38] = (float8)(src[0], vload2(0, src + 1), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[39] = (float8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[40] = (float8)(src[0], vload2(0, src + 1), vload2(0, src + 3),
                        vload3(0, src + 5));
  result[41] =
      (float8)(src[0], vload2(0, src + 1), vload3(0, src + 3), src[6], src[7]);
  result[42] = (float8)(src[0], vload2(0, src + 1), vload3(0, src + 3),
                        vload2(0, src + 6));
  result[43] = (float8)(src[0], vload2(0, src + 1), vload4(0, src + 3), src[7]);
  result[44] =
      (float8)(src[0], vload3(0, src + 1), src[4], src[5], src[6], src[7]);
  result[45] =
      (float8)(src[0], vload3(0, src + 1), src[4], src[5], vload2(0, src + 6));
  result[46] =
      (float8)(src[0], vload3(0, src + 1), src[4], vload2(0, src + 5), src[7]);
  result[47] = (float8)(src[0], vload3(0, src + 1), src[4], vload3(0, src + 5));
  result[48] =
      (float8)(src[0], vload3(0, src + 1), vload2(0, src + 4), src[6], src[7]);
  result[49] = (float8)(src[0], vload3(0, src + 1), vload2(0, src + 4),
                        vload2(0, src + 6));
  result[50] = (float8)(src[0], vload3(0, src + 1), vload3(0, src + 4), src[7]);
  result[51] = (float8)(src[0], vload3(0, src + 1), vload4(0, src + 4));
  result[52] = (float8)(src[0], vload4(0, src + 1), src[5], src[6], src[7]);
  result[53] = (float8)(src[0], vload4(0, src + 1), src[5], vload2(0, src + 6));
  result[54] = (float8)(src[0], vload4(0, src + 1), vload2(0, src + 5), src[7]);
  result[55] = (float8)(src[0], vload4(0, src + 1), vload3(0, src + 5));
  result[56] = (float8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        src[6], src[7]);
  result[57] = (float8)(vload2(0, src + 0), src[2], src[3], src[4], src[5],
                        vload2(0, src + 6));
  result[58] = (float8)(vload2(0, src + 0), src[2], src[3], src[4],
                        vload2(0, src + 5), src[7]);
  result[59] =
      (float8)(vload2(0, src + 0), src[2], src[3], src[4], vload3(0, src + 5));
  result[60] = (float8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        src[6], src[7]);
  result[61] = (float8)(vload2(0, src + 0), src[2], src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[62] =
      (float8)(vload2(0, src + 0), src[2], src[3], vload3(0, src + 4), src[7]);
  result[63] = (float8)(vload2(0, src + 0), src[2], src[3], vload4(0, src + 4));
  result[64] = (float8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        src[6], src[7]);
  result[65] = (float8)(vload2(0, src + 0), src[2], vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[66] = (float8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[67] = (float8)(vload2(0, src + 0), src[2], vload2(0, src + 3),
                        vload3(0, src + 5));
  result[68] =
      (float8)(vload2(0, src + 0), src[2], vload3(0, src + 3), src[6], src[7]);
  result[69] = (float8)(vload2(0, src + 0), src[2], vload3(0, src + 3),
                        vload2(0, src + 6));
  result[70] = (float8)(vload2(0, src + 0), src[2], vload4(0, src + 3), src[7]);
  result[71] = (float8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        src[6], src[7]);
  result[72] = (float8)(vload2(0, src + 0), vload2(0, src + 2), src[4], src[5],
                        vload2(0, src + 6));
  result[73] = (float8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload2(0, src + 5), src[7]);
  result[74] = (float8)(vload2(0, src + 0), vload2(0, src + 2), src[4],
                        vload3(0, src + 5));
  result[75] = (float8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), src[6], src[7]);
  result[76] = (float8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload2(0, src + 4), vload2(0, src + 6));
  result[77] = (float8)(vload2(0, src + 0), vload2(0, src + 2),
                        vload3(0, src + 4), src[7]);
  result[78] =
      (float8)(vload2(0, src + 0), vload2(0, src + 2), vload4(0, src + 4));
  result[79] =
      (float8)(vload2(0, src + 0), vload3(0, src + 2), src[5], src[6], src[7]);
  result[80] = (float8)(vload2(0, src + 0), vload3(0, src + 2), src[5],
                        vload2(0, src + 6));
  result[81] = (float8)(vload2(0, src + 0), vload3(0, src + 2),
                        vload2(0, src + 5), src[7]);
  result[82] =
      (float8)(vload2(0, src + 0), vload3(0, src + 2), vload3(0, src + 5));
  result[83] = (float8)(vload2(0, src + 0), vload4(0, src + 2), src[6], src[7]);
  result[84] =
      (float8)(vload2(0, src + 0), vload4(0, src + 2), vload2(0, src + 6));
  result[85] =
      (float8)(vload3(0, src + 0), src[3], src[4], src[5], src[6], src[7]);
  result[86] =
      (float8)(vload3(0, src + 0), src[3], src[4], src[5], vload2(0, src + 6));
  result[87] =
      (float8)(vload3(0, src + 0), src[3], src[4], vload2(0, src + 5), src[7]);
  result[88] = (float8)(vload3(0, src + 0), src[3], src[4], vload3(0, src + 5));
  result[89] =
      (float8)(vload3(0, src + 0), src[3], vload2(0, src + 4), src[6], src[7]);
  result[90] = (float8)(vload3(0, src + 0), src[3], vload2(0, src + 4),
                        vload2(0, src + 6));
  result[91] = (float8)(vload3(0, src + 0), src[3], vload3(0, src + 4), src[7]);
  result[92] = (float8)(vload3(0, src + 0), src[3], vload4(0, src + 4));
  result[93] =
      (float8)(vload3(0, src + 0), vload2(0, src + 3), src[5], src[6], src[7]);
  result[94] = (float8)(vload3(0, src + 0), vload2(0, src + 3), src[5],
                        vload2(0, src + 6));
  result[95] = (float8)(vload3(0, src + 0), vload2(0, src + 3),
                        vload2(0, src + 5), src[7]);
  result[96] =
      (float8)(vload3(0, src + 0), vload2(0, src + 3), vload3(0, src + 5));
  result[97] = (float8)(vload3(0, src + 0), vload3(0, src + 3), src[6], src[7]);
  result[98] =
      (float8)(vload3(0, src + 0), vload3(0, src + 3), vload2(0, src + 6));
  result[99] = (float8)(vload3(0, src + 0), vload4(0, src + 3), src[7]);
  result[100] = (float8)(vload4(0, src + 0), src[4], src[5], src[6], src[7]);
  result[101] =
      (float8)(vload4(0, src + 0), src[4], src[5], vload2(0, src + 6));
  result[102] =
      (float8)(vload4(0, src + 0), src[4], vload2(0, src + 5), src[7]);
  result[103] = (float8)(vload4(0, src + 0), src[4], vload3(0, src + 5));
  result[104] =
      (float8)(vload4(0, src + 0), vload2(0, src + 4), src[6], src[7]);
  result[105] =
      (float8)(vload4(0, src + 0), vload2(0, src + 4), vload2(0, src + 6));
  result[106] = (float8)(vload4(0, src + 0), vload3(0, src + 4), src[7]);
  result[107] = (float8)(vload4(0, src + 0), vload4(0, src + 4));
  result[108] = (float8)(vload8(0, src + 0));
}
