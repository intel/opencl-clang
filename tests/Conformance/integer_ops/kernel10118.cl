// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_int3(__global int *srcA, __global int *dst) {
  int tid = get_global_id(0);

  int3 sA;
  sA = vload3(tid, srcA);
  int3 dstVal = popcount(sA);
  vstore3(dstVal, tid, dst);
}
