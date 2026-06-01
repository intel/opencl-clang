// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_int2(__global int2 *srcA, __global int2 *srcB,
                                __global int2 *dst) {
  int tid = get_global_id(0);

  int2 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
