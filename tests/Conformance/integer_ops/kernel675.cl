// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_short4(__global short4 *srcA, __global short4 *srcB,
                                  __global short4 *dst) {
  int tid = get_global_id(0);

  short4 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
