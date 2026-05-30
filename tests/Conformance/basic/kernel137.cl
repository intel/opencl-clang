// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_short3(__global short3 *srcA, __global short2 *dst) {
  int tid = get_global_id(0);

  short2 tmp = ((short3)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2)).even;
  dst[tid] = tmp;
}
