// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int8 *sourceA, __global int8 *sourceB,
                          __global int8 *sourceC, __global int8 *destValues) {
  int tid = get_global_id(0);
  int8 sA = sourceA[tid];
  int8 sB = sourceB[tid];
  int8 sC = sourceC[tid];
  int8 dst = clamp(sA, sB, sC);
  destValues[tid] = dst;
}
