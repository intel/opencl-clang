// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_ulong2(__global ulong2 *srcA, __global ulong *dst) {
  int tid = get_global_id(0);

  ulong tmp = srcA[tid].even;
  dst[tid] = tmp;
}
