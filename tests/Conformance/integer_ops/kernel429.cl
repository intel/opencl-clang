// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong4 *sourceA, __global ulong4 *sourceB,
                          __global ulong4 *destValues) {
  int tid = get_global_id(0);
  ulong4 sA = sourceA[tid];
  ulong4 sB = sourceB[tid];
  ulong4 dst = min(sA, sB);
  destValues[tid] = dst;
}
