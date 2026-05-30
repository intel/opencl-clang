// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_ushort2(__global ushort2 *srcA, __global ushort *dst) {
  int tid = get_global_id(0);

  ushort tmp = ((ushort2)(srcA[tid].s0, srcA[tid].s1)).even;
  dst[tid] = tmp;
}
