// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int *sourceA, __global int *sourceB,
                          __global int *destValues) {
  int tid = get_global_id(0);
  int3 sA = vload3(tid, sourceA);
  int3 sB = vload3(tid, sourceB);
  int3 dst = min(sA, sB);
  vstore3(dst, tid, destValues);
}
