// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_int(__global int *srcA, __global uint *dst) {
  int tid = get_global_id(0);

  uint tmp = abs(srcA[tid]);
  dst[tid] = tmp;
}
