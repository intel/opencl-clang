// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char *sourceA, __global char *sourceB,
                          __global char *sourceC, __global char *destValues) {
  int tid = get_global_id(0);
  char sA = sourceA[tid];
  char sB = sourceB[tid];
  char sC = sourceC[tid];
  char dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
