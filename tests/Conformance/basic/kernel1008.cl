// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short2 *src, __global uint *dst) {
  int tid = get_global_id(0);
  uint tmp = as_uint(src[tid]);
  dst[tid] = tmp;
}
