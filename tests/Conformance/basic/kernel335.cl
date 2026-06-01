// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_ulong2(__global ulong2 *srcA, __global ulong *dst) {
  int tid = get_global_id(0);

  ulong tmp = ((ulong2)(srcA[tid].s0, srcA[tid].s1)).even;
  dst[tid] = tmp;
}
