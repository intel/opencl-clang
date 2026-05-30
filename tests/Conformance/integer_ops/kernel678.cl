// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_ushort(__global ushort *srcA, __global ushort *srcB,
                                  __global ushort *dst) {
  int tid = get_global_id(0);

  ushort tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
