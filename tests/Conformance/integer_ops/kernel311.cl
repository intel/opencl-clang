// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort16 *sourceA,
                          __global ushort16 *sourceB,
                          __global ushort16 *sourceC,
                          __global ushort16 *destValues) {
  int tid = get_global_id(0);
  ushort16 sA = sourceA[tid];
  ushort16 sB = sourceB[tid];
  ushort16 sC = sourceC[tid];
  ushort16 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
