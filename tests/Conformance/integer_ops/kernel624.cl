// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_short(__global short *srcA, __global short *srcB,
                                 __global short *dst) {
  int tid = get_global_id(0);

  short tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
