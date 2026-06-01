// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_uchar2(__global uchar2 *srcA, __global uchar2 *srcB,
                                  __global uchar2 *dst) {
  int tid = get_global_id(0);

  uchar2 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
