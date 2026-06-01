// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global uint2 *srcA, __global uint2 *srcB,
                   __global uint2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] | srcB[tid];
}
