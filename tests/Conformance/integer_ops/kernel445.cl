// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short2 *sourceA, __global short2 *sourceB,
                          __global short2 *destValues) {
  int tid = get_global_id(0);
  short2 sA = sourceA[tid];
  short2 sB = sourceB[tid];
  short2 dst = max(sA, sB);
  destValues[tid] = dst;
}
