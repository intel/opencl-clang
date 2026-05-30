// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_char(__global char *srcA, __global char *srcB,
                                __global char *dst) {
  int tid = get_global_id(0);

  char tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
