// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong *sourceA, __global ulong *sourceB,
                          __global ulong *sourceC, __global ulong *destValues) {
  int tid = get_global_id(0);
  ulong sA = sourceA[tid];
  ulong sB = sourceB[tid];
  ulong sC = sourceC[tid];
  ulong dst = clamp(sA, sB, sC);
  destValues[tid] = dst;
}
