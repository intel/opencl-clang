// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_vector_creation(__global ulong *src,
                                   __global ulong2 *result) {
  result[0] = (ulong2)(src[0], src[1]);
  result[1] = (ulong2)(vload2(0, src + 0));
}
