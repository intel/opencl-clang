// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_long8(__global long8 *srcA, __global long8 *srcB,
                                 __global long8 *dst) {
  int tid = get_global_id(0);

  long8 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
