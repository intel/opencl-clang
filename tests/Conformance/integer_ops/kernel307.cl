// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort2 *sourceA, __global ushort2 *sourceB,
                          __global ushort2 *sourceC,
                          __global ushort2 *destValues) {
  int tid = get_global_id(0);
  ushort2 sA = sourceA[tid];
  ushort2 sB = sourceB[tid];
  ushort2 sC = sourceC[tid];
  ushort2 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
