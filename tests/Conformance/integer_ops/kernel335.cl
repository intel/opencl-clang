// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong16 *sourceA, __global ulong16 *sourceB,
                          __global ulong16 *sourceC,
                          __global ulong16 *destValues) {
  int tid = get_global_id(0);
  ulong16 sA = sourceA[tid];
  ulong16 sB = sourceB[tid];
  ulong16 sC = sourceC[tid];
  ulong16 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
