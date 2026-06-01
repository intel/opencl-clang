// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float *sourceA, __global float *sourceB,
                          __global float *destValues) {
  int tid = get_global_id(0);
  vstore3(cross(vload3(tid, sourceA), vload3(tid, sourceB)), tid, destValues);
}
