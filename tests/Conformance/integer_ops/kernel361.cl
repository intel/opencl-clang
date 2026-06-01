// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int2 *sourceA, __global int2 *sourceB,
                          __global int2 *sourceC, __global int2 *destValues) {
  int tid = get_global_id(0);
  int2 sA = sourceA[tid];
  int2 sB = sourceB[tid];
  int2 sC = sourceC[tid];
  int2 dst = mad_hi(sA, sB, sC);
  destValues[tid] = dst;
}
