// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fpmul2(__global float2 *srcA, __global float2 *srcB,
                          __global float2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid];
}
