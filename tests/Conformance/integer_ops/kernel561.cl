// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_ulong4(__global ulong4 *srcA, __global ulong4 *dst) {
  int tid = get_global_id(0);

  ulong4 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
