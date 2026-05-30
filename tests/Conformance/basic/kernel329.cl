// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_ulong4(__global ulong4 *srcA, __global ulong2 *dst) {
  int tid = get_global_id(0);

  ulong2 tmp =
      ((ulong4)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3)).lo;
  dst[tid] = tmp;
}
