// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int *sourceA, __global int *destValues) {
  int tid = get_global_id(0);
  int8 tmp = vload8(tid, destValues);
  tmp /= (vload8(tid, sourceA));
  vstore8(tmp, tid, destValues);
}
