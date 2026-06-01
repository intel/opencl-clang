// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_int4(__global int4 *srcA, __global int4 *srcB,
                                __global int4 *dst) {
  int tid = get_global_id(0);

  int4 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
