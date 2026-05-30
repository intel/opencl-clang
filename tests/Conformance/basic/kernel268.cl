// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_uint4(__global uint4 *srcA, __global uint2 *dst) {
  int tid = get_global_id(0);

  uint2 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
