// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_short8(__global short8 *srcA, __global short8 *srcB,
                                  __global short8 *dst) {
  int tid = get_global_id(0);

  short8 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
