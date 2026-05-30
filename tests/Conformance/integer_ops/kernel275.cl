// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint16 *sourceA, __global uint16 *sourceB,
                          __global uint16 *sourceC,
                          __global uint16 *destValues) {
  int tid = get_global_id(0);
  uint16 sA = sourceA[tid];
  uint16 sB = sourceB[tid];
  uint16 sC = sourceC[tid];
  uint16 dst = clamp(sA, sB, sC);
  destValues[tid] = dst;
}
