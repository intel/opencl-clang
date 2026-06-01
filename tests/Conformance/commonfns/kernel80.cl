// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float16 *x, __global float16 *y,
                      __global float16 *dst) {
  int tid = get_global_id(0);

  dst[tid] = min(x[tid], y[tid]);
}
