// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int16_mul24(__global uint16 *srcA, __global uint16 *srcB,
                               __global uint16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = mul24(srcA[tid], srcB[tid]);
}
