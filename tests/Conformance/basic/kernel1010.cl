// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short8 *src, __global uint4 *dst) {
  int tid = get_global_id(0);
  uint4 tmp = as_uint4(src[tid]);
  dst[tid] = tmp;
}
