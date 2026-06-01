// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_ulong(__global ulong *srcA, __global ulong *srcB,
                                 __global ulong *dst) {
  int tid = get_global_id(0);

  ulong tmp = add_sat(srcA[tid], srcB[tid]);
  dst[tid] = tmp;
}
