// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_ushort16(__global ushort16 *srcA,
                                    __global ushort16 *srcB,
                                    __global ushort16 *dst) {
  int tid = get_global_id(0);

  ushort16 tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
