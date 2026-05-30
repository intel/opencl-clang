// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int4_mul24(__global uint4 *srcA, __global uint4 *srcB,
                              __global uint4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = mul24(srcA[tid], srcB[tid]);
}
