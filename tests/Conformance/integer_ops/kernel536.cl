// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_long3(__global long *srcA, __global ulong *dst) {
  int tid = get_global_id(0);

  ulong3 tmp = abs(vload3(tid, srcA));
  vstore3(tmp, tid, dst);
}
