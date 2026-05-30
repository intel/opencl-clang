// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_uchar(__global uchar *srcA, __global uchar *dst) {
  int tid = get_global_id(0);

  uchar tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
