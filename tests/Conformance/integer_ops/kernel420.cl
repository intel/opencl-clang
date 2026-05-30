// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long *sourceA, __global long *sourceB,
                          __global long *destValues) {
  int tid = get_global_id(0);
  long sA = sourceA[tid];
  long sB = sourceB[tid];
  long dst = min(sA, sB);
  destValues[tid] = dst;
}
