// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short8 *sourceA, __global short8 *sourceB,
                          __global short8 *sourceC,
                          __global short8 *destValues) {
  int tid = get_global_id(0);
  short8 sA = sourceA[tid];
  short8 sB = sourceB[tid];
  short8 sC = sourceC[tid];
  short8 dst = clamp(sA, sB, sC);
  destValues[tid] = dst;
}
