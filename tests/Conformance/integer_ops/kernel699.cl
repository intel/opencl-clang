// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_long4(__global long4 *srcA, __global long4 *srcB,
                                 __global long4 *dst) {
  int tid = get_global_id(0);

  long4 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
