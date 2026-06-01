// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_uint2(__global uint2 *srcA, __global uint *dst) {
  int tid = get_global_id(0);

  uint tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
