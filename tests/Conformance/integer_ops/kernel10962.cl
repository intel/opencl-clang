// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global ushort *srcA, __global ushort *srcB,
                   __global ushort *dst) {
  int tid = get_global_id(0);

  dst[tid] = srcA[tid] != srcB[tid];
}
