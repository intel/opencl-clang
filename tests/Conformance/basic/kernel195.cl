// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_int2(__global int2 *srcA, __global int *dst) {
  int tid = get_global_id(0);

  int tmp = ((int2)(srcA[tid].s0, srcA[tid].s1)).hi;
  dst[tid] = tmp;
}
