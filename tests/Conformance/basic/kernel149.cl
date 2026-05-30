// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_short4(__global short4 *srcA, __global short2 *dst) {
  int tid = get_global_id(0);

  short2 tmp =
      ((short4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).odd;
  dst[tid] = tmp;
}
