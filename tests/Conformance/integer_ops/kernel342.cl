// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar *sourceA, __global uchar *sourceB,
                          __global uchar *sourceC, __global uchar *destValues) {
  int tid = get_global_id(0);
  uchar sA = sourceA[tid];
  uchar sB = sourceB[tid];
  uchar sC = sourceC[tid];
  uchar dst = mad_hi(sA, sB, sC);
  destValues[tid] = dst;
}
