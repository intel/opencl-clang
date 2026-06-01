// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long8 *sourceA, __global long8 *sourceB,
                          __global long8 *destValues) {
  int tid = get_global_id(0);
  long8 sA = sourceA[tid];
  long8 sB = sourceB[tid];
  long8 dst = mul_hi(sA, sB);
  destValues[tid] = dst;
}
