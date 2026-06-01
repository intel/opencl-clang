// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_char2(__global char2 *srcA, __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
