// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global short4 *srcA, __global short4 *srcB,
                   __global short4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] | srcB[tid];
}
