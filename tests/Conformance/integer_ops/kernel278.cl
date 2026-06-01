// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long *sourceA, __global long *sourceB,
                          __global long *sourceC, __global long *destValues) {
  int tid = get_global_id(0);
  long3 sA = vload3(tid, sourceA);
  long3 sB = vload3(tid, sourceB);
  long3 sC = vload3(tid, sourceC);
  long3 dst = clamp(sA, sB, sC);
  vstore3(dst, tid, destValues);
}
