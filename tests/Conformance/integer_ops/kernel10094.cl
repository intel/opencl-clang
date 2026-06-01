// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_char3(__global char *srcA, __global char *dst) {
  int tid = get_global_id(0);

  char3 sA;
  sA = vload3(tid, srcA);
  char3 dstVal = popcount(sA);
  vstore3(dstVal, tid, dst);
}
