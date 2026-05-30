// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_ulong3(__global ulong3 *srcA, __global ulong2 *dst) {
  int tid = get_global_id(0);

  ulong2 tmp = srcA[tid].even;
  dst[tid] = tmp;
}
