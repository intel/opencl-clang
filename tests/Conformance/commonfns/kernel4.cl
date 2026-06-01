// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_clamp(__global float4 *x, __global float4 *minval,
                         __global float4 *maxval, __global float4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = clamp(x[tid], minval[tid], maxval[tid]);
}
