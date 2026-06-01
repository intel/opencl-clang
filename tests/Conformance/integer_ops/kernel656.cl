// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_ulong3(__global ulong *srcA, __global ulong *srcB,
                                  __global ulong *dst) {
  int tid = get_global_id(0);

  ulong3 tmp = add_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
