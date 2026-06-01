// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_short16(__global short16 *srcA, __global short8 *dst) {
  int tid = get_global_id(0);

  short8 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
