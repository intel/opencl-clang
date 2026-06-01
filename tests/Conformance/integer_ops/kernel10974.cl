// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char *srcA, __global char *srcB,
                   __global char *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] - srcB[tid];
}
