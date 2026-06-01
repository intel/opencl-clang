// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_long3(__global long *srcA, __global long *srcB,
                                 __global long *dst) {
  int tid = get_global_id(0);

  long3 tmp = sub_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
