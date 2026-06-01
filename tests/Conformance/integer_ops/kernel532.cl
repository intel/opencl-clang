// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_int8(__global int8 *srcA, __global uint8 *dst) {
  int tid = get_global_id(0);

  uint8 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
