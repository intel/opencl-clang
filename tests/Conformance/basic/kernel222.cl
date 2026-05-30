// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_int16(__global int16 *srcA, __global int8 *dst) {
  int tid = get_global_id(0);

  int8 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
