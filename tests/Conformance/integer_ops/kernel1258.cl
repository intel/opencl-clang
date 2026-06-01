// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_uint8_mad24(__global uint8 *srcA, __global uint8 *srcB,
                               __global uint8 *srcC, __global uint8 *dst) {
  uint tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
