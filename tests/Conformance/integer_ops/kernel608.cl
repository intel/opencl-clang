// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ulong3(__global ulong *srcA, __global ulong *srcB,
                                  __global ulong *dst) {
  int tid = get_global_id(0);

  ulong3 sA, sB;
  sA = vload3(tid, srcA);
  sB = vload3(tid, srcB);
  ulong3 dstVal = abs_diff(sA, sB);
  vstore3(dstVal, tid, dst);
}
