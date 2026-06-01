// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_long_mad4(__global long4 *srcA, __global long4 *srcB,
                             __global long4 *srcC, __global long4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid] + srcC[tid];
}
