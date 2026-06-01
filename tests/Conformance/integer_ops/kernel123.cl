// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int4 *sourceA, __global int4 *sourceB,
                          __global int4 *destValues) {
  int tid = get_global_id(0);
  int4 sA = sourceA[tid];
  int4 sB = sourceB[tid];
  int4 dst = rhadd(sA, sB);
  destValues[tid] = dst;
}
