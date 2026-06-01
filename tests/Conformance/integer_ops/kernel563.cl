// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_ulong16(__global ulong16 *srcA, __global ulong16 *dst) {
  int tid = get_global_id(0);

  ulong16 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
