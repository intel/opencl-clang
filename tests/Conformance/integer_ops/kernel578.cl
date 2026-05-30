// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_short3(__global short *srcA, __global short *srcB,
                                  __global ushort *dst) {
  int tid = get_global_id(0);

  short3 sA, sB;
  sA = vload3(tid, srcA);
  sB = vload3(tid, srcB);
  ushort3 dstVal = abs_diff(sA, sB);
  vstore3(dstVal, tid, dst);
}
