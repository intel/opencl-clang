// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_uchar16(__global uchar16 *srcA, __global uchar16 *dst) {
  int tid = get_global_id(0);

  uchar16 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
