// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_smoothstep4f(__global float *edge0, __global float *edge1,
                                __global float4 *x, __global float4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = smoothstep(edge0[tid], edge1[tid], x[tid]);
}
