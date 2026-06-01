// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_uchar(__global uchar *srcA, __global uchar *srcB,
                                 __global uchar *dst) {
  int tid = get_global_id(0);

  uchar tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
