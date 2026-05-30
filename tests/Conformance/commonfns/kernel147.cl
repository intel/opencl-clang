// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_sign3(__global float *src, __global float *dst) {
  int tid = get_global_id(0);

  vstore3(sign(vload3(tid, src)), tid, dst);
}
