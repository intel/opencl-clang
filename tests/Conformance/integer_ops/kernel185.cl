// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long16 *sourceA, __global long16 *sourceB,
                          __global long16 *destValues) {
  int tid = get_global_id(0);
  long16 sA = sourceA[tid];
  long16 sB = sourceB[tid];
  long16 dst = mul_hi(sA, sB);
  destValues[tid] = dst;
}
