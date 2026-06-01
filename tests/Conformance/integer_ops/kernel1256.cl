// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_uint3_mad24(__global uint *srcA, __global uint *srcB,
                               __global uint *srcC, __global uint *dst) {
  int tid = get_global_id(0);
  uint3 tmp = mad24(vload3(tid, srcA), vload3(tid, srcB), vload3(tid, srcC));
  vstore3(tmp, tid, dst);
}
