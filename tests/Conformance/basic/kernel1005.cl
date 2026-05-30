// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short4 *src, __global int2 *dst) {
  int tid = get_global_id(0);
  int2 tmp = as_int2(src[tid]);
  dst[tid] = tmp;
}
