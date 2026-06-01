// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_step8(__global float8 *srcA, __global float8 *srcB,
                         __global float8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = step(srcA[tid], srcB[tid]);
}
