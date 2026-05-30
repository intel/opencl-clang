// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_uint4(__global uint4 *srcA, __global uint4 *srcB,
                                 __global uint4 *dst) {
  int tid = get_global_id(0);

  uint4 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
