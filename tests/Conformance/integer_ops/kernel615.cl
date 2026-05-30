// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_char4(__global char4 *srcA, __global char4 *srcB,
                                 __global char4 *dst) {
  int tid = get_global_id(0);

  char4 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
