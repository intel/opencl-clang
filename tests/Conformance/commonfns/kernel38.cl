// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fmin4(__global float4 *srcA, __global float4 *srcB,
                         __global float4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = fmin(srcA[tid], srcB[tid]);
}
