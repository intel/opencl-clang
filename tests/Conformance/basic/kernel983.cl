// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar4 *src, __global float *dst) {
  int tid = get_global_id(0);
  float tmp = as_float(src[tid]);
  dst[tid] = tmp;
}
