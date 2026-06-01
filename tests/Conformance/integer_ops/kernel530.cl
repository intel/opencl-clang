// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_int3(__global int *srcA, __global uint *dst) {
  int tid = get_global_id(0);

  uint3 tmp = abs(vload3(tid, srcA));
  vstore3(tmp, tid, dst);
}
