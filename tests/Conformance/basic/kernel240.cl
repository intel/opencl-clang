// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uint8(__global uint8 *srcA, __global uint4 *dst) {
  int tid = get_global_id(0);

  uint4 tmp = srcA[tid].hi;
  dst[tid] = tmp;
}
