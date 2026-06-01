// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global uchar *src,
                                   __global uchar2 *result) {
  result[0] = (uchar2)(src[0], src[1]);
  result[1] = (uchar2)(vload2(0, src + 0));
}
