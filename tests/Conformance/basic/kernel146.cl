// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_short3(__global short3 *srcA, __global short2 *dst) {
  int tid = get_global_id(0);

  short2 tmp = srcA[tid].odd;
  dst[tid] = tmp;
}
