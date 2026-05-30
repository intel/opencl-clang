// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_char16(__global char16 *srcA, __global char16 *srcB,
                                  __global char16 *dst) {
  int tid = get_global_id(0);

  char16 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
