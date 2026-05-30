// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_char4(__global char4 *srcA, __global char2 *dst) {
  int tid = get_global_id(0);

  char2 tmp =
      ((char4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).even;
  dst[tid] = tmp;
}
