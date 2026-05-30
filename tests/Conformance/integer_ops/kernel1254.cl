// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_uint_mad24(__global uint *srcA, __global uint *srcB,
                              __global uint *srcC, __global uint *dst) {
  uint tid = get_global_id(0);

  dst[tid] = mad24(srcA[tid], srcB[tid], srcC[tid]);
}
