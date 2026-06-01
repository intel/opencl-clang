// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_char2(__global char2 *srcA, __global char *dst) {
  int tid = get_global_id(0);

  char tmp = ((char2)(srcA[tid].s0, srcA[tid].s1)).even;
  dst[tid] = tmp;
}
