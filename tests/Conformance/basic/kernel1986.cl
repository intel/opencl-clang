// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uchar *src,
                                   __global uchar4 *result) {
  result[0] = (uchar4)(src[0], src[1], src[2], src[3]);
  result[1] = (uchar4)(src[0], src[1], vload2(0, src + 2));
  result[2] = (uchar4)(src[0], vload2(0, src + 1), src[3]);
  result[3] = (uchar4)(src[0], vload3(0, src + 1));
  result[4] = (uchar4)(vload2(0, src + 0), src[2], src[3]);
  result[5] = (uchar4)(vload2(0, src + 0), vload2(0, src + 2));
  result[6] = (uchar4)(vload3(0, src + 0), src[3]);
  result[7] = (uchar4)(vload4(0, src + 0));
}
