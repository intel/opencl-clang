// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char2 *sourceA, __global char2 *sourceB,
                          __global char2 *destValues) {
  int tid = get_global_id(0);
  char2 sA = sourceA[tid];
  char2 sB = sourceB[tid];
  char2 dst = mul_hi(sA, sB);
  destValues[tid] = dst;
}
