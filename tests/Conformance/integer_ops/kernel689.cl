// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_int16(__global int16 *srcA, __global int16 *srcB,
                                 __global int16 *dst) {
  int tid = get_global_id(0);

  int16 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
