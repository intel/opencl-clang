// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sub_sat_int(__global int *srcA, __global int *srcB,
                               __global int *dst) {
  int tid = get_global_id(0);

  int tmp = sub_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
