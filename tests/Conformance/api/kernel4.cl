// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel __attribute__((reqd_work_group_size(64, 14, 1))) void
sample_test(__global int *src, __global int *dst) {
  int tid = get_global_id(0);
  dst[tid] = src[tid];
}
