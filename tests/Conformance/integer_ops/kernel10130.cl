// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_long3(__global long *srcA, __global long *dst) {
  int tid = get_global_id(0);

  long3 sA;
  sA = vload3(tid, srcA);
  long3 dstVal = popcount(sA);
  vstore3(dstVal, tid, dst);
}
