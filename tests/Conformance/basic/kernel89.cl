// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_uchar4(__global uchar4 *srcA, __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 tmp =
      ((uchar4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).lo;
  dst[tid] = tmp;
}
