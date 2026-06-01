// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint *sourceA, __global uint *sourceB,
                          __global uint *destValues) {
  int tid = get_global_id(0);
  uint sA = sourceA[tid];
  uint sB = sourceB[tid];
  uint dst = hadd(sA, sB);
  destValues[tid] = dst;
}
