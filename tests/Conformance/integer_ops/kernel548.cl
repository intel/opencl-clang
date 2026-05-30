// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_ushort3(__global ushort *srcA, __global ushort *dst) {
  int tid = get_global_id(0);

  ushort3 tmp = abs(vload3(tid, srcA));
  vstore3(tmp, tid, dst);
}
