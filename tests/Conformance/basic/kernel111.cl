// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_uchar8(__global uchar8 *srcA, __global uchar4 *dst) {
  int tid = get_global_id(0);

  uchar4 tmp =
      ((uchar8)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7))
          .odd;
  dst[tid] = tmp;
}
