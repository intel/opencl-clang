// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global ulong *src,
                                   __global ulong4 *result) {
  result[0] = (ulong4)(src[0], src[1], src[2], src[3]);
  result[1] = (ulong4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (ulong4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (ulong4)(src[0], vload3(0, src + 1));
  result[4] = (ulong4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (ulong4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (ulong4)(vload3(0, src + 0), src[3]);
  result[7] = (ulong4)(vload4(0, src + 0));
}
