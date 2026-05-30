// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_int4(__global int4 *srcA, __global int2 *dst) {
  int tid = get_global_id(0);

  int2 tmp =
      ((int4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).odd;
  dst[tid] = tmp;
}
