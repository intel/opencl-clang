// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
kernel void test_kernel(global float *src, global long *dst) {
  uint tid = get_global_id(0);
  dst[tid] = (long)src;
}
