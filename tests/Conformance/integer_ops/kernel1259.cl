// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_uint16_mad24(__global uint16 *srcA, __global uint16 *srcB,
                                __global uint16 *srcC, __global uint16 *dst) {
  uint tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
