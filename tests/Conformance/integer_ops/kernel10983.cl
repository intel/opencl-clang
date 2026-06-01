// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char4 *srcA, __global char4 *srcB,
                   __global char4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] * srcB[tid];
}
