// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_short(__global short *srcA, __global ushort *dst) {
  int tid = get_global_id(0);

  ushort tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
