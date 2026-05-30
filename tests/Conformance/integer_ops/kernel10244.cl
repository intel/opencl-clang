// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global long /*3*/ *srcA, __global long /*3*/ *srcB,
                   __global long /*3*/ *dst) {
  int tid = get_global_id(0);

  vstore3(vload3(tid, srcA) < vload3(tid, srcB), tid, dst);
}
