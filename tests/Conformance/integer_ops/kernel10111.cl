// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_ushort2(__global ushort2 *srcA,
                                    __global ushort2 *dst) {
  int tid = get_global_id(0);

  ushort2 sA;
  sA = srcA[tid];
  ushort2 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
