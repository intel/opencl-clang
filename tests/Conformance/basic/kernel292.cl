// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_long16(__global long16 *srcA, __global long8 *dst) {
  int tid = get_global_id(0);

  long8 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
