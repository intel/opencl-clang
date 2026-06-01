// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_int8(__global int8 *srcA, __global int4 *dst) {
  int tid = get_global_id(0);

  int4 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
