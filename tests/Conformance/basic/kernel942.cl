// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char4 *src, __global int *dst) {
  int tid = get_global_id(0);
  int tmp = as_int(src[tid]);
  dst[tid] = tmp;
}
