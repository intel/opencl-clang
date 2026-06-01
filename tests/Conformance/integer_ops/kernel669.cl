// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_uchar4(__global uchar4 *srcA, __global uchar4 *srcB,
                                  __global uchar4 *dst) {
  int tid = get_global_id(0);

  uchar4 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
