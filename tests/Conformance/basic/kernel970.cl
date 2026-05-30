// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar4 *src, __global ushort2 *dst) {
  int tid = get_global_id(0);
  ushort2 tmp = as_ushort2(src[tid]);
  dst[tid] = tmp;
}
