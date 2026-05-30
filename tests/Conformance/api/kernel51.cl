// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short2 *src1, __global int4 *src2,
                          __global float4 *src3, __global short2 *dst1,
                          __global int4 *dst2, __global float4 *dst3) {
  int tid = get_global_id(0);
  dst1[tid] = src1[tid];
  dst2[tid] = src2[tid];
  dst3[tid] = src3[tid];
}
