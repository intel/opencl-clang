// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel(__global int *src, __global int *dst) {
  dst[get_global_id(0)] = src[get_global_id(0)] + 1;
}
