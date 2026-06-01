// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar4 *sourceA, __global uchar4 *sourceB,
                          __global uchar4 *destValues) {
  int tid = get_global_id(0);
  uchar4 sA = sourceA[tid];
  uchar4 sB = sourceB[tid];
  uchar4 dst = mul_hi(sA, sB);
  destValues[tid] = dst;
}
