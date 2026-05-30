// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_long_mad(__global long *srcA, __global long *srcB,
                            __global long *srcC, __global long *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid] + srcC[tid];
}
