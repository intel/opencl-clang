// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global int2 *srcA, __global int2 *srcB,
                   __global int2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = !srcA[tid];
}
