// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_char8(__global char8 *srcA, __global uchar8 *dst) {
  int tid = get_global_id(0);

  uchar8 tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
