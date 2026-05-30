// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_ulong3(__global ulong *srcA, __global ulong *dst) {
  int tid = get_global_id(0);

  ulong3 sA;
  sA = vload3(tid, srcA);
  ulong3 dstVal = popcount(sA);
  vstore3(dstVal, tid, dst);
}
