// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uchar4(__global uchar4 *srcA, __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 tmp = srcA[tid].hi;
  dst[tid] = tmp;
}
