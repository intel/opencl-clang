// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float *x, __global float *y,
                      __global float *dst) {
  int tid = get_global_id(0);

  vstore3(min(vload3(tid, x), vload3(tid, y)), tid, dst);
}
