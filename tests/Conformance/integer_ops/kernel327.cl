// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long4 *sourceA, __global long4 *sourceB,
                          __global long4 *sourceC, __global long4 *destValues) {
  int tid = get_global_id(0);
  long4 sA = sourceA[tid];
  long4 sB = sourceB[tid];
  long4 sC = sourceC[tid];
  long4 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
