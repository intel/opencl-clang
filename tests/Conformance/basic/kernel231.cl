// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_int8(__global int8 *srcA, __global int4 *dst) {
  int tid = get_global_id(0);

  int4 tmp = ((int8)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                     srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7))
                 .odd;
  dst[tid] = tmp;
}
