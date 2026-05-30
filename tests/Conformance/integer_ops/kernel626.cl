// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_short3(__global short *srcA, __global short *srcB,
                                  __global short *dst) {
  int tid = get_global_id(0);

  short3 tmp = add_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
