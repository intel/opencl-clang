// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong2 *sourceA, __global ulong2 *sourceB,
                          __global ulong2 *sourceC,
                          __global ulong2 *destValues) {
  int tid = get_global_id(0);
  ulong2 sA = sourceA[tid];
  ulong2 sB = sourceB[tid];
  ulong2 sC = sourceC[tid];
  ulong2 dst = mad_hi(sA, sB, sC);
  destValues[tid] = dst;
}
