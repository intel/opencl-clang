// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint8 *src, __global ulong4 *dst) {
  int tid = get_global_id(0);
  ulong4 tmp = as_ulong4(src[tid]);
  dst[tid] = tmp;
}
