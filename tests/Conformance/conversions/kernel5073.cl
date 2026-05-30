// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_implicit_long_short(__global short *src,
                                       __global long *dest) {
  size_t i = get_global_id(0);
  dest[i] = src[i];
}
