// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_char3(__global char *srcA, __global char *srcB,
                                 __global uchar *dst) {
  int tid = get_global_id(0);

  char3 sA, sB;
  sA = vload3(tid, srcA);
  sB = vload3(tid, srcB);
  uchar3 dstVal = abs_diff(sA, sB);
  vstore3(dstVal, tid, dst);
}
