// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short4 *src, __global long *dst) {
  int tid = get_global_id(0);
  long tmp = as_long(src[tid]);
  dst[tid] = tmp;
}
