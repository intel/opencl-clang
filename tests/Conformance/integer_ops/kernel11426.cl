// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char /**/ *srcA, __global char /*3*/ *srcB,
                   __global char /*3*/ *dst) {
  int tid = get_global_id(0);

  vstore3(srcA[tid] != vload3(tid, srcB), tid, dst);
}
