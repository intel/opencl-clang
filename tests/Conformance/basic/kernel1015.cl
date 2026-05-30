// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short4 *src, __global ulong *dst) {
  int tid = get_global_id(0);
  ulong tmp = as_ulong(src[tid]);
  dst[tid] = tmp;
}
