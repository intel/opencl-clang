// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short4 *sourceA, __global short4 *sourceB,
                          __global short4 *sourceC,
                          __global short4 *destValues) {
  int tid = get_global_id(0);
  short4 sA = sourceA[tid];
  short4 sB = sourceB[tid];
  short4 sC = sourceC[tid];
  short4 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
