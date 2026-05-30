// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_long4(__global long4 *srcA, __global ulong4 *dst) {
  int tid = get_global_id(0);

  ulong4 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
