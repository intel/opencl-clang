// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_clamp(__global float16 *x, __global float16 *minval,
                         __global float16 *maxval, __global float16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = clamp(x[tid], minval[tid], maxval[tid]);
}
