// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_ushort3(__global ushort *srcA, __global ushort *srcB,
                                   __global ushort *dst) {
  int tid = get_global_id(0);

  ushort3 sA, sB;
  sA = vload3(tid, srcA);
  sB = vload3(tid, srcB);
  ushort3 dstVal = abs_diff(sA, sB);
  vstore3(dstVal, tid, dst);
}
