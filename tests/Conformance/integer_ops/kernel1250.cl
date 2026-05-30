// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int3_mad24(__global int *srcA, __global int *srcB,
                              __global int *srcC, __global int *dst) {
  int tid = get_global_id(0);
  int3 tmp = mad24(vload3(tid, srcA), vload3(tid, srcB), vload3(tid, srcC));
  vstore3(tmp, tid, dst);
}
