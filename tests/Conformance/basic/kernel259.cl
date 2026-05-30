// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_uint4(__global uint4 *srcA, __global uint2 *dst) {
  int tid = get_global_id(0);

  uint2 tmp =
      ((uint4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).even;
  dst[tid] = tmp;
}
