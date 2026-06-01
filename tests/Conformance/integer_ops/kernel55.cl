// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar2 *sourceA, __global uchar2 *sourceB,
                          __global uchar2 *destValues) {
  int tid = get_global_id(0);
  uchar2 sA = sourceA[tid];
  uchar2 sB = sourceB[tid];
  uchar2 dst = hadd(sA, sB);
  destValues[tid] = dst;
}
