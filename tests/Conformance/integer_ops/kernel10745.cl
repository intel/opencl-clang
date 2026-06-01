// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global short16 *srcA, __global short16 *srcB,
                   __global short16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ~srcA[tid];
}
