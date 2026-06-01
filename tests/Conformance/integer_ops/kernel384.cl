// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char *sourceA, __global char *sourceB,
                          __global char *destValues) {
  int tid = get_global_id(0);
  char sA = sourceA[tid];
  char sB = sourceB[tid];
  char dst = min(sA, sB);
  destValues[tid] = dst;
}
