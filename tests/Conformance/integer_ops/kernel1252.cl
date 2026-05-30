// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int8_mad24(__global int8 *srcA, __global int8 *srcB,
                              __global int8 *srcC, __global int8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
