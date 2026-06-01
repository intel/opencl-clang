// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint *sourceA, __global uint *sourceB,
                          __global uint *sourceC, __global uint *destValues) {
  int tid = get_global_id(0);
  uint3 sA = vload3(tid, sourceA);
  uint3 sB = vload3(tid, sourceB);
  uint3 sC = vload3(tid, sourceC);
  uint3 dst = mad_hi(sA, sB, sC);
  vstore3(dst, tid, destValues);
}
