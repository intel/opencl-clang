// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_uint2(__global uint2 *srcA, __global uint2 *dst) {
  int tid = get_global_id(0);

  uint2 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
