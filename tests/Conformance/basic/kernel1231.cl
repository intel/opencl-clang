// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float8 *src, __global short16 *dst) {
  int tid = get_global_id(0);
  short16 tmp = as_short16(src[tid]);
  dst[tid] = tmp;
}
