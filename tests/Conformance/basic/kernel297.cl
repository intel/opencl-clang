// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_long3(__global long3 *srcA, __global long2 *dst) {
  int tid = get_global_id(0);

  long2 tmp = ((long3)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2)).even;
  dst[tid] = tmp;
}
