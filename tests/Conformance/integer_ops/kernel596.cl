// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_absdiff_uint3(__global uint *srcA, __global uint *srcB,
                                 __global uint *dst) {
  int tid = get_global_id(0);

  uint3 sA, sB;
  sA = vload3(tid, srcA);
  sB = vload3(tid, srcB);
  uint3 dstVal = abs_diff(sA, sB);
  vstore3(dstVal, tid, dst);
}
