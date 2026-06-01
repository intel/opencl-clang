// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_uchar3(__global uchar3 *srcA, __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 tmp = srcA[tid].lo;
  dst[tid] = tmp;
}
