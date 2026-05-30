// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_implicit_uint_float(__global float *src,
                                       __global uint *dest) {
  size_t i = get_global_id(0);
  dest[i] = src[i];
}
