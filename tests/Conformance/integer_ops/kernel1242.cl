// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_int_mul24(__global uint *srcA, __global uint *srcB,
                             __global uint *dst) {
  int tid = get_global_id(0);

  dst[tid] = mul24(srcA[tid], srcB[tid]);
}
