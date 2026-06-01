// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_float2int(__global float *src, __global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = (int)src[tid];
}
