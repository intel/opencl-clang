// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_long2(__global long2 *srcA, __global long *dst) {
  int tid = get_global_id(0);

  long tmp = ((long2)(srcA[tid].s0, srcA[tid].s1)).lo;
  dst[tid] = tmp;
}
