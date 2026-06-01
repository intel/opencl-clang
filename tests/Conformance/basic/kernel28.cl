// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_long_mul2(__global long2 *srcA, __global long2 *srcB,
                             __global long2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid];
}
