// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_int3(__global int3 *srcA, __global int2 *dst) {
  int tid = get_global_id(0);

  int2 tmp = ((int3)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2)).odd;
  dst[tid] = tmp;
}
