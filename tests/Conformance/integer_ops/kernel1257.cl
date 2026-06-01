// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_uint4_mad24(__global uint4 *srcA, __global uint4 *srcB,
                               __global uint4 *srcC, __global uint4 *dst) {
  uint tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
