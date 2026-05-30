// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_step3(__global float *srcA, __global float *srcB,
                         __global float *dst) {
  int tid = get_global_id(0);

  vstore3(step(vload3(tid, srcA), vload3(tid, srcB)), tid, dst);
}
