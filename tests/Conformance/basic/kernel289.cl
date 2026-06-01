// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_long4(__global long4 *srcA, __global long2 *dst) {
  int tid = get_global_id(0);

  long2 tmp =
      ((long4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).lo;
  dst[tid] = tmp;
}
