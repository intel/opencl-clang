// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_ulong16(__global ulong16 *srcA, __global ulong8 *dst) {
  int tid = get_global_id(0);

  ulong8 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
