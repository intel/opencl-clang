// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_float3(__global float3 *srcA, __global float2 *dst) {
  int tid = get_global_id(0);

  float2 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
