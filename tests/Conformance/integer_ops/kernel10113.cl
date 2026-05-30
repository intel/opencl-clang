// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_popcount_ushort4(__global ushort4 *srcA,
                                    __global ushort4 *dst) {
  int tid = get_global_id(0);

  ushort4 sA;
  sA = srcA[tid];
  ushort4 dstVal = popcount(sA);
  dst[tid] = dstVal;
}
