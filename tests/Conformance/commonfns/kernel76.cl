// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float4 *x, __global float4 *y,
                      __global float4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = min(x[tid], y[tid]);
}
