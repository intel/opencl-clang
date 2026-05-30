// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global short *src,
                                   __global short2 *result) {
  result[0] = (short2)(src[0], src[1]);
  result[1] = (short2)(vload2(0, src + 0));
}
