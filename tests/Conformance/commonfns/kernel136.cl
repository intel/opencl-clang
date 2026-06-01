// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_smoothstep8(__global float8 *edge0, __global float8 *edge1,
                               __global float8 *x, __global float8 *dst) {
  int tid = get_global_id(0);

  dst[tid] = smoothstep(edge0[tid], edge1[tid], x[tid]);
}
