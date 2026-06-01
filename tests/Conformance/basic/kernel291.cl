// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_long8(__global long8 *srcA, __global long4 *dst) {
  int tid = get_global_id(0);

  long4 tmp = ((long8)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                       srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7))
                  .lo;
  dst[tid] = tmp;
}
