// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_uchar16(__global uchar16 *srcA, __global uchar8 *dst) {
  int tid = get_global_id(0);

  uchar8 tmp =
      ((uchar16)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                 srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7,
                 srcA[tid].s8, srcA[tid].s9, srcA[tid].sA, srcA[tid].sB,
                 srcA[tid].sC, srcA[tid].sD, srcA[tid].sE, srcA[tid].sf))
          .odd;
  dst[tid] = tmp;
}
