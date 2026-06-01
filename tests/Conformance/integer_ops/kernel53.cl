// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char16 *sourceA, __global char16 *sourceB,
                          __global char16 *destValues) {
  int tid = get_global_id(0);
  char16 sA = sourceA[tid];
  char16 sB = sourceB[tid];
  char16 dst = hadd(sA, sB);
  destValues[tid] = dst;
}
