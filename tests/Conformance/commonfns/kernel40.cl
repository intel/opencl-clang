// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fmin16(__global float16 *srcA, __global float16 *srcB,
                          __global float16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = fmin(srcA[tid], srcB[tid]);
}
