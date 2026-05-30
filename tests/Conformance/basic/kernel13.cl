// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int_mad(__global int *srcA, __global int *srcB,
                           __global int *srcC, __global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid] + srcC[tid];
}
