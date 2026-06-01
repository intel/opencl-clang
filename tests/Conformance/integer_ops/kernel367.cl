// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint2 *sourceA, __global uint2 *sourceB,
                          __global uint2 *sourceC, __global uint2 *destValues) {
  int tid = get_global_id(0);
  uint2 sA = sourceA[tid];
  uint2 sB = sourceB[tid];
  uint2 sC = sourceC[tid];
  uint2 dst = mad_hi(sA, sB, sC);
  destValues[tid] = dst;
}
