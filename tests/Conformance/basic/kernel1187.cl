// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong2 *src, __global uchar16 *dst) {
  int tid = get_global_id(0);
  uchar16 tmp = as_uchar16(src[tid]);
  dst[tid] = tmp;
}
