// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uint3(__global uint3 *srcA, __global uint2 *dst) {
  int tid = get_global_id(0);

  uint2 tmp = ((uint3)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2)).hi;
  dst[tid] = tmp;
}
