// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_int3(__global int *srcA, __global int *srcB,
                                __global int *dst) {
  int tid = get_global_id(0);

  int3 tmp = add_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
