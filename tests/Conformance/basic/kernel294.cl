// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_long2(__global long2 *srcA, __global long *dst) {
  int tid = get_global_id(0);

  long tmp = srcA[tid].even;
  dst[tid] = tmp;
}
