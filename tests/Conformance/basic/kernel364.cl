// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_float2(__global float2 *srcA, __global float *dst) {
  int tid = get_global_id(0);

  float tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
