// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_uint(__global uint *srcA, __global uint *srcB,
                                __global uint *dst) {
  int tid = get_global_id(0);

  uint tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
