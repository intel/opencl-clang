// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort4 *sourceA, __global ushort4 *sourceB,
                          __global ushort4 *sourceC,
                          __global ushort4 *destValues) {
  int tid = get_global_id(0);
  ushort4 sA = sourceA[tid];
  ushort4 sB = sourceB[tid];
  ushort4 sC = sourceC[tid];
  ushort4 dst = mad_sat(sA, sB, sC);
  destValues[tid] = dst;
}
