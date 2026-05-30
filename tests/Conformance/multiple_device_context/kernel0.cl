// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test_1(__global int *src, __global int *dst) {
  int tid = get_global_id(0);
  dst[tid] = src[tid];
}
__kernel void sample_test_2(__global int *src, __global int *dst) {
  int tid = get_global_id(0);
  dst[tid] = src[tid] * 2;
}
__kernel void sample_test_3(__global int *src, __global int *dst) {
  int tid = get_global_id(0);
  dst[tid] = src[tid] / 2;
}
__kernel void sample_test_4(__global int *src, __global int *dst) {
  int tid = get_global_id(0);
  dst[tid] = src[tid] / 3;
}
