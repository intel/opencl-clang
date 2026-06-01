// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int16 *sourceA, __global int16 *sourceB,
                          __global int16 *sourceC, __global int16 *destValues) {
  int tid = get_global_id(0);
  int16 sA = sourceA[tid];
  int16 sB = sourceB[tid];
  int16 sC = sourceC[tid];
  int16 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
