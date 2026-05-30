// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_lo_ushort8(__global ushort8 *srcA, __global ushort4 *dst) {
  int tid = get_global_id(0);

  ushort4 tmp =
      ((ushort8)(srcA[tid].s0, srcA[tid].s1, srcA[tid].s2, srcA[tid].s3,
                 srcA[tid].s4, srcA[tid].s5, srcA[tid].s6, srcA[tid].s7))
          .lo;
  dst[tid] = tmp;
}
