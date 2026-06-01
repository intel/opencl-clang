// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_char2(__global char2 *srcA, __global char2 *srcB,
                                 __global char2 *dst) {
  int tid = get_global_id(0);

  char2 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
