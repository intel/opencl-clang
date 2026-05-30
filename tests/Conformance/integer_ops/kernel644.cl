// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_uint3(__global uint *srcA, __global uint *srcB,
                                 __global uint *dst) {
  int tid = get_global_id(0);

  uint3 tmp = add_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
