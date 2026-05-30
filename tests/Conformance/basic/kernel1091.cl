// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int16 *src, __global ulong8 *dst) {
  int tid = get_global_id(0);
  ulong8 tmp = as_ulong8(src[tid]);
  dst[tid] = tmp;
}
