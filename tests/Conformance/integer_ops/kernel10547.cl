// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global int16 *srcA, __global int16 *srcB,
                   __global int16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] == srcB[tid];
}
