// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar8 *sourceA, __global uchar8 *sourceB,
                          __global uchar8 *destValues) {
  int tid = get_global_id(0);
  uchar8 sA = sourceA[tid];
  uchar8 sB = sourceB[tid];
  uchar8 dst = rhadd(sA, sB);
  destValues[tid] = dst;
}
