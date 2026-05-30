// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_odd_uchar2(__global uchar2 *srcA, __global uchar *dst) {
  int tid = get_global_id(0);

  uchar tmp = ((uchar2)(srcA[tid].s0, srcA[tid].s1)).odd;
  dst[tid] = tmp;
}
