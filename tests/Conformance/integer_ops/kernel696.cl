// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_long(__global long *srcA, __global long *srcB,
                                __global long *dst) {
  int tid = get_global_id(0);

  long tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
