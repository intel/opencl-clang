// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global long2 *src, __global int4 *dst) {
  int tid = get_global_id(0);
  int4 tmp = as_int4(src[tid]);
  dst[tid] = tmp;
}
