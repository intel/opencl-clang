// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fpmul(__global float *srcA, __global float *srcB,
                         __global float *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid];
}
