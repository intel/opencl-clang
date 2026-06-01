// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char4 *sourceA, __global char4 *sourceB,
                          __global char4 *destValues) {
  int tid = get_global_id(0);
  char4 sA = sourceA[tid];
  char4 sB = sourceB[tid];
  char4 dst = min(sA, sB);
  destValues[tid] = dst;
}
