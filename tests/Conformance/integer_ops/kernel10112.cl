// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_ushort3(__global ushort *srcA,
                                    __global ushort *dst) {
  int tid = get_global_id(0);

  ushort3 sA;
  sA = vload3(tid, srcA);
  ushort3 dstVal = popcount(sA);
  vstore3(dstVal, tid, dst);
}
