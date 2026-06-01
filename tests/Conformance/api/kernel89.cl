// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char4 *src1, __global int4 *src2,
                          __global char8 *src3, __global char4 *dst1,
                          __global int4 *dst2, __global char8 *dst3) {
  int tid = get_global_id(0);
  dst1[tid] = src1[tid];
  dst2[tid] = src2[tid];
  dst3[tid] = src3[tid];
}
