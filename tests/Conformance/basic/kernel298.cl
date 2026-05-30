// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_long4(__global long4 *srcA, __global long2 *dst) {
  int tid = get_global_id(0);

  long2 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
