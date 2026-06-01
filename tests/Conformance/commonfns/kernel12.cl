// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_degrees(__global float *src, __global float *dst) {
  int tid = get_global_id(0);

  dst[tid] = degrees(src[tid]);
}
