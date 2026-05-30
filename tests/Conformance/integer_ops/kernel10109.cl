// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_short16(__global short16 *srcA,
                                    __global short16 *dst) {
  int tid = get_global_id(0);

  short16 sA;
  sA = srcA[tid];
  short16 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
