// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint4 *sourceA, __global uint4 *sourceB,
                          __global uint4 *destValues) {
  int tid = get_global_id(0);
  uint4 sA = sourceA[tid];
  uint4 sB = sourceB[tid];
  uint4 dst = hadd(sA, sB);
  destValues[tid] = dst;
}
