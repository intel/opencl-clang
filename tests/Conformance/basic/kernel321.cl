// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_ulong8(__global ulong8 *srcA, __global ulong4 *dst) {
  int tid = get_global_id(0);

  ulong4 tmp =
      ((ulong8)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7))
          .hi;
  dst[tid] = tmp;
}
