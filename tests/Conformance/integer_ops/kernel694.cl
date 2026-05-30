// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_uint8(__global uint8 *srcA, __global uint8 *srcB,
                                 __global uint8 *dst) {
  int tid = get_global_id(0);

  uint8 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
