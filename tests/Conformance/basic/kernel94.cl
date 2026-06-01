// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_uchar2(__global uchar2 *srcA, __global uchar *dst) {
  int tid = get_global_id(0);

  uchar tmp = srcA[tid].even;
  dst[tid] = tmp;
}
