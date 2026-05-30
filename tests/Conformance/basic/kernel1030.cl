// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ushort2 *src, __global uchar4 *dst) {
  int tid = get_global_id(0);
  uchar4 tmp = as_uchar4(src[tid]);
  dst[tid] = tmp;
}
