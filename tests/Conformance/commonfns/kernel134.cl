// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_smoothstep2(__global float2 *edge0, __global float2 *edge1,
                               __global float2 *x, __global float2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = smoothstep(edge0[tid], edge1[tid], x[tid]);
}
