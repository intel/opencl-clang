// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long2 *sourceA, __global long2 *sourceB,
                          __global long2 *destValues) {
  int tid = get_global_id(0);
  long2 sA = sourceA[tid];
  long2 sB = sourceB[tid];
  long2 dst = hadd(sA, sB);
  destValues[tid] = dst;
}
