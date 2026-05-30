// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong16 *src, __global long16 *dst) {
  int tid = get_global_id(0);
  long16 tmp = as_long16(src[tid]);
  dst[tid] = tmp;
}
