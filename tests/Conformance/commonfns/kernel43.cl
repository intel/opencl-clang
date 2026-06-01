// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fmin2(__global float2 *srcA, __global float *srcB,
                         __global float2 *dst) {
  int tid = get_global_id(0);
  dst[tid] = fmin(srcA[tid], srcB[tid]);
}
