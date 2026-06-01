// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_long2(__global long2 *srcA, __global long2 *srcB,
                                 __global long2 *dst) {
  int tid = get_global_id(0);

  long2 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
