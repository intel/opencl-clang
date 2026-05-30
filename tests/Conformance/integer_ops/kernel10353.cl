// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global ulong4 *srcA, __global ulong4 *srcB,
                   __global ulong4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] >> srcB[tid];
}
