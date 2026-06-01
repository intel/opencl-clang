// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short *sourceA, __global short *sourceB,
                          __global short *sourceC, __global short *destValues) {
  int tid = get_global_id(0);
  short sA = sourceA[tid];
  short sB = sourceB[tid];
  short sC = sourceC[tid];
  short dst = clamp(sA, sB, sC);
  destValues[tid] = dst;
}
