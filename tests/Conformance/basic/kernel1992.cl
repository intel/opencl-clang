// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global ushort *src,
                                   __global ushort2 *result) {
  result[0] = (ushort2)(src[0], src[1]);
  result[1] = (ushort2)(vload2(0, src + 0));
}
