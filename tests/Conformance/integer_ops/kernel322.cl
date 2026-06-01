// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint8 *sourceA, __global uint8 *sourceB,
                          __global uint8 *sourceC, __global uint8 *destValues) {
  int tid = get_global_id(0);
  uint8 sA = sourceA[tid];
  uint8 sB = sourceB[tid];
  uint8 sC = sourceC[tid];
  uint8 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
