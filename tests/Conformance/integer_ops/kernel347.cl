// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar16 *sourceA, __global uchar16 *sourceB,
                          __global uchar16 *sourceC,
                          __global uchar16 *destValues) {
  int tid = get_global_id(0);
  uchar16 sA = sourceA[tid];
  uchar16 sB = sourceB[tid];
  uchar16 sC = sourceC[tid];
  uchar16 dst = mad_hi(sA, sB, sC);
  destValues[tid] = dst;
}
