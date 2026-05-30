// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uchar16(__global uchar16 *srcA, __global uchar8 *dst) {
  int tid = get_global_id(0);

  uchar8 tmp = srcA[tid].hi;
  dst[tid] = tmp;
}
