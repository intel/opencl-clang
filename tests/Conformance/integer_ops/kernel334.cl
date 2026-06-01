// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong8 *sourceA, __global ulong8 *sourceB,
                          __global ulong8 *sourceC,
                          __global ulong8 *destValues) {
  int tid = get_global_id(0);
  ulong8 sA = sourceA[tid];
  ulong8 sB = sourceB[tid];
  ulong8 sC = sourceC[tid];
  ulong8 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
