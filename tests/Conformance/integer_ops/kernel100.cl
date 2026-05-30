// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char8 *sourceA, __global char8 *sourceB,
                          __global char8 *destValues) {
  int tid = get_global_id(0);
  char8 sA = sourceA[tid];
  char8 sB = sourceB[tid];
  char8 dst = rhadd(sA, sB);
  destValues[tid] = dst;
}
