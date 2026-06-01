// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_step16(__global float16 *srcA, __global float16 *srcB,
                          __global float16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = step(srcA[tid], srcB[tid]);
}
