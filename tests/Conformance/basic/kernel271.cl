// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_uint8(__global uint8 *srcA, __global uint4 *dst) {
  int tid = get_global_id(0);

  uint4 tmp = ((uint8)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                       srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7))
                  .odd;
  dst[tid] = tmp;
}
