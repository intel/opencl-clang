// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fmax16(__global float16 *srcA, __global float *srcB,
                          __global float16 *dst) {
  int tid = get_global_id(0);
  dst[tid] = fmax(srcA[tid], srcB[tid]);
}
