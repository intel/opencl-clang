// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char16 *src, __global ulong2 *dst) {
  int tid = get_global_id(0);
  ulong2 tmp = as_ulong2(src[tid]);
  dst[tid] = tmp;
}
