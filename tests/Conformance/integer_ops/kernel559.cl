// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_ulong2(__global ulong2 *srcA, __global ulong2 *dst) {
  int tid = get_global_id(0);

  ulong2 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
