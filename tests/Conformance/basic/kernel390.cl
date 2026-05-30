// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_float8(__global float8 *srcA, __global float4 *dst) {
  int tid = get_global_id(0);

  float4 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
