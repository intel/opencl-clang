// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_float16(__global float16 *srcA, __global float8 *dst) {
  int tid = get_global_id(0);

  float8 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
