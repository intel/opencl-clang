// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_uchar16(__global uchar16 *srcA,
                                   __global uchar16 *srcB,
                                   __global uchar16 *dst) {
  int tid = get_global_id(0);

  uchar16 tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
