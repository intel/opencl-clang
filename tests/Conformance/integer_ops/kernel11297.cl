// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char /*3*/ *srcA, __global char /**/ *srcB,
                   __global char /*3*/ *dst) {
  int tid = get_global_id(0);

  vstore3(vload3(tid, srcA) & srcB[tid], tid, dst);
}
