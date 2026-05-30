// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_char3(__global char *srcA, __global char *srcB,
                                 __global char *dst) {
  int tid = get_global_id(0);

  char3 tmp = add_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
