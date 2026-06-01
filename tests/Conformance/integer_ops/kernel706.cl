// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_ulong8(__global ulong8 *srcA, __global ulong8 *srcB,
                                  __global ulong8 *dst) {
  int tid = get_global_id(0);

  ulong8 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
