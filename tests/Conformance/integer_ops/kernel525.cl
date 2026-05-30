// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_short4(__global short4 *srcA, __global ushort4 *dst) {
  int tid = get_global_id(0);

  ushort4 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
