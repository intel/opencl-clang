// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint *src, __global short2 *dst) {
  int tid = get_global_id(0);
  short2 tmp = as_short2(src[tid]);
  dst[tid] = tmp;
}
