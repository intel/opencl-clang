// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort8 *sourceA, __global ushort8 *sourceB,
                          __global ushort8 *sourceC,
                          __global ushort8 *destValues) {
  int tid = get_global_id(0);
  ushort8 sA = sourceA[tid];
  ushort8 sB = sourceB[tid];
  ushort8 sC = sourceC[tid];
  ushort8 dst = mad_hi(sA, sB, sC);
  destValues[tid] = dst;
}
