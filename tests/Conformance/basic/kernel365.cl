// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_float2(__global float2 *srcA, __global float *dst) {
  int tid = get_global_id(0);

  float tmp = ((float2)(srcA[tid].s0, srcA[tid].s1)).lo;
  dst[tid] = tmp;
}
