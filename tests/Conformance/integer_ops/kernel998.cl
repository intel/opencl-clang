// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char *sourceA, __global char *destValues) {
  int tid = get_global_id(0);
  char3 tmp = vload3(tid, destValues);
  tmp |= (vload3(tid, sourceA));
  vstore3(tmp, tid, destValues);
}
