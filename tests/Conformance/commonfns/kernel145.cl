// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sign8(__global float8 *src, __global float8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = sign(src[tid]);
}
