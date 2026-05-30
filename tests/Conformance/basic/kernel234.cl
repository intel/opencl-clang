// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uint2(__global uint2 *srcA, __global uint *dst) {
  int tid = get_global_id(0);

  uint tmp = srcA[tid].hi;
  dst[tid] = tmp;
}
