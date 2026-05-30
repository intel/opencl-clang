// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float2 *x, __global float *y,
                      __global float2 *dst) {
  int tid = get_global_id(0);

  dst[tid] = min(x[tid], y[tid]);
}
