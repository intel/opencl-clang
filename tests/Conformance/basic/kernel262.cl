// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_uint16(__global uint16 *srcA, __global uint8 *dst) {
  int tid = get_global_id(0);

  uint8 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
