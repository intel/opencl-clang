// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_hi_uchar3(__global uchar3 *srcA, __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 tmp = ((uchar3)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2)).hi;
  dst[tid] = tmp;
}
