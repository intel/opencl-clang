// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_clamp(__global float *x, __global float *minval,
                         __global float *maxval, __global float *dst) {
  int tid = get_global_id(0);

  vstore3(clamp(vload3(tid, x), vload3(tid, minval), vload3(tid, maxval)), tid,
          dst);
}
