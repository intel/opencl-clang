// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_int8(__global int8 *srcA, __global int8 *srcB,
                                __global int8 *dst) {
  int tid = get_global_id(0);

  int8 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
