// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int *sourceA, __global int *sourceB,
                          __global int *destValues) {
  int tid = get_global_id(0);
  int sA = sourceA[tid];
  int sB = sourceB[tid];
  int dst = mul_hi(sA, sB);
  destValues[tid] = dst;
}
