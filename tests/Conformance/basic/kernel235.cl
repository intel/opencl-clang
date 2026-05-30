// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uint2(__global uint2 *srcA, __global uint *dst) {
  int tid = get_global_id(0);

  uint tmp = ((uint2)(srcA[tid].s0, srcA[tid].s1)).hi;
  dst[tid] = tmp;
}
