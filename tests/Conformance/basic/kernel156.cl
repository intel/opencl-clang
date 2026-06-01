// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_ushort3(__global ushort3 *srcA, __global ushort2 *dst) {
  int tid = get_global_id(0);

  ushort2 tmp = srcA[tid].hi;
  dst[tid] = tmp;
}
