// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fmax3(__global float *srcA, __global float *srcB,
                         __global float *dst) {
  int tid = get_global_id(0);
  vstore3(fmax(vload3(tid, srcA), vload3(tid, srcB)), tid, dst);
}
