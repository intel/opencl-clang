// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong *sourceA, __global ulong *sourceB,
                          __global ulong *destValues) {
  int tid = get_global_id(0);
  ulong sA = sourceA[tid];
  ulong sB = sourceB[tid];
  ulong dst = min(sA, sB);
  destValues[tid] = dst;
}
