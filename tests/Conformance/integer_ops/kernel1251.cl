// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int4_mad24(__global int4 *srcA, __global int4 *srcB,
                              __global int4 *srcC, __global int4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
