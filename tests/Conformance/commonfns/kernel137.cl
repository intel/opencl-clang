// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_smoothstep16(__global float16 *edge0,
                                __global float16 *edge1, __global float16 *x,
                                __global float16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = smoothstep(edge0[tid], edge1[tid], x[tid]);
}
