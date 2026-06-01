// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_even_char16(__global char16 *srcA, __global char8 *dst) {
  int tid = get_global_id(0);

  char8 tmp = ((char16)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                        srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7,
                        srcA[tid].s8, srcA[tid].s9, srcA[tid].sA, srcA[tid].sB,
                        srcA[tid].sC, srcA[tid].sD, srcA[tid].sE, srcA[tid].sf))
                  .even;
  dst[tid] = tmp;
}
