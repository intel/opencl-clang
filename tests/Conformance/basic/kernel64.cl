// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_char2(__global char2 *srcA, __global char *dst) {
  int tid = get_global_id(0);

  char tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
