// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global long8 *src, __global int16 *dst) {
  int tid = get_global_id(0);
  int16 tmp = as_int16(src[tid]);
  dst[tid] = tmp;
}
