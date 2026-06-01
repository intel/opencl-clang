// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_uint2_mad24(__global uint2 *srcA, __global uint2 *srcB,
                               __global uint2 *srcC, __global uint2 *dst) {
  uint tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
