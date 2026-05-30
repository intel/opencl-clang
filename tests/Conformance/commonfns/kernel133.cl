// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_smoothstep(__global float *edge0, __global float *edge1,
                              __global float *x, __global float *dst) {
  int tid = get_global_id(0);

  dst[tid] = smoothstep(edge0[tid], edge1[tid], x[tid]);
}
