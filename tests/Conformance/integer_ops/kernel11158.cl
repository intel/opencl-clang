// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global uchar8 *srcA, __global uchar8 *srcB,
                   __global uchar8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = ~srcA[tid];
}
