// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar8 *src, __global uint2 *dst) {
  int tid = get_global_id(0);
  uint2 tmp = as_uint2(src[tid]);
  dst[tid] = tmp;
}
