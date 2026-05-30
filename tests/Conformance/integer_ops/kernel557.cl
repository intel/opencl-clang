// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_uint16(__global uint16 *srcA, __global uint16 *dst) {
  int tid = get_global_id(0);

  uint16 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
