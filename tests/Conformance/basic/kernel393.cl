// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_float16(__global float16 *srcA, __global float8 *dst) {
  int tid = get_global_id(0);

  float8 tmp =
      ((float16)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                 srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7,
                 srcA[tid].s8, srcA[tid].s9, srcA[tid].sA, srcA[tid].sB,
                 srcA[tid].sC, srcA[tid].sD, srcA[tid].sE, srcA[tid].sf))
          .odd;
  dst[tid] = tmp;
}
